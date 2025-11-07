require "prefabutil"
--oh babe, space time
local assets = {
    Asset("ANIM", "anim/neutron_collector.zip"),
    Asset("MINIMAP_IMAGE","neutron_collector"),
}

local prefabs  = {
    "neutronium_pile"
}

local SOUNDS = {
    open  = "dontstarve/wilson/chest_open",
    close = "dontstarve/wilson/chest_close",
    built = "dontstarve/common/chest_craft",
}

TUNING.NEUTRON_COLLECTOR_TICK_TIME_PILE_GENERATION = 1800

function Default_PlayAnimation(inst, anim, loop)
    inst.AnimState:PlayAnimation(anim, loop)
end

function Default_PushAnimation(inst, anim, loop)
    inst.AnimState:PushAnimation(anim, loop)
end

---@param inst Instance
local function generateNeutroniumPileTask(inst)
    local container = inst.components.container
    if container ~= nil then
        if container:IsFull() then
            return
        else
            local item = SpawnPrefab("neutronium_pile")
            container:GiveItem(item)
            return item
        end
    end
end

local OnOpen = function (inst)
    if not inst:HasTag("burnt") then
        if inst.skin_open_sound then
            inst.SoundEmitter:PlaySound(inst.skin_open_sound)
        else
            inst.SoundEmitter:PlaySound(inst.sounds.open)
        end
    end
end

local OnClose = function (inst)
    if not inst:HasTag("burnt") then
        if inst.skin_close_sound then
            inst.SoundEmitter:PlaySound(inst.skin_close_sound)
        else
            inst.SoundEmitter:PlaySound(inst.sounds.close)
        end
    end
end

---@param inst Instance
local builtMachine = function(inst)
    inst:_PlayAnimation("place")
    inst:_PushAnimation("idle_loop", true)
    if inst.skin_place_sound then
        inst.SoundEmitter:PlaySound(inst.skin_place_sound)
    else
        inst.SoundEmitter:PlaySound(inst.sounds.built)
    end
end

local OnHammered = function (inst, worker)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() then
        inst.components.burnable:Extinguish()
    end
    inst.components.lootdropper:DropLoot()
    if inst.components.container ~= nil then
        inst.components.container:DropEverything()
    end
    local fx = SpawnPrefab("collapse_small")
    fx.Transform:SetPosition(inst.Transform:GetWorldPosition())
    fx:SetMaterial("rock")
    inst:Remove()
end

local OnHit = function (inst, worker)
    if not inst:HasTag("burnt") then
        if inst.components.container ~= nil then
            inst.components.container:DropEverything()
            inst.components.container:Close()
        end
        inst.AnimState:PlayAnimation("hit")
        inst.AnimState:PushAnimation("closed", false)
    end
end

local OnSave = function (inst, data)
    if inst.components.burnable ~= nil and inst.components.burnable:IsBurning() or inst:HasTag("burnt") then
        data.burnt = true
    end
end

local OnLoad = function (inst, data)
    if data ~= nil and data.burnt and inst.components.burnable ~= nil then
        inst.components.burnable.onburnt(inst)
    end
end

local mainFn = function()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddSoundEmitter()
    inst.entity:AddMiniMapEntity()
    inst.entity:AddNetwork()

    inst:SetDeploySmartRadius(1) --recipe min_spacing/2
    MakeObstaclePhysics(inst, .4)

    local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("neutron_collector.tex")

    inst.AnimState:SetBank("neutron_collector")
    inst.AnimState:SetBuild("neutron_collector")
    inst.AnimState:PlayAnimation("idle_loop")

    inst:AddTag("structure")

    MakeSnowCoveredPristine(inst)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.sounds = SOUNDS

    inst:AddComponent("inspectable")
    inst:AddComponent("container")
    inst.components.container:WidgetSetup("treasurechest")
    inst.components.container.onopenfn = OnOpen
    inst.components.container.onclosefn = OnClose
    inst.components.container.skipclosesnd = true
    inst.components.container.skipopensnd = true

    inst:AddComponent("inventory")

    inst:AddComponent("lootdropper")
    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetWorkLeft(2)
    inst.components.workable:SetOnFinishCallback(OnHammered)
    inst.components.workable:SetOnWorkCallback(OnHit)

    MakeSmallBurnable(inst, nil, nil, true)
    MakeMediumPropagator(inst)

    inst:AddComponent("hauntable")
    inst.components.hauntable:SetHauntValue(TUNING.HAUNT_TINY)

    inst:ListenForEvent("onbuilt", builtMachine)
    inst:DoPeriodicTask(28000*FRAMES, generateNeutroniumPileTask)
    MakeSnowCovered(inst)

    inst.OnSave = OnSave
    inst.OnLoad = OnLoad
    
    inst._PlayAnimation = Default_PlayAnimation
    inst._PushAnimation = Default_PushAnimation

    return inst
end

return Prefab("neutron_collector", mainFn, assets, prefabs), MakePlacer("neutron_collector_placer", "neutron_collector", "neutron_collector", "idle")