local assets = {
    Asset("ANIM", "anim/neutronium_pickaxe.zip"),
}

--stats
TUNING.NEUTRONIUM_PICKAXE_DAMAGE = 80
TUNING.NEUTRONIUM_PICKAXE_FACTOR = 0.05
TUNING.NEUTRONIUM_PICKAXE_SHADOW_LEVEL = 4
TUNING.NEUTRONIUM_PICKAXE_WALK_SPEED_MULT = 1.5

--light
local NEUTRONIUM_PICKAXE_FALL_OFF = .2
local NEUTRONIUM_PICKAXE_FADE_INTENSITY = .6
local NEUTRONIUM_PICKAXE_FADE_RADIUS = 1

local function OnEquip(inst, owner)
	local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("equipskinneditem", inst:GetSkinName())
        owner.AnimState:OverrideItemSkinSymbol("swap_object", skin_build, "neutronium_pickaxe", inst.GUID, "swap_object")
    else
        owner.AnimState:OverrideSymbol("swap_object", "neutronium_pickaxe", "swap_object")
    end
	owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")
end

local function OnUnequip(inst, owner) 
	owner.AnimState:Hide("ARM_carry") 
	owner.AnimState:Show("ARM_normal")
    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("unequipskinneditem", inst:GetSkinName())
    end
end

local function common_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    --inst:AddTag("light")

    MakeInventoryPhysics(inst)

    local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("neutronium_pickaxe.tex")

    inst.AnimState:SetBank("neutronium_pickaxe")
    inst.AnimState:SetBuild("neutronium_pickaxe")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("neutronium_pickaxe")

    inst:AddTag("sharp")

    inst:AddTag("tool")

    inst:AddTag("shadowlevel")

    --inst.Light:SetFalloff(NEUTRONIUM_PICKAXE_FALL_OFF)
    --inst.Light:SetIntensity(NEUTRONIUM_PICKAXE_FADE_INTENSITY)
    --inst.Light:SetRadius(NEUTRONIUM_PICKAXE_FADE_RADIUS)
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

    inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.MINE)
    inst.components.tool:EnableToughWork(true)

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "neutronium_pickaxe"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/neutronium_pickaxe.xml"
    
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
    inst.components.equippable.walkspeedmult = 1 * TUNING.NEUTRONIUM_PICKAXE_WALK_SPEED_MULT

	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(TUNING.NEUTRONIUM_PICKAXE_DAMAGE)

    inst.components.weapon.attackwear = 1 / TUNING.NEUTRONIUM_PICKAXE_FACTOR

    inst.components.floater:SetBankSwapOnFloat(true, -11, {sym_build = "neutronium_pickaxe"})

    inst:AddComponent("shadowlevel")
    inst.components.shadowlevel:SetDefaultLevel(TUNING.NEUTRONIUM_PICKAXE_SHADOW_LEVEL)

	MakeHauntableLaunch(inst)

    return inst
end

return Prefab("neutronium_pickaxe", common_fn, assets)