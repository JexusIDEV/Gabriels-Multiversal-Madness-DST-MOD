--used by gabriel for energy codex mechanics and vitality of itself
--define tuning
TUNING.GABRIEL_MAX_CODEX_ENERGY = 500
TUNING.GABRIEL_BASE_MULT_CODEX_DRAIN_ENERGY = 1.25
local STATE_DATA = {
    ["normal"] = {

    },
    ["neutronium"] = {

    },
    ["god"] =  {

    },
}

local function OnCurrent(self, current)
    local percent = math.ceil(100 * current / self.max) -- convert it to a percent between 0 and 100
    if self.inst.player_classified ~= nil then
        assert(percent >= 0 and percent <= 255, "Player currentcodexenergy out of range: "..tostring(percent))
        self.inst.player_classified.currentmightiness:set(percent)
    end
end

local function OnTaskTick(inst, self, period)
	if self.drain_delay <= GetTime() then
	    self:DoDec(period)
	end
end

local CriptianEnergy = Class(function(self, inst)
    self.inst = inst
    self.max = TUNING.GABRIEL_MAX_CODEX_ENERGY
    self.current = self.max/(1/3)

    self.drain_delay = 0

    local period = 1
    self.inst:DoPeriodicTask(period, OnTaskTick, nil, self, period)

    self.state = "normal"
end, nil, {OnCurrent})

--data saving and loading
function CriptianEnergy:OnSave()
    return { criptianism = self.current } or nil
end

function CriptianEnergy:OnLoad(data)
    if data.criptianism ~= nil and self.current ~= data.criptianism then
        self.current = data.criptianism
        self:DoDelta(0, true)
    end
end

--form state
function CriptianEnergy:getCurrentFormState()
    return self.state
end

function CriptianEnergy:setCurrentFormState(stateForm)
    self.state = stateForm
end

function CriptianEnergy:isGodForm()
    return self.state == "god"
end

function CriptianEnergy:isNeutroniumForm()
    return self.state == "neutronium"
end

function CriptianEnergy:isNormalForm()
    return self.state == "normal"
end

--energy codex
function CriptianEnergy:getCurrentEnergyCodex()
    return self.current
end

function CriptianEnergy:getMaxEnergyCodex()
    return self.max
end

function CriptianEnergy:getMinEnergyCodex()
    return 0
end

function CriptianEnergy:SetCurrentEnergyCodex(amount)
    self.current = amount
end

return CriptianEnergy