local PLANT_DEFS = require("prefabs/farm_plant_defs").PLANT_DEFS
local FRAMES = GLOBAL.FRAMES

local function MakeGrowTimes(germination_min, germination_max, full_grow_min, full_grow_max) -- From farm_plant_defs.lua, makes the time in which the plant grows and germinates
	local grow_time = {}

	-- germination time
	grow_time.seed		= {germination_min, germination_max}

	-- grow time
	grow_time.sprout	= {full_grow_min * 0.5, full_grow_max * 0.5}
	grow_time.small		= {full_grow_min * 0.3, full_grow_max * 0.3}
	grow_time.med		= {full_grow_min * 0.2, full_grow_max * 0.2}

	-- harvestable perish time
	grow_time.full		= 4 * TUNING.TOTAL_DAY_TIME
	grow_time.oversized	= 6 * TUNING.TOTAL_DAY_TIME
	grow_time.regrow	= {4 * TUNING.TOTAL_DAY_TIME, 5 * TUNING.TOTAL_DAY_TIME} -- min, max

	return grow_time
end

local drink_low = TUNING.FARM_PLANT_DRINK_LOW -- Low water needs
local drink_med = TUNING.FARM_PLANT_DRINK_MED -- Medium water needs
local drink_high = TUNING.FARM_PLANT_DRINK_HIGH -- High water needs

local S = TUNING.FARM_PLANT_CONSUME_NUTRIENT_LOW -- Low nutrient needs
local M = TUNING.FARM_PLANT_CONSUME_NUTRIENT_MED -- Medium nutrient needs
local L = TUNING.FARM_PLANT_CONSUME_NUTRIENT_HIGH -- High nutrient needs

PLANT_DEFS.infinity_catalyst = {build = "farm_plant_infinity_catalyst", bank = "farm_plant_infinity_catalyst"} -- Build and bank of the plant
PLANT_DEFS.infinity_catalyst.prefab = "farm_plant_infinity_catalyst" -- Prefab for the plant
PLANT_DEFS.infinity_catalyst.product = "infinity_catalyst" -- The fruit or veggie that the plant produces
PLANT_DEFS.infinity_catalyst.product_oversized = "infinity_catalyst_oversized" -- The fruit or veggie that the giant plant produces
PLANT_DEFS.infinity_catalyst.seed = "infinity_catalyst_seeds" -- The seeds the fruit or veggie gives when harvested
PLANT_DEFS.infinity_catalyst.family_min_count = 1 -- The number of the plant needed to make the plant happy
PLANT_DEFS.infinity_catalyst.family_check_dist = 1 -- The distance up to where it checks for plants
PLANT_DEFS.infinity_catalyst.plant_type_tag = nil -- I honestly don't know what this does, but if you know, tell me in the comments. It's probably still needed
PLANT_DEFS.infinity_catalyst.grow_time = MakeGrowTimes(12*TUNING.SEG_TIME, 16*TUNING.SEG_TIME, 4*TUNING.TOTAL_DAY_TIME, 7*TUNING.TOTAL_DAY_TIME) -- The time it takes for the plant to germinate and grow (germination minimum, germination maximum, growth minimum, growth maximum)
PLANT_DEFS.infinity_catalyst.moisture = {drink_rate = drink_high, min_percent = TUNING.FARM_PLANT_DROUGHT_TOLERANCE} -- How much water the plant needs
PLANT_DEFS.infinity_catalyst.good_seasons = {autumn = true, spring = true, summer = true, winter = true} -- The season in which the plant is comfortable
PLANT_DEFS.infinity_catalyst.nutrient_consumption = {L, L, L} -- How much of each fertilizaer the plant needs {Seaweed, Compost, Manure}
PLANT_DEFS.infinity_catalyst.max_killjoys_tolerance = TUNING.FARM_PLANT_KILLJOY_TOLERANCE -- The plant's tolerance to killjoys, AKA, anything that would stress it out
PLANT_DEFS.infinity_catalyst.weight_data = { 361.51, 506.04, .28 } -- The weight of the plant { min, max, sigmoid }
PLANT_DEFS.infinity_catalyst.sounds = PLANT_DEFS.potato.sounds -- The sounds the plant makes when growing

PLANT_DEFS.infinity_catalyst.pictureframeanim = {anim = "emoteXL_loop_dance8", time = 27*FRAMES} -- The pose of your character as it appears in the registry
PLANT_DEFS.infinity_catalyst.plantregistrywidget = "widgets/redux/farmplantpage" -- This should remain unchanged, it's what appears when you click on your plant
PLANT_DEFS.infinity_catalyst.plantregistrysummarywidget = "widgets/redux/farmplantsummarywidget" -- This should remain unchanged, this is the summary that appears at the end of the plant preview
PLANT_DEFS.infinity_catalyst.plantregistryinfo = { -- This should remain unchanged, it's what shows the animations in the preview and plant page
    {
        text = "seed",
        anim = "crop_seed",
        grow_anim = "grow_seed",
        learnseed = true,
        growing = true,
    },
    {
        text = "sprout",
        anim = "crop_sprout",
        grow_anim = "grow_sprout",
        growing = true,
    },
    {
        text = "small",
        anim = "crop_small",
        grow_anim = "grow_small",
        growing = true,
    },
    {
        text = "medium",
        anim = "crop_med",
        grow_anim = "grow_med",
        growing = true,
    },
    {
        text = "grown",
        anim = "crop_full",
        grow_anim = "grow_full",
        revealplantname = true,
        fullgrown = true,
    },
    {
        text = "oversized",
        anim = "crop_oversized",
        grow_anim = "grow_oversized",
        revealplantname = true,
        fullgrown = true,
        hidden = true,
    },
    {
        text = "rotting",
        anim = "crop_rot",
        grow_anim = "grow_rot",
        stagepriority = -100,
        is_rotten = true,
        hidden = true,
    },
    {
        text = "oversized_rotting",
        anim = "crop_rot_oversized",
        grow_anim = "grow_rot_oversized",
        stagepriority = -100,
        is_rotten = true,
        hidden = true,
    },
}