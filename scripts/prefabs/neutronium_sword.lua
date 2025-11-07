local assets = {
    Asset("ANIM", "anim/neutronium_sword.zip"),
}

TUNING.NEUTRONIUM_SWORD_DAMAGE_BASE = 320 --i want to keep the fight fun... but anyways drains a lot of health xd.
TUNING.NEUTRONIUM_SWORD_FACTOR = 0.05
TUNING.NEUTRONIUM_SWORD_SHADOW_LEVEL = 4
TUNING.NEUTRONIUM_SWORD_WALK_SPEED_MULT = 1.75
TUNING.NEUTRONIUM_SWORD_MOON_DARK_CREATURE_EXTRA_DAMAGE = 1.25


local function OnEquip(inst, owner)
	local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("equipskinneditem", inst:GetSkinName())
        owner.AnimState:OverrideItemSkinSymbol("swap_object", skin_build, "neutronium_sword", inst.GUID, "swap_object")
    else
        owner.AnimState:OverrideSymbol("swap_object", "neutronium_sword", "swap_object")
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
    inst.Light:Enable(true)
    inst.Light:EnableClientModulation(true)

    MakeInventoryPhysics(inst)

    local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("neutronium_sword.tex")

    inst.AnimState:SetBank("neutronium_sword")
    inst.AnimState:SetBuild("neutronium_sword")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("neutronium_sword")

    inst:AddTag("sharp")

    inst:AddTag("light")

    --tool (from tool component) added to pristine state for optimization
    inst:AddTag("tool")

    --weapon (from weapon component) added to pristine state for optimization
    inst:AddTag("weapon")

    MakeInventoryFloatable(inst, "med", 0.05, {0.75, 0.4, 0.75})

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inspectable")

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "neutronium_sword"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/neutronium_sword.xml"
    
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
    inst.components.equippable.walkspeedmult = 1 * TUNING.NEUTRONIUM_SWORD_WALK_SPEED_MULT

	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(TUNING.NEUTRONIUM_SWORD_DAMAGE_BASE)

    inst.components.weapon.attackwear = 1 / TUNING.NEUTRONIUM_SWORD_FACTOR

    local damagetypebonus = inst:AddComponent("damagetypebonus")
    --i dont care alignment fucckkerss
	damagetypebonus:AddBonus("shadow_aligned", inst, TUNING.NEUTRONIUM_SWORD_MOON_DARK_CREATURE_EXTRA_DAMAGE)
    damagetypebonus:AddBonus("lunar_aligned", inst, TUNING.NEUTRONIUM_SWORD_MOON_DARK_CREATURE_EXTRA_DAMAGE)
    damagetypebonus:AddBonus("shadowsubmissive", inst, TUNING.NEUTRONIUM_SWORD_MOON_DARK_CREATURE_EXTRA_DAMAGE)
    damagetypebonus:AddBonus("lunarsubmissive", inst, TUNING.NEUTRONIUM_SWORD_MOON_DARK_CREATURE_EXTRA_DAMAGE)

    inst.components.floater:SetBankSwapOnFloat(true, -11, {sym_build = "neutronium_sword"})

    inst:AddComponent("shadowlevel")
    inst.components.shadowlevel:SetDefaultLevel(TUNING.NEUTRONIUM_SWORD_SHADOW_LEVEL)

	MakeHauntableLaunch(inst)

    return inst
end

return Prefab("neutronium_sword", common_fn, assets)