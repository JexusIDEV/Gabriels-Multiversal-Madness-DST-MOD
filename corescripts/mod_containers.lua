local containers = require "containers"
local params = {}

params.neutron_collector = {
    widget = {
        slotpos = {
            Vector3(-72, 72, 0), Vector3(0, 72, 0), Vector3(72, 72, 0),
            Vector3(-72, 0, 0), Vector3(0, 0, 0), Vector3(72, 0, 0),
            Vector3(-72, -72, 0), Vector3(0, -72, 0), Vector3(72, -72, 0),
        },
        animbank = "ui_chest_3x3",
        animbuild = "ui_chest_3x3",
        pos = Vector3(),
    },
    numslots = 9,
    acceptsstacks = true,
    usespecificslotsforitems = true,
    issidewidget = false,
    type = "chest",
}

function params.neutron_collector.itemtestfn(container, item, slot)
    return (item:HasTag("neutronium") and item:HasTag("pile"))
end

for prefabs, data in pairs(params) do
    containers.params[prefabs] = data
end