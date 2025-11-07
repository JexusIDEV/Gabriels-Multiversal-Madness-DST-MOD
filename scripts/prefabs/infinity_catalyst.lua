local assets = {
    Asset("ANIM", "anim/infinity_catalyst.zip"),
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

    inst.Light:SetFalloff(.85)
    inst.Light:SetIntensity(.9)
    inst.Light:SetRadius(16)
    inst.Light:SetColour(255, 255, 255)
    inst.Light:Enable(true)
    inst.Light:EnableClientModulation(true)

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("infinity_catalyst")
    inst.AnimState:SetBuild("infinity_catalyst")
    inst.AnimState:PlayAnimation("idle_loop", true)
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")

    inst:AddTag("infinity")
    inst:AddTag("infinity_catalyst")

    inst:AddTag("light")

    MakeInventoryFloatable(inst, "small", 0.05, {0.75, 0.4, 0.75})

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inspectable")

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "infinity_catalyst"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/infinity_catalyst.xml"

	MakeHauntableLaunch(inst)

    return inst
end

return Prefab("infinity_catalyst", common_fn, assets, prefabs)