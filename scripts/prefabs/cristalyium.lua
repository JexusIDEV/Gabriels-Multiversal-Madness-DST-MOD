local baseCristalyiumAssets = {
    Asset("ANIM", "anim/cristalyium.zip"),
}

local cristalyiumJuiceAssets = {
    Asset("ANIM", "anim/cristalyium_juices.zip"),
}

local prefabs = {
    rawCristalyium = {

    },
    pureCristalyium = {

    },
    cristalyiumJuice = {

    },
    cristalyiumDerivativesJuice = {

    }
}

local Ct_Data = {}

Ct_Data.cristalyium = {name = "cristalyium", prefab = {}, r = 255, g = 0, b = 122}
Ct_Data.redlium = {name = "redlium", prefab = {}, r = 255, g = 0, b = 0}
Ct_Data.ornalenium = {name = "ornalenium", prefab = {}, r = 255, g = 126, b = 0}
Ct_Data.yellonite = {name = "yellonite", prefab = {}, r = 255, g = 255, b = 0}
Ct_Data.greenulium = {name = "greenulium", prefab = {}, r = 0, g = 255, b = 0}
Ct_Data.cyanulium = {name = "cyanulium", prefab = {}, r = 0, g = 255, b = 255}
Ct_Data.blunium = {name = "blunium", prefab = {}, r = 0, g = 0, b = 255}
Ct_Data.purpulium = {name = "purpulium", r = 180, g = 0, b = 255}
Ct_Data.magente = {name = "magente", prefab = {}, r = 255, g = 0, b = 255}

TUNING.CRISTALYIUM_JUICE_USES = 10

local function setRawCristalyiumPieceType(inst, piece)
    if inst.piece == nil or (piece ~= nil and inst.piece ~= piece) then
        inst.piece = piece or math.random(0, 2)
        inst.AnimState:PlayAnimation("idle_"..inst.piece)
    end
end

local function onSave(inst, data)
    data.piece = inst.piece
end

local function onLoad(inst, data)
    setRawCristalyiumPieceType(inst, data ~= nil and data.piece or nil)
end

---comment for make this work, add before the TheWorld.ismastersim but after the  his corresponded tag "light" and before of calling this function "inst.entity:AddLight()"
---@param inst Instance
local createPreLight = function(inst)
    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.5)
    inst.Light:SetRadius(.25)
    inst.Light:SetColour(255, 255, 255)
    inst.Light:Enable(true)
    inst.Light:EnableClientModulation(true)
end

local function fnRawCristalyium()
    ---@type Instance
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    createPreLight(inst)

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("raw_cristalyium")
    inst.AnimState:SetBuild("cristalyium")
    inst.AnimState:PlayAnimation("idle_0")

    inst:AddTag("cristalyium")
    inst:AddTag("raw")

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

local function fnPureCristalyium()
    ---@type Instance
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    createPreLight(inst)

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("pure_cristalyium")
    inst.AnimState:SetBuild("cristalyium")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("cristalyium")
    inst:AddTag("pure")

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
    inst.components.inventoryitem.imagename = "pure_cristalyium"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/pure_cristalyium.xml"

	MakeHauntableLaunch(inst)

    return inst
end

