local FastTool = Class(function (self, inst)
    self.inst = inst
    self.speed_multi = 2
end)

function FastTool:SetSpeedMulti(value)
     self.speed_multi = value
end

function FastTool:GetSpeedMulti()
    return self.speed_multi
end

return FastTool