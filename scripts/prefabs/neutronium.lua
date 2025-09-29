local assets = {
    Asset("ANIM", "anim/neutronium.zip"),
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

    inst.Light:SetFalloff(.6)
    inst.Light:SetIntensity(.8)
    inst.Light:SetRadius(.6)
    inst.Light:SetColour(255, 255, 255)
    inst.Light:Enable(true)
    inst.Light:EnableClientModulation(true)

    MakeInventoryPhysics(inst)

    local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("neutronium.tex")

    inst.AnimState:SetBank("neutronium")
    inst.AnimState:SetBuild("neutronium")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("neutronium")

    inst:AddTag("light")

    MakeInventoryFloatable(inst, "small", 0.05, {0.75, 0.4, 0.75})

    inst.pickupsound = "metal"

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inspectable")

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "neutronium"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/neutronium.xml"

	MakeHauntableLaunch(inst)

    return inst
end

return Prefab("neutronium", common_fn, assets, prefabs)