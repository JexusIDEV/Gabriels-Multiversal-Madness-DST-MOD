local sandAssets = {
    Asset("ANIM", "anim/sand.zip")
}
local gravelAssets = {
    Asset("ANIM", "anim/gravel.zip")
}
local glassAssets = {
    Asset("ANIM", "anim/glass.zip")
}

function createBasicPrefab(name, stackSize, tags, customSound, assets, prefabs)
    local common = function()
        ---@type Instance
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddNetwork()

        MakeInventoryPhysics(inst)

        inst.AnimState:SetBank(name)
        inst.AnimState:SetBuild(name)
        inst.AnimState:PlayAnimation("idle")

        inst:AddTag(name)

        for i, tag in pairs(tags) do
            inst:AddTag(tag)
        end

        MakeInventoryFloatable(inst, "small", 0.05, {0.75, 0.4, 0.75})

        if customSound ~= "" or customSound ~= nil then
            inst.pickupsound = customSound
        end
        

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("inspectable")

        inst:AddComponent("stackable")
        inst.components.stackable.maxsize = stackSize

        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.imagename = name
        inst.components.inventoryitem.atlasname = "images/inventoryimages/"..name..".xml"

        MakeHauntableLaunch(inst)

        return inst
    end

    return Prefab(name, common, assets, prefabs)
end

return createBasicPrefab("sand", TUNING.STACK_SIZE_SMALLITEM, {"dust"}, "", sandAssets, {}),
    createBasicPrefab("gravel", TUNING.STACK_SIZE_SMALLITEM, {"pebbles", "rock"}, "rock", gravelAssets, {}),
    createBasicPrefab("glass", TUNING.STACK_SIZE_MEDITEM, {"traslucent", "shiny"}, "", glassAssets, {})