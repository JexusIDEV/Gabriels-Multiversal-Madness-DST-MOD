local circuitIAssets = {
    --tier I
    Asset("ANIM", "anim/circuit_tier_i.zip"),
    Asset("MINIMAP_IMAGE", "circuit_tier_i"),
}

local circuitIIAssets = {
    --tier II
    Asset("ANIM", "anim/circuit_tier_ii.zip"),
    Asset("MINIMAP_IMAGE", "circuit_tier_ii"),
}

local circuitIIIAssets = {
    --tier III
    Asset("ANIM", "anim/circuit_tier_iii.zip"),
    Asset("MINIMAP_IMAGE", "circuit_tier_iii"),
}

local baseCircuitPropsFn = function(tier)
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("circuit_tier_"..tier)
    inst.AnimState:SetBuild("circuit_tier_"..tier)
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("circuit")
    inst:AddTag("tech")
    inst:AddTag("technology")

    MakeInventoryFloatable(inst, "small", 0.05, {0.75, 0.4, 0.75})

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "circuit_tier_"..tier
    inst.components.inventoryitem.atlasname = "images/inventoryimages/".."circuit_tier_"..tier..".xml"

    MakeHauntableLaunch(inst)

    return inst
end

local tierICircuit = function()
    local inst = baseCircuitPropsFn("i")
    return inst
end

local tierIICircuit = function()
    local inst = baseCircuitPropsFn("ii")
    return inst
end

local tierIIICircuit = function()
    local inst = baseCircuitPropsFn("iii")
    return inst
end

return Prefab("circuit_tier_i", tierICircuit, circuitIAssets),
        Prefab("circuit_tier_ii", tierIICircuit, circuitIIAssets),
        Prefab("circuit_tier_iii", tierIIICircuit, circuitIIIAssets)