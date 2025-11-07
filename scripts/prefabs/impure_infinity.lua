local assets = {
    Asset("ANIM", "anim/impure_infinity.zip"),
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

    inst.Light:SetFalloff(.3)
    inst.Light:SetIntensity(1)
    inst.Light:SetRadius(8)
    inst.Light:SetColour(255, 255, 255)
    inst.Light:Enable(true)
    inst.Light:EnableClientModulation(true)

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("impure_infinity")
    inst.AnimState:SetBuild("impure_infinity")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")

    inst:AddTag("infinity")
    inst:AddTag("impure_infinity")

    inst:AddTag("light")

    MakeInventoryFloatable(inst, "small", 0.05, {0.75, 0.4, 0.75})

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inspectable")

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_TINYITEM

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "impure_infinity"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/impure_infinity.xml"

	MakeHauntableLaunch(inst)

    return inst
end

return Prefab("impure_infinity", common_fn, assets, prefabs)