TUNING.NEUTRONIUM_TOOL_DAMAGE = 80
TUNING.NEUTRONIUM_TOOL_FACTOR = 0.05
TUNING.NEUTRONIUM_TOOL_SHADOW_LEVEL = 4
TUNING.NEUTRONIUM_TOOL_WALK_SPEED_MULT = 1.5

local function SpecialWorkMultiplierFn(inst, action, target, tool, numworks, recoil)
    return 99999
end

---@param toolName string
---@param actionToolType Action
---@param OnEquipFn function
---@param OnUnequipFn function
---@param commonFn any
---@param masterFn any
---@param prefabs table
---@param assets table
local function MakeNeutroniumToolPrefab(toolName, actionToolType, OnEquipFn, OnUnequipFn, commonFn, masterFn, prefabs, assets)
    local mainFn = function()
        local inst = CreateEntity()

        inst.entity:AddTransform()
        inst.entity:AddAnimState()
        inst.entity:AddLight()
        inst.entity:AddNetwork()

        inst.Light:SetFalloff(.6)
        inst.Light:SetIntensity(.8)
        inst.Light:SetRadius(.6)
        inst.Light:SetColour(255, 255, 255)
        inst.Light:Enable(true)
        inst.Light:EnableClientModulation(true)

        MakeInventoryPhysics(inst)

        inst.AnimState:SetBank("neutronium_"..toolName)
        inst.AnimState:SetBuild("neutronium_"..toolName)
        inst.AnimState:PlayAnimation("idle")

        inst:AddTag("neutronium_"..toolName)

        inst:AddTag("sharp")

        inst:AddTag("tool")

        inst:AddTag("shadowlevel")

        inst:AddTag("weapon")

        MakeInventoryFloatable(inst, "med", 0.05, {0.75, 0.4, 0.75})

        if commonFn ~= nil then
            commonFn(inst)
        end

        if not TheWorld.ismastersim then
            return inst
        end

        inst:AddComponent("inspectable")

        if(toolName == "pitchfork") then
            inst:AddComponent("terraformer")
            inst:AddInherentAction(ACTIONS.TERRAFORM)
        elseif(toolName == "hoe") then
            inst:AddComponent("farmtiller")
            inst:AddInherentAction(ACTIONS.TILL)
        else
            inst:AddComponent("tool")
            inst.components.tool:SetAction(actionToolType, 20)
            inst.components.tool:EnableToughWork(true)
        end

        inst:AddComponent("inventoryitem")
        inst.components.inventoryitem.imagename = "neutronium_"..toolName
        inst.components.inventoryitem.atlasname = "images/inventoryimages/neutronium_"..toolName..".xml"
        
        inst:AddComponent("equippable")
        inst.components.equippable:SetOnEquip(OnEquipFn)
        inst.components.equippable:SetOnUnequip(OnUnequipFn)
        
        inst:AddComponent("weapon")

        inst.components.floater:SetBankSwapOnFloat(true, -11, {sym_build = "neutronium_"..toolName})

        inst:AddComponent("shadowlevel")
        inst.components.shadowlevel:SetDefaultLevel(TUNING.NEUTRONIUM_TOOL_SHADOW_LEVEL)

        --inst.components.workmultiplier:SetSpecialMultiplierFn(SpecialWorkMultiplierFn)

        MakeHauntableLaunch(inst)

        if masterFn ~= nil then
            masterFn(inst)
        end

        return inst
    end

    return Prefab("neutronium_"..toolName, mainFn, prefabs, assets)
end

return MakeNeutroniumToolPrefab