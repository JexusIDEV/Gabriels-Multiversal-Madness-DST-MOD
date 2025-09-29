local assets = {
    Asset("ANIM", "anim/raw_cristalyium.zip"),
}

local prefabs = {
}

local function setpiecetype(inst, piece)
    if inst.piece == nil or (piece ~= nil and inst.piece ~= piece) then
        inst.piece = piece or math.random(0, 2)
        inst.AnimState:PlayAnimation("idle_"..inst.piece)
    end
end

local function onSave(inst, data)
    data.piece = inst.piece
end

local function onLoad(inst, data)
    setpiecetype(inst, data ~= nil and data.piece or nil)
end

local function common_fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.1)
    inst.Light:SetRadius(.2)
    inst.Light:SetColour(255, 255, 255)
    inst.Light:Enable(true)
    inst.Light:EnableClientModulation(true)

    MakeInventoryPhysics(inst)

    local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("raw_cristalyium.tex")

    inst.AnimState:SetBank("raw_cristalyium")
    inst.AnimState:SetBuild("raw_cristalyium")
    inst.AnimState:PlayAnimation("idle_0")

    inst:AddTag("raw_cristalyium")

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
    inst.components.inventoryitem.imagename = "raw_cristalyium"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/raw_cristalyium.xml"

	MakeHauntableLaunch(inst)

    inst.OnSave = onSave
    inst.OnLoad = onLoad

    return inst
end

return Prefab("raw_cristalyium", common_fn, assets, prefabs)