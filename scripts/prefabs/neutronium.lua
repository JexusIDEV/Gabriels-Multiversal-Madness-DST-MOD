local neutroniumAssets = {
    Asset("ANIM", "anim/neutronium.zip"),
}

local neutroniumPileAssets = {
    Asset("ANIM", "anim/neutronium_pile.zip"),
}

local prefabs = {
}

local function neutroniumFn()
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
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_MEDITEM

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "neutronium"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/neutronium.xml"

	MakeHauntableLaunch(inst)

    return inst
end

local function neutroniumPileFn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("neutronium_pile")
    inst.AnimState:SetBuild("neutronium_pile")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("neutronium")
    inst:AddTag("pile")
    inst:AddTag("dust")
    inst:AddTag("powder")

    MakeInventoryFloatable(inst, "small", 0.05, {0.75, 0.4, 0.75})

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inspectable")

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_TINYITEM

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "neutronium_pile"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/neutronium_pile.xml"

    return inst
end

return Prefab("neutronium", neutroniumFn, neutroniumAssets, prefabs),
        Prefab("neutronium_pile", neutroniumPileFn, neutroniumPileAssets, prefabs)