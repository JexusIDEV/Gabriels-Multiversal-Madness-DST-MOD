local PLANT_DEFS = require("prefabs/farm_plant_defs").PLANT_DEFS

local OVERSIZED_PHYSICS_RADIUS = 0.1
local OVERSIZED_MAXWORK = 1

local seed_assets = {
    Asset("ANIM", "anim/infinity_seed.zip"),
}

local plant_assets = {
    Asset("ANIM", "anim/farm_plant_infinity_catalyst.zip"),
}

local prefabs = {
}

local function OnDeploy(inst, pt, deployer) --, rot)
    local plant = SpawnPrefab("farm_plant_infinity_catalyst")
    plant.Transform:SetPosition(pt.x, 0, pt.z)
    plant:PushEvent("on_planted", {in_soil = false, doer = deployer, seed = inst})
    TheWorld.Map:CollapseSoilAtPoint(pt.x, 0, pt.z)
    --plant.SoundEmitter:PlaySound("dontstarve/wilson/plant_seeds")
    inst:Remove()
end

local function can_plant_seed(inst, pt, mouseover, deployer)
	local x, z = pt.x, pt.z
	return TheWorld.Map:CanTillSoilAtPoint(x, 0, z, true)
end

local function oversized_makeloots(inst, name)
    local product = name
	local seeds = name.."_seeds"
    return {product, product, seeds, seeds, math.random() < 0.75 and product or seeds}
end

local function oversized_onfinishwork(inst, chopper)
    inst.components.lootdropper:DropLoot()
    inst:Remove()
end

local function Oversized_OnSave(inst, data)
	data.from_plant = inst.from_plant or false
    data.harvested_on_day = inst.harvested_on_day
end

local function Oversized_OnPreLoad(inst, data)
	inst.from_plant = (data and data.from_plant) ~= false
	if data ~= nil then
        inst.harvested_on_day = data.harvested_on_day
	end
end

local function oversized_onequip(inst, owner)
	local swap = inst.components.symbolswapdata
    owner.AnimState:OverrideSymbol("swap_body", swap.build, swap.symbol)
end

local function oversized_onunequip(inst, owner)
    owner.AnimState:ClearOverrideSymbol("swap_body")
end

local function commonOverSizeFn()
    ---@type Instance
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.6)
    inst.Light:SetRadius(.5)
    inst.Light:SetColour(255, 255, 255)
    inst.Light:Enable(true)
    inst.Light:EnableClientModulation(true)

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank(PLANT_DEFS.infinity_catalyst.bank)
    inst.AnimState:SetBuild(PLANT_DEFS.infinity_catalyst.build)
    inst.AnimState:PlayAnimation("idle_oversized")
    inst.scrapbook_anim = "idle_oversized"

    inst:AddTag("heavy")
    inst:AddTag("oversized")
    inst.gymweight = 16

    MakeHeavyObstaclePhysics(inst, OVERSIZED_PHYSICS_RADIUS)
    inst:SetPhysicsRadiusOverride(OVERSIZED_PHYSICS_RADIUS)

    inst._base_name = "infinity_catalyst"

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst.harvested_on_day = inst.harvested_on_day or (TheWorld.state.cycles + 1)

    inst:AddComponent("heavyobstaclephysics")
    inst.components.heavyobstaclephysics:SetRadius(OVERSIZED_PHYSICS_RADIUS)

    inst:AddComponent("inspectable")
    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.cangoincontainer = false
    inst.components.inventoryitem:SetSinks(true)

    inst:AddComponent("equippable")
    inst.components.equippable.equipslot = EQUIPSLOTS.BODY
    inst.components.equippable:SetOnEquip(oversized_onequip)
    inst.components.equippable:SetOnUnequip(oversized_onunequip)
    inst.components.equippable.walkspeedmult = TUNING.HEAVY_SPEED_MULT

    inst:AddComponent("workable")
    inst.components.workable:SetWorkAction(ACTIONS.HAMMER)
    inst.components.workable:SetOnFinishCallback(oversized_onfinishwork)
    inst.components.workable:SetWorkLeft(OVERSIZED_MAXWORK)

    inst:AddComponent("submersible")
    inst:AddComponent("symbolswapdata")
    inst.components.symbolswapdata:SetData(PLANT_DEFS.infinity_catalyst.build, "swap_body")

    inst:AddComponent("lootdropper")
    inst.components.lootdropper:SetLoot(oversized_makeloots(inst, "infinity_catalyst"))

    MakeHauntableWork(inst)

    inst.from_plant = false

    inst.OnSave = Oversized_OnSave
    inst.OnPreLoad = Oversized_OnPreLoad

    return inst
end

local function common_seed_fn()
    ---@type Instance
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddSoundEmitter()
    inst.entity:AddLight()
    inst.entity:AddNetwork()

    inst.Light:SetFalloff(.8)
    inst.Light:SetIntensity(.6)
    inst.Light:SetRadius(.5)
    inst.Light:SetColour(255, 255, 255)
    inst.Light:Enable(true)
    inst.Light:EnableClientModulation(true)

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("infinity_seed")
    inst.AnimState:SetBuild("infinity_seed")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")
    inst.AnimState:SetRayTestOnBB(true)

    inst.pickupsound = "metal"

    inst:AddTag("infinity")
    inst:AddTag("infinity_seed")
    inst:AddTag("seed")

    inst:AddTag("light")

    inst.overridedeployplacername = "seeds_placer"

    inst._custom_candeploy_fn = can_plant_seed

    MakeInventoryFloatable(inst, "small", 0.05, {0.75, 0.4, 0.75})

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

	inst:AddComponent("inspectable")

    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "infinity_catalyst_seeds"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/infinity_catalyst_seeds.xml"

    inst:AddComponent("farmplantable")
    inst.components.farmplantable.plant = "farm_plant_infinity_catalyst"

    inst:AddComponent("deployable")
    inst.components.deployable:SetDeployMode(DEPLOYMODE.CUSTOM) -- use inst._custom_candeploy_fn
    inst.components.deployable.restrictedtag = "plantkin"
    inst.components.deployable.ondeploy = OnDeploy

	MakeHauntableLaunch(inst)

    return inst
end

local function update_seed_placer_outline(inst)
	local x, y, z = inst.Transform:GetWorldPosition()
	if TheWorld.Map:CanTillSoilAtPoint(x, y, z) then
		local cx, cy, cz = TheWorld.Map:GetTileCenterPoint(x, y, z)
		inst.outline.Transform:SetPosition(cx, cy, cz)
		inst.outline:Show()
	else
		inst.outline:Hide()
	end
end

local function seed_placer_postinit(inst)
	inst.outline = SpawnPrefab("tile_outline")

	inst.outline.Transform:SetPosition(2, 0, 0)
	inst.outline:ListenForEvent("onremove", function() inst.outline:Remove() end, inst)
	inst.outline.AnimState:SetAddColour(.25, .75, .25, 0)
	inst.outline:Hide()

	inst.components.placer.onupdatetransform = update_seed_placer_outline
end

return Prefab("infinity_catalyst_seeds", common_seed_fn, seed_assets, prefabs),
    MakePlacer("infinity_seed_placer", "farm_soil", "farm_soil", "till_idle", nil, nil, nil, nil, nil, nil, seed_placer_postinit),
    Prefab("infinity_catalyst_oversized", commonOverSizeFn, plant_assets, nil)