---creating prefab derivatives from cristalyium
---@param name string
---@param assets table
---@param prefabs table
---@param r integer
---@param g integer
---@param b integer
local CreateCristalyiumJuiceDerivative = function(name, assets, prefabs, r, g, b)
    ---@param inst Instance
    local createDerivativeColor = function(inst)
        inst.Light:SetFalloff(.8)
        inst.Light:SetIntensity(.8)
        inst.Light:SetRadius(.3)
        inst.Light:SetColour(r, g, b)
        inst.Light:Enable(true)
        inst.Light:EnableClientModulation(true)
    end
    
    local commonFn = function ()
        ---@type Instance
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddSoundEmitter()
        inst.entity:AddLight()
        inst.entity:AddNetwork()

        createDerivativeColor(inst)

        MakeInventoryPhysics(inst)

        inst.AnimState:SetBuild("cristalyium_juices")
        inst.AnimState:SetBank(name.."_juice")
        inst.AnimState:PlayAnimation("idle")

        inst:AddTag(name)
        inst:AddTag("cristalyium")
        inst:AddTag("fluid")
        inst:AddTag("juice")
        inst:AddTag("derivative")

        inst:AddTag("light")

        MakeInventoryFloatable(inst, "small", 0.05, {0.75, 0.4, 0.75})

        inst.entity:SetPristine()

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("inspectable")
        

        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.imagename = name.."_juice"
        inst.components.inventoryitem.atlasname = "images/inventoryimages/"..name.."_juice.xml"

        if name == "cristalyium" then
            inst:AddComponent("finiteuses")
            inst.components.finiteuses:SetMaxUses(TUNING.CRISTALYIUM_JUICE_USES)
            inst.components.finiteuses:SetUses(TUNING.CRISTALYIUM_JUICE_USES)
        end

        return inst
    end

    return Prefab(name.."_juice", commonFn, assets, prefabs)
end

return Prefab("raw_cristalyium", fnRawCristalyium, baseCristalyiumAssets, prefabs.rawCristalyium),
    Prefab("pure_cristalyium", fnPureCristalyium, baseCristalyiumAssets, prefabs.pureCristalyium),
    CreateCristalyiumJuiceDerivative(
        Ct_Data.cristalyium.name,
        cristalyiumJuiceAssets,
        Ct_Data.cristalyium.prefab,
        Ct_Data.cristalyium.r,
        Ct_Data.cristalyium.g,
        Ct_Data.cristalyium.b
    ),
    CreateCristalyiumJuiceDerivative(
        Ct_Data.redlium.name,
        cristalyiumJuiceAssets,
        Ct_Data.redlium.prefab,
        Ct_Data.redlium.r,
        Ct_Data.redlium.g,
        Ct_Data.redlium.b
    ),
    CreateCristalyiumJuiceDerivative(
        Ct_Data.ornalenium.name,
        cristalyiumJuiceAssets,
        Ct_Data.ornalenium.prefab,
        Ct_Data.ornalenium.r,
        Ct_Data.ornalenium.g,
        Ct_Data.ornalenium.b
    ),
    CreateCristalyiumJuiceDerivative(
        Ct_Data.yellonite.name,
        cristalyiumJuiceAssets,
        Ct_Data.yellonite.prefab,
        Ct_Data.yellonite.r,
        Ct_Data.yellonite.g,
        Ct_Data.yellonite.b
    ),
    CreateCristalyiumJuiceDerivative(
        Ct_Data.greenulium.name,
        cristalyiumJuiceAssets,
        Ct_Data.greenulium.prefab,
        Ct_Data.greenulium.r,
        Ct_Data.greenulium.g,
        Ct_Data.greenulium.b
    ),
    CreateCristalyiumJuiceDerivative(
        Ct_Data.cyanulium.name,
        cristalyiumJuiceAssets,
        Ct_Data.cyanulium.prefab,
        Ct_Data.cyanulium.r,
        Ct_Data.cyanulium.g,
        Ct_Data.cyanulium.b
    ),
    CreateCristalyiumJuiceDerivative(
        Ct_Data.blunium.name,
        cristalyiumJuiceAssets,
        Ct_Data.blunium.prefab,
        Ct_Data.blunium.r,
        Ct_Data.blunium.g,
        Ct_Data.blunium.b
    ),
    CreateCristalyiumJuiceDerivative(
        Ct_Data.purpulium.name,
        cristalyiumJuiceAssets,
        Ct_Data.purpulium.prefab,
        Ct_Data.purpulium.r,
        Ct_Data.purpulium.g,
        Ct_Data.purpulium.b
    ),
    CreateCristalyiumJuiceDerivative(
        Ct_Data.magente.name,
        cristalyiumJuiceAssets,
        Ct_Data.magente.prefab,
        Ct_Data.magente.r,
        Ct_Data.magente.g,
        Ct_Data.magente.b
    )