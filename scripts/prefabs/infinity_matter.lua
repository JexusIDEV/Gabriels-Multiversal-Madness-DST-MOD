local assets = {
    Asset("ANIM", "anim/infinity_matter.zip"),
}

local prefabs = {
}

local function common_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst.Light:SetFalloff(.4)
    inst.Light:SetIntensity(.8)
    inst.Light:SetRadius(3)
    inst.Light:SetColour(255, 255, 255)
    inst.Light:Enable(true)
    inst.Light:EnableClientModulation(true)

    MakeInventoryPhysics(inst)

    local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("infinity_matter.tex")

    inst.AnimState:SetBank("infinity_matter")
    inst.AnimState:SetBuild("infinity_matter")
    inst.AnimState:PlayAnimation("idle")
    --inst.AnimState:SetBloomEffectHandle(resolvefilepath('shaders/infinity.ksh'))

    inst:AddTag("infinity")
    inst:AddTag("infinity_matter")

    inst:AddTag("light")

    MakeInventoryFloatable(inst, "small", 0.05, {0.75, 0.4, 0.75})

    inst.pickupsound = "rock"

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inspectable")

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "infinity_matter"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/infinity_matter.xml"

	MakeHauntableLaunch(inst)

    return inst
end

return Prefab("infinity_matter", common_fn, assets, prefabs)