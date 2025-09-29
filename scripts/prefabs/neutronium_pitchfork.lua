local assets = {
    Asset("ANIM", "anim/neutronium_pitchfork.zip"),
}

--stats
TUNING.NEUTRONIUM_PITCHFORK_DAMAGE = 80
TUNING.NEUTRONIUM_PITCHFORK_FACTOR = 0.05
TUNING.NEUTRONIUM_PITCHFORK_SHADOW_LEVEL = 4
TUNING.NEUTRONIUM_PITCHFORK_WALK_SPEED_MULT = 1.5

--light
local NEUTRONIUM_PITCHFORK_FALL_OFF = .2
local NEUTRONIUM_PITCHFORK_FADE_INTENSITY = .6
local NEUTRONIUM_PITCHFORK_FADE_RADIUS = 1

local function OnEquip(inst, owner)
	local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("equipskinneditem", inst:GetSkinName())
        owner.AnimState:OverrideItemSkinSymbol("swap_object", skin_build, "neutronium_pitchfork", inst.GUID, "swap_object")
    else
        owner.AnimState:OverrideSymbol("swap_object", "neutronium_pitchfork", "swap_object")
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

local function common_fn()
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
	minimap:SetIcon("neutronium_pitchfork.tex")

    inst.AnimState:SetBank("neutronium_pitchfork")
    inst.AnimState:SetBuild("neutronium_pitchfork")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("neutronium_pitchfork")

    inst:AddTag("sharp")

    inst:AddTag("light")

    inst:AddTag("tool")

    inst:AddTag("shadowlevel")

    --inst.Light:SetFalloff(NEUTRONIUM_PITCHFORK_FALL_OFF)
    --inst.Light:SetIntensity(NEUTRONIUM_PITCHFORK_FADE_INTENSITY)
    --inst.Light:SetRadius(NEUTRONIUM_PITCHFORK_FADE_RADIUS)
    --inst.Light:SetColour(1/255, 1/255, 1/255)
    --inst.Light:Enable(false)
    --inst.Light:EnableClientModulation(true)

    inst:AddTag("weapon")

    MakeInventoryFloatable(inst, "med", 0.05, {0.75, 0.4, 0.75})

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "neutronium_pitchfork"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/neutronium_pitchfork.xml"
    
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
    inst.components.equippable.walkspeedmult = 1 * TUNING.NEUTRONIUM_PITCHFORK_WALK_SPEED_MULT

	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(TUNING.NEUTRONIUM_PITCHFORK_DAMAGE)

    inst.components.weapon.attackwear = 1 / TUNING.NEUTRONIUM_PITCHFORK_FACTOR

    inst.components.floater:SetBankSwapOnFloat(true, -11, {sym_build = "neutronium_pitchfork"})

    inst:AddInherentAction(ACTIONS.TERRAFORM)

    inst:AddComponent("terraformer")

    inst:AddComponent("shadowlevel")
    inst.components.shadowlevel:SetDefaultLevel(TUNING.NEUTRONIUM_PITCHFORK_SHADOW_LEVEL)

	MakeHauntableLaunch(inst)

    return inst
end

return Prefab("neutronium_pitchfork", common_fn, assets)