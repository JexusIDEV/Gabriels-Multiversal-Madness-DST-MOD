--[[SETTLED STACK META - SSM = QU4gTE9LVVMsIFNFQVJDSElORyBGT1IgSElTIFBBVEggQU5EIExJRkUsIFRIRSBNVUxUSVZFUlNFIElTIEFHUkVTU0lWRSwgQlVUIEhJUyBQQVRJRU5UIE1BWSBCRSBIRUxQIEhJTSBUTyBTVVJWSVZF
SU4gQkVUV0VFTiBPRiBBIEhPUlJJRCBEQVJLTkVTUyBBTkQgU0hBRE9XUywgSEUgQUxXQVlTIEZJTkRTIFRIRSBHUk9VUCwgQU5EIFRIRSBDT1JSRUNUIFBBVEggRk9SIEJFIEEgQkVUVEVSIFBFUlNPTiBBTkQ=
UFJBSVNJTkcgVEhFIExJRkUsIE5BVFVSRSwgRVhJU1RFTkNFIEFORCBFVkVSWVRISU5HLi4u]]

local MakePlayerCharacter = require("prefabs/player_common")

TUNING.KEMU_TENSARA_NEITO_HEALTH = 120
TUNING.KEMU_TENSARA_NEITO_HUNGER = 180
TUNING.KEMU_TENSARA_NEITO_SANITY = 160

local assets = {

}

TUNING.GAMEMODE_STARTING_ITEMS.DEFAULT.GABRIEL_EIPA_UNAE = {
}

local start_inv = {
    "hoe",
    "seeds",
    "seeds",
    "seeds",
    "seeds",
}

for k, v in pairs(TUNING.GAMEMODE_STARTING_ITEMS) do
	start_inv[string.lower(k)] = v.WILSON
end

local prefabs = FlattenTree(start_inv, true)

local function OnDeath(inst)

end

local onBecameHuman = function(inst)
	-- Set speed when not a ghost (optional)
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "kemu_tensara_neito_speed_mod", 1.2)
end

local function onBecameGhost(inst)
    inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "kemu_tensara_neito_speed_mod")
end

local prefabs = FlattenTree(start_inv, true)

local function onSave(inst, data)
end

local function onPreLoad(inst, data, ents)
end

local onLoad = function(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onBecameGhost)
    inst:ListenForEvent("ms_becameghost", onBecameGhost)

    if inst:HasTag("playerghost") then
        onBecameGhost(inst)
    else
        onBecameHuman(inst)
    end
end

---@param inst Instance
local common_postinit = function (inst)
    inst:AddTag("ezacian")
    inst:AddTag("werecreature")
    inst:AddTag("werewolf")

    inst:AddTag("dappereffects")
end

---@param inst Instance
local master_postinit = function (inst)
    inst.starting_inventory = start_inv[TheNet:GetServerGameMode()] or start_inv.default

    inst.components.eater:SetRefusesSpoiledFood(true)

    inst.soundsname = "walter"
    inst.customidleanim = "idle_wilson"

    inst.components.foodaffinity:AddPrefabAffinity("veggieburger", TUNING.AFFINITY_15_CALORIES_SUPERHUGE)
    inst.components.foodaffinity:AddPrefabAffinity("beefygreens", TUNING.AFFINITY_15_CALORIES_SUPERHUGE)

    inst.components.health:SetMaxHealth(TUNING.KEMU_TENSARA_NEITO_HEALTH)
    inst.components.hunger:SetMax(TUNING.KEMU_TENSARA_NEITO_HUNGER)
    inst.components.sanity:SetMax(TUNING.KEMU_TENSARA_NEITO_SANITY)
	inst.components.locomotor:SetMotorSpeed(1.25)

    inst:ListenForEvent("death", OnDeath)
	inst:ListenForEvent("ms_becameghost", onBecameGhost)
    inst:ListenForEvent("ms_becamehuman", onBecameHuman)

    inst.OnSave = onSave
	inst.OnPreLoad = onPreLoad
	inst.OnLoad = onLoad
end

return MakePlayerCharacter("kemu_tensara_neito", prefabs, assets, common_postinit, master_postinit, start_inv)