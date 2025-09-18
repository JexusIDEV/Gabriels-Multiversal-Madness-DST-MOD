local tool_base = {
    toolName = "",
    NEUTRONIUM_SHADOW_LEVEL = 4,
    NEUTRONIUM_BASE_WALK_SPEED_MULT = 1.5,
}

function tool_base:GetToolName()
    return self.toolName
end

function tool_base:SetToolName(_toolName)
    self.toolName = _toolName
end

function tool_base:OnEquip(inst, owner)
	local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("equipskinneditem", inst:GetSkinName())
        owner.AnimState:OverrideItemSkinSymbol("swap_object", skin_build, "neutronium_"..self.GetToolName, inst.GUID, "swap_object")
    else
        owner.AnimState:OverrideSymbol("swap_object", "neutronium_"..self.GetToolName, "swap_object")
    end
	owner.AnimState:Show("ARM_carry")
	owner.AnimState:Hide("ARM_normal")
end

function tool_base:OnUnequip(inst, owner) 
	owner.AnimState:Hide("ARM_carry") 
	owner.AnimState:Show("ARM_normal")
    local skin_build = inst:GetSkinBuild()
    if skin_build ~= nil then
        owner:PushEvent("unequipskinneditem", inst:GetSkinName())
    end
end

function tool_base:DataBeforeMasterSim(inst)
    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    --inst:AddTag("light")

    MakeInventoryPhysics(inst)

    local minimap = inst.entity:AddMiniMapEntity()
	minimap:SetIcon("neutronium_"..self.GetToolName..".tex")

    inst.AnimState:SetBank("neutronium_"..self.GetToolName.."_ground")
    inst.AnimState:SetBuild("neutronium_"..self.GetToolName.."_ground")
    inst.AnimState:PlayAnimation("idle")

    inst:AddTag("neutronium_"..self.GetToolName)

    inst:AddTag("sharp")

    inst:AddTag("tool")

    inst:AddTag("shadowlevel")

    inst:AddTag("weapon")

    MakeInventoryFloatable(inst, "med", 0.05, {0.75, 0.4, 0.75})
end

function tool_base:DataAfterMasterSim(inst)
    inst:AddComponent("inspectable")

    inst:AddComponent("tool")
    inst.components.tool:SetAction(ACTIONS.MINE)
    inst.components.tool:EnableToughWork(true)

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "neutronium_"..self.GetToolName
    inst.components.inventoryitem.atlasname = "images/inventoryimages/neutronium_"..self.GetToolName..".xml"
    
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip(OnEquip)
    inst.components.equippable:SetOnUnequip(OnUnequip)
    inst.components.equippable.walkspeedmult = 1 * self.NEUTRONIUM_BASE_WALK_SPEED_MULT

	inst:AddComponent("weapon")
	inst.components.weapon:SetDamage(TUNING.NEUTRONIUM_PICKAXE_DAMAGE)

    inst.components.weapon.attackwear = 1 / TUNING.NEUTRONIUM_PICKAXE_FACTOR

    inst.components.floater:SetBankSwapOnFloat(true, -11, {sym_build = "neutronium_"..self.GetToolName})

    inst:AddComponent("shadowlevel")
    inst.components.shadowlevel:SetDefaultLevel(self.NEUTRONIUM_SHADOW_LEVEL)

	MakeHauntableLaunch(inst)
end

function tool_base:GenerateToolDataFn(inst)
    tool_base:DataBeforeMasterSim(inst)

    if not TheWorld.ismastersim then
        return inst
    end

    tool_base:DataAfterMasterSim(inst)
end 

return tool_base