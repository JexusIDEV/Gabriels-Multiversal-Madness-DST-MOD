local MakePlayerCharacter = require("prefabs/player_common")

local assets = {
}

TUNING.GABRIEL_EIPA_UNAE_HEALTH = 180
TUNING.GABRIEL_EIPA_UNAE_HUNGER = 160
TUNING.GABRIEL_EIPA_UNAE_SANITY = 200

TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.GABRIEL_EIPA_UNAE = {
}

local start_inv = {}

for k, v in pairs(TUNING.GAMEMODE_STARTING_ITEMS) do
	start_inv[string.lower(k)] = v.WILSON
end

local prefabs = FlattenTree(start_inv, true)

local onbecamehuman = function(inst)
	-- Set speed when not a ghost (optional)
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "gabriel_eipa_unae_speed_mod", 1)
end

local onbecameghost = function(inst)
	-- Remove speed modifier when becoming a ghost
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "gabriel_eipa_unae_speed_mod")
end

local function OnSave()
    
end

local OnLoad = function(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end

local common_postinit = function(inst)
    inst.MiniMapEntity:SetIcon( "gabriel_eipa_unae.tex" )

    inst:AddTag("criptian")
    inst:AddTag("ezacian")
    
end

local function master_postinit(inst)
    inst.starting_inventory = start_inv[TheNet:GetServerGameMode()] or start_inv.default

    inst.soundsname = "wilson"

    inst.customidleanim = "idle_wilson"

    inst.components.foodaffinity:AddPrefabAffinity("baconeggs", TUNING.AFFINITY_15_CALORIES_HUGE)

    inst.components.health:SetMaxHealth(TUNING.GABRIEL_EIPA_UNAE_HEALTH)
    inst.components.hunger:SetMax(TUNING.GABRIEL_EIPA_UNAE_HUNGER)
    inst.components.sanity:SetMax(TUNING.GABRIEL_EIPA_UNAE_SANITY)

    inst.components.combat.damagemultiplier = 1
    inst.components.hunger.hungerrate = .05

    inst.components.sanity:DoDelta(0.5, 0)

    inst.OnLoad = OnLoad
    inst.OnNewSpawn = OnLoad
end

return MakePlayerCharacter("gabriel_eipa_unae", prefabs, assets, common_postinit, master_postinit, start_inv)