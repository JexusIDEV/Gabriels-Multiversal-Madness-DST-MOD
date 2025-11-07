local MakePlayerCharacter = require("prefabs/player_common")

local assets = {
}

TUNING.GABRIEL_EIPA_UNAE_HEALTH = 180
TUNING.GABRIEL_EIPA_UNAE_HUNGER = 160
TUNING.GABRIEL_EIPA_UNAE_SANITY = 200

TUNING.GABRIEL_EIPA_UNAE_HUNGER_MULT_FACTOR = .175

TUNING.GABRIEL_EIPA_UANE_SHADOW_CREATURE_PENALTY = {
	SHADOWWORKER = .05,
	SHADOWPROTECTOR = .05,
}

TUNING.GABRIEL_EIPA_UANE_READING_PENALTY_MULT = 1.25
TUNING.GABRIEL_EIPA_UANE_SHADOW_ITEM_RESISTANCE_DAPPERNESS = 2
TUNING.GABRIEL_EIPA_UNAE_CODEX_UMBRA_BOOK_MAX_SHADOW_CREATURES = 8

TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.GABRIEL_EIPA_UNAE = {
}

local start_inv = {}

for k, v in pairs(TUNING.GAMEMODE_STARTING_ITEMS) do
	start_inv[string.lower(k)] = v.WILSON
end

local prefabs = FlattenTree(start_inv, true)

local BOOK_MUST_TAGS = { "book", "shadowmagic" }
local BOOK_CANT_TAGS = { "INLIMBO", "fueldepleted" }
local function customidleanimfn(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
	for i, v in ipairs(TheSim:FindEntities(x, y, z, 3, BOOK_MUST_TAGS, BOOK_CANT_TAGS)) do
		if v.isfloating then
			--secret idle anim near floating codex umbra
			--takes priority over inst.customidlestate
			return "idle3_waxwell"
		end
	end
end

local function GetPointSpecialActions(inst, pos, useitem, right, usereticulepos)
	if right then
		if useitem == nil then
			local inventory = inst.replica.inventory
			if inventory ~= nil then
				useitem = inventory:GetEquippedItem(EQUIPSLOTS.HEAD)
			end
		end
		if useitem and
			useitem.prefab == "roseglasseshat" and
			useitem:HasTag("closeinspector")
		then
			--match ReticuleTargetFn
			if usereticulepos then
				local pos2 = Vector3()
				for r = 2.5, 1, -.25 do
					pos2.x, pos2.y, pos2.z = inst.entity:LocalToWorldSpace(r, 0, 0)
					if CLOSEINSPECTORUTIL.IsValidPos(inst, pos2) then
						return { ACTIONS.LOOKAT }, pos2
					end
				end
			end

			--default
			if CLOSEINSPECTORUTIL.IsValidPos(inst, pos) then
				return { ACTIONS.LOOKAT }
			end
		end
	end
	return {}
end

local function ReticuleTargetFn()
	local player = ThePlayer
	local ground = TheWorld.Map
	local pos = Vector3()
	for r = 2.5, 1, -.25 do
		pos.x, pos.y, pos.z = player.entity:LocalToWorldSpace(r, 0, 0)
		if CLOSEINSPECTORUTIL.IsValidPos(player, pos) then
			return pos
		end
	end
	pos.x, pos.y, pos.z = player.Transform:GetWorldPosition()
	return pos
end

local function OnSetOwner(inst)
	if inst.components.playeractionpicker then
		inst.components.playeractionpicker.pointspecialactionsfn = GetPointSpecialActions
	end
end

local function KillPet(pet)
	if pet.components.health:IsInvincible() then
		--reschedule
		pet._killtask = pet:DoTaskInTime(.5, KillPet)
	else
		pet.components.health:Kill()
	end
end

local function OnSpawnPet(inst, pet)
    if pet:HasTag("shadowminion") then
        if not (inst.components.health:IsDead() or inst:HasTag("playerghost")) then
			--if not inst.components.builder.freebuildmode then
	            inst.components.sanity:AddSanityPenalty(pet, TUNING.GABRIEL_EIPA_UANE_SHADOW_CREATURE_PENALTY[string.upper(pet.prefab)])
			--end
            inst:ListenForEvent("onremove", inst._onpetlost, pet)
            pet.components.skinner:CopySkinsFromPlayer(inst)
        elseif pet._killtask == nil then
            pet._killtask = pet:DoTaskInTime(math.random(), KillPet)
        end
    elseif inst._OnSpawnPet ~= nil then
        inst:_OnSpawnPet(pet)
    end
end

local function OnDespawnPet(inst, pet)
    if pet:HasTag("shadowminion") then
		if pet.components.inventory then --Because we can despawn without dying, e.g. 0 damage weapon from a maxwell which despawns us
			pet.components.inventory:DropEverything()
		end
		if not inst.is_snapshot_user_session and pet.sg ~= nil then
			pet.sg:GoToState("quickdespawn")
		else
			pet:Remove()
		end
    elseif inst._OnDespawnPet ~= nil then
        inst:_OnDespawnPet(pet)
    end
end

local function ReskinPet(pet, player, nofx)
    pet._dressuptask = nil
    if player:IsValid() then
        if not nofx then
            local x, y, z = pet.Transform:GetWorldPosition()
            local fx = SpawnPrefab("slurper_respawn")
            fx.Transform:SetPosition(x, y, z)
        end
        pet.components.skinner:CopySkinsFromPlayer(player)
    end
end

local function OnSkinsChanged(inst, data)
    for k, v in pairs(inst.components.petleash:GetPets()) do
        if v:HasTag("shadowminion") then
            if v._dressuptask ~= nil then
                v._dressuptask:Cancel()
                v._dressuptask = nil
            end
            if data and data.nofx then
                ReskinPet(v, inst, data.nofx)
            else
                v._dressuptask = v:DoTaskInTime(math.random()*0.5 + 0.25, ReskinPet, inst)
            end
        end
    end
end

local function OnDeath(inst)
    for k, v in pairs(inst.components.petleash:GetPets()) do
        if v:HasTag("shadowminion") and v._killtask == nil then
            v._killtask = v:DoTaskInTime(math.random(), KillPet)
        end
    end
end

local sanityRegeneration = function(inst)
	--if inst.components.health:IsDead() or inst:HasTag("playerghost") then return end
	local delta = 0

	if TheWorld.isday then
		delta = 1.25
	elseif TheWorld.isdusk then 
		delta = 0.6
	elseif TheWorld.isnight then
		delta = 0.0
	end

	return delta
end

local onBecameHuman = function(inst)
	-- Set speed when not a ghost (optional)
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "gabriel_eipa_unae_speed_mod", 1.2)
end

