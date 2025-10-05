local SpNtPickaxeAssets = {
    Asset("ANIM", "anim/neutronium_pickaxe.zip"),
}
local SpNtAxeAssets = {
    Asset("ANIM", "anim/neutronium_axe.zip"),
}
local SpNtShovelAssets = {
    Asset("ANIM", "anim/neutronium_shovel.zip"),
}
local SpNtHammerAssets = {
    Asset("ANIM", "anim/neutronium_hammer.zip"),
}
local SpNtPitchforkAssets = {
    Asset("ANIM", "anim/neutronium_pitchfork.zip"),
}
local SpNtHoeAssets = {
    Asset("ANIM", "anim/neutronium_hoe.zip"),
}

TUNING.NEUTRONIUM_TOOL_DAMAGE = 80
TUNING.NEUTRONIUM_TOOL_FACTOR = 0.05
TUNING.NEUTRONIUM_TOOL_SHADOW_LEVEL = 4
TUNING.NEUTRONIUM_TOOL_WALK_SPEED_MULT = 1.5

local SetToolOnEquip = function(toolName, inst, owner)
    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("equipskinneditem", inst:GetSkinName())
        owner.AnimState:OverrideItemSkinSymbol("swap_object", skin_build, "neutronium_"..toolName, inst.GUID, "swap_object")
    else
        owner.AnimState:OverrideSymbol("swap_object", "neutronium_"..toolName, "swap_object")
    end
	owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")
    inst.Light:Enable(true)
end

local OnUnequip = function(inst, owner) 
	owner.AnimState:Hide("ARM_carry") 
	owner.AnimState:Show("ARM_normal")
    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("unequipskinneditem", inst:GetSkinName())
    end
    inst.Light:Enable(false)
end

local neutrnoiumToolBaseFn = function(toolName, actionToolType)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst.Light:SetFalloff(.6)
    inst.Light:SetIntensity(.8)
    inst.Light:SetRadius(.6)
    inst.Light:SetColour(255, 255, 255)
    inst.Light:Enable(false)
    inst.Light:EnableClientModulation(true)

    MakeInventoryPhysics(inst)

    local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("neutronium_"..toolName..".tex")

    inst.AnimState:SetBank("neutronium_"..toolName)
    inst.AnimState:SetBuild("neutronium_"..toolName)
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("neutronium_"..toolName)

    inst:AddTag("sharp")

    inst:AddTag("tool")

    inst:AddTag("shadowlevel")

    inst:AddTag("weapon")

    MakeInventoryFloatable(inst, "med", 0.05, {0.75, 0.4, 0.75})

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    if(toolName == "pitchfork") then
        inst:AddComponent("terraformer")
        inst:AddInherentAction(ACTIONS.TERRAFORM)
    elseif(toolName == "hoe") then
        inst:AddComponent("farmtiller")
        inst:AddInherentAction(ACTIONS.TILL)
    else
        inst:AddComponent("tool")
        inst.components.tool:SetAction(actionToolType, 20)
        inst.components.tool:EnableToughWork(true)
    end

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "neutronium_"..toolName
    inst.components.inventoryitem.atlasname = "images/inventoryimages/neutronium_"..toolName..".xml"
    
    inst:AddComponent("equippable")
    local OnEquip = function(inst, owner)
        return SetToolOnEquip(toolName, inst, owner)
    end
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
    
    inst:AddComponent("weapon")

    inst.components.floater:SetBankSwapOnFloat(true, -11, {sym_build = "neutronium_"..toolName})

    inst:AddComponent("shadowlevel")
    inst.components.shadowlevel:SetDefaultLevel(TUNING.NEUTRONIUM_TOOL_SHADOW_LEVEL)

	MakeHauntableLaunch(inst)

    return inst
end

local SpNtPickaxeFn = function()
    local inst = neutrnoiumToolBaseFn("pickaxe", ACTIONS.MINE)

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.equippable.walkspeedmult = 1 * TUNING.NEUTRONIUM_TOOL_WALK_SPEED_MULT
    
	inst.components.weapon:SetDamage(TUNING.NEUTRONIUM_TOOL_DAMAGE + 2)

    inst.components.weapon.attackwear = 1 / TUNING.NEUTRONIUM_TOOL_FACTOR

    return inst
end

local SpNtAxeFn = function()
    local inst = neutrnoiumToolBaseFn("axe", ACTIONS.CHOP)

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.equippable.walkspeedmult = 1 * TUNING.NEUTRONIUM_TOOL_WALK_SPEED_MULT
    
	inst.components.weapon:SetDamage(TUNING.NEUTRONIUM_TOOL_DAMAGE + 2)

    inst.components.weapon.attackwear = 1 / TUNING.NEUTRONIUM_TOOL_FACTOR

    return inst
end

local SpNtShovelFn = function()
    local inst = neutrnoiumToolBaseFn("shovel", ACTIONS.DIG)

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.equippable.walkspeedmult = 1 * TUNING.NEUTRONIUM_TOOL_WALK_SPEED_MULT
    
	inst.components.weapon:SetDamage(TUNING.NEUTRONIUM_TOOL_DAMAGE + 2)

    inst.components.weapon.attackwear = 1 / TUNING.NEUTRONIUM_TOOL_FACTOR

    return inst
end

local SpNtHammerFn = function()
    local inst = neutrnoiumToolBaseFn("hammer", ACTIONS.HAMMER)

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.equippable.walkspeedmult = 1 * TUNING.NEUTRONIUM_TOOL_WALK_SPEED_MULT
    
	inst.components.weapon:SetDamage(TUNING.NEUTRONIUM_TOOL_DAMAGE)

    inst.components.weapon.attackwear = 1 / TUNING.NEUTRONIUM_TOOL_FACTOR

    return inst
end

local SpNtPitchforkFn = function()
    local inst = neutrnoiumToolBaseFn("pitchfork", nil)

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.equippable.walkspeedmult = 1 * TUNING.NEUTRONIUM_TOOL_WALK_SPEED_MULT
    
	inst.components.weapon:SetDamage(TUNING.NEUTRONIUM_TOOL_DAMAGE - 6)

    inst.components.weapon.attackwear = 1 / TUNING.NEUTRONIUM_TOOL_FACTOR

    return inst
end

local SpNtHoeFn = function()
    local inst = neutrnoiumToolBaseFn("hoe", nil)

    if not TheWorld.ismastersim then
        return inst
    end

    inst.components.equippable.walkspeedmult = 1 * TUNING.NEUTRONIUM_TOOL_WALK_SPEED_MULT
    
	inst.components.weapon:SetDamage(TUNING.NEUTRONIUM_TOOL_DAMAGE - 16)

    inst.components.weapon.attackwear = 1 / TUNING.NEUTRONIUM_TOOL_FACTOR

    return inst
end

return Prefab("neutronium_pickaxe", SpNtPickaxeFn, SpNtPickaxeAssets),
        Prefab("neutronium_axe", SpNtAxeFn, SpNtAxeAssets),
        Prefab("neutronium_shovel", SpNtShovelFn, SpNtShovelAssets),
        Prefab("neutronium_hammer", SpNtHammerFn, SpNtHammerAssets),
        Prefab("neutronium_pitchfork", SpNtPitchforkFn, SpNtPitchforkAssets),
        Prefab("neutronium_hoe", SpNtHoeFn, SpNtHoeAssets)