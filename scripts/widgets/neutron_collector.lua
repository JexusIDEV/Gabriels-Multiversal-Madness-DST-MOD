local Text = require "widgets/text"
local Widget = require "widgets/widget"

local neutron_collector = Class(Widget, function(self, owner)
    Widget._ctor(self, "neutron_collector")
    self.owner = owner
end)