local function onBecameGhost(inst)
    inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "gabriel_eipa_unae_speed_mod")
	for k, v in pairs(inst.components.petleash:GetPets()) do
		if v:HasTag("shadowminion") then
			inst:RemoveEventCallback("onremove", inst._onpetlost, v)
			inst.components.sanity:RemoveSanityPenalty(v)
			if v._killtask == nil then
				v._killtask = v:DoTaskInTime(math.random(), KillPet)
			end
		end
	end
end

local function ForceDespawnShadowMinions(inst)
    local todespawn = {}
    for k, v in pairs(inst.components.petleash:GetPets()) do
        if v:HasTag("shadowminion") then
            table.insert(todespawn, v)
        end
    end
    for i, v in ipairs(todespawn) do
        inst.components.petleash:DespawnPet(v)
    end
end

local function OnDespawn(inst, migrationdata)
	if migrationdata ~= nil then
		ForceDespawnShadowMinions(inst)
	end
end

local SHADOWCREATURE_MUST_TAGS = { "shadowcreature", "_combat", "locomotor" }
local SHADOWCREATURE_CANT_TAGS = { "INLIMBO", "notaunt" }
local function OnReadFn(inst, book)
    if inst.components.sanity:IsInsane() then
        
        local x,y,z = inst.Transform:GetWorldPosition()
        local ents = TheSim:FindEntities(x, y, z, 16, SHADOWCREATURE_MUST_TAGS, SHADOWCREATURE_CANT_TAGS)

        if #ents < TUNING.GABRIEL_EIPA_UNAE_CODEX_UMBRA_BOOK_MAX_SHADOW_CREATURES then
            TheWorld.components.shadowcreaturespawner:SpawnShadowCreature(inst)
        end
    end
end

local function GetEquippableDapperness(owner, equippable)
	local dapperness = equippable:GetDapperness(owner, owner.components.sanity.no_moisture_penalty)
	return equippable.inst:HasTag("shadow_item")
		and dapperness * TUNING.GABRIEL_EIPA_UANE_SHADOW_ITEM_RESISTANCE_DAPPERNESS
		or dapperness
end

local function onSave(inst, data)
	data.charlie_vinesave = inst.charlie_vinesave
end

local function onPreLoad(inst, data, ents)
	inst.charlie_vinesave = data.charlie_vinesave or inst.charlie_vinesave
end

local onLoad = function(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onBecameGhost)
    inst:ListenForEvent("ms_becameghost", onBecameGhost)

    if inst:HasTag("playerghost") then
        onBecameGhost(inst)
    else
        onBecameHuman(inst)
    end

	if not inst.components.health:IsDead() then
		inst.charlie_vinesave = nil
	end

    inst.components.magician:StopUsing()
    OnSkinsChanged(inst, {nofx = true})
