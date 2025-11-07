local MakeNeutroniumToolPrefab = require("prefabs/neutronium_tool")

local SpNtaxeAssets = {
    Asset("ANIM", "anim/neutronium_hammer.zip"),
}

local prefabs = {}

local function OnEquip(inst, owner)
    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("equipskinneditem", inst:GetSkinName())
        owner.AnimState:OverrideItemSkinSymbol("swap_object", skin_build, "neutronium_hammer", inst.GUID, "swap_object")
    else
        owner.AnimState:OverrideSymbol("swap_object", "neutronium_hammer", "swap_object")
    end
	owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")
    inst.Light:Enable(true)
end

local function OnUnequip(inst, owner) 
	owner.AnimState:Hide("ARM_carry") 
	owner.AnimState:Show("ARM_normal")
    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("unequipskinneditem", inst:GetSkinName())
    end
    inst.Light:Enable(false)
end

local function masterFn(inst)
    inst.components.equippable.walkspeedmult = 1 * TUNING.NEUTRONIUM_TOOL_WALK_SPEED_MULT
    
	inst.components.weapon:SetDamage(TUNING.NEUTRONIUM_TOOL_DAMAGE + 2)

    inst.components.weapon.attackwear = 1 / TUNING.NEUTRONIUM_TOOL_FACTOR

    return inst
end

return MakeNeutroniumToolPrefab("hammer", ACTIONS.HAMMER, OnEquip, OnUnequip, nil, masterFn, SpNtaxeAssets, prefabs)