end

---@param inst Instance
local common_postinit = function(inst)
    inst.MiniMapEntity:SetIcon( "gabriel_eipa_unae.tex" )

	inst:AddTag("handyperson")
    inst:AddTag("fastbuilder")
	inst:AddTag("hungrybuilder")

    inst:AddTag("criptian")
    inst:AddTag("ezacian")

	inst:AddTag("bookbuilder")
    inst:AddTag("shadowmagic")
    inst:AddTag("dappereffects")

    --inst.AnimState:AddOverrideBuild("player_idles_waxwell")

    if TheNet:GetServerGameMode() == "quagmire" then
		inst:AddTag("quagmire_fasthands")
        inst:AddTag("quagmire_shopper")
    end

	inst:AddComponent("inspectaclesparticipant")

	inst:AddComponent("reticule")
	inst.components.reticule.targetfn = ReticuleTargetFn
	inst.components.reticule.ease = true

	--magician (from magician component) added to pristine state for optimization
	inst:AddTag("magician")

    --reader (from reader component) added to pristine state for optimization
    inst:AddTag("reader")
	
	inst:ListenForEvent("setowner", OnSetOwner)
end

---@param inst Instance
local function master_postinit(inst)
    inst.starting_inventory = start_inv[TheNet:GetServerGameMode()] or start_inv.default

    inst.customidleanim = customidleanimfn --priority when not returning nil

    inst:AddComponent("magician")

    inst:AddComponent("reader")
    inst.components.reader:SetSanityPenaltyMultiplier(TUNING.GABRIEL_EIPA_UANE_READING_PENALTY_MULT)
    inst.components.reader:SetOnReadFn(OnReadFn)

	inst:AddComponent("efficientuser")

    if inst.components.petleash ~= nil then
        inst._OnSpawnPet = inst.components.petleash.onspawnfn
        inst._OnDespawnPet = inst.components.petleash.ondespawnfn
		inst.components.petleash:SetMaxPets(inst.components.petleash:GetMaxPets() + TUNING.GABRIEL_EIPA_UNAE_CODEX_UMBRA_BOOK_MAX_SHADOW_CREATURES)
    else
        inst:AddComponent("petleash")
		inst.components.petleash:SetMaxPets(TUNING.GABRIEL_EIPA_UNAE_CODEX_UMBRA_BOOK_MAX_SHADOW_CREATURES)
    end
    inst.components.petleash:SetOnSpawnFn(OnSpawnPet)
    inst.components.petleash:SetOnDespawnFn(OnDespawnPet)
    inst:ListenForEvent("onskinschanged", OnSkinsChanged) -- Fashion Shadows.

	inst.components.eater:SetRefusesSpoiledFood(true)

    inst.soundsname = "wilson"

    inst.customidleanim = "idle_wilson"

	inst.components.grue:SetResistance(1)

    inst.components.foodaffinity:AddPrefabAffinity("baconeggs", TUNING.AFFINITY_15_CALORIES_HUGE)

    inst.components.health:SetMaxHealth(TUNING.GABRIEL_EIPA_UNAE_HEALTH)
    inst.components.hunger:SetMax(TUNING.GABRIEL_EIPA_UNAE_HUNGER)
    inst.components.sanity:SetMax(TUNING.GABRIEL_EIPA_UNAE_SANITY)
	inst.components.sanity.dapperness = TUNING.DAPPERNESS_LARGE
	inst.components.sanity.get_equippable_dappernessfn = GetEquippableDapperness
	inst.components.locomotor:SetMotorSpeed(1.2)

	inst.components.sanity.custom_rate_fn = sanityRegeneration

    inst.components.combat.damagemultiplier = 1.5
    inst.components.hunger.hungerrate = 1 * TUNING.GABRIEL_EIPA_UNAE_HUNGER_MULT_FACTOR

    inst._onpetlost = function(pet) inst.components.sanity:RemoveSanityPenalty(pet) end

    inst:ListenForEvent("death", OnDeath)
	inst:ListenForEvent("ms_becameghost", onBecameGhost)
	inst:ListenForEvent("ms_playerreroll", ForceDespawnShadowMinions)
	inst:ListenForEvent("ms_becamehuman", onBecameHuman)

    inst.OnSave = onSave
	inst.OnPreLoad = onPreLoad
	inst.OnLoad = onLoad
    inst.OnNewSpawn = OnDespawn
end

return MakePlayerCharacter("gabriel_eipa_unae", prefabs, assets, common_postinit, master_postinit, start_inv)