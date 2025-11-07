GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})

PrefabFiles = {
    --chars
    "gabriel_eipa_unae",
    "gabriel_eipa_unae_none",

    --MACHINES
    "neutron_collector",

    --material world prefab
    "mod_rocks",

    --materials

    ---ressss
    "basic_resources",

    --tech
    "mod_circuits",

    ---neutronium
    "neutronium",

    ---cristalyium
    "cristalyium",

    --infinity
    "impure_infinity",
    "infinity_plant",
    "infinity_catalyst",
    "infinity_matter",

    --prefab tool
    "neutronium_axe",
    "neutronium_pickaxe",
    "neutronium_shovel",
    "neutronium_hammer",
    "neutronium_pitchfork",
    "neutronium_hoe",
    "neutronium_sword",
}

Assets = {
    --SHADERS
    ---Asset("SHADER","shaders/infinity.ksh"),

    --characters textures
    ---gabriel eipa unae
    Asset( "IMAGE", "images/saveslot_portraits/gabriel_eipa_unae.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/gabriel_eipa_unae.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/gabriel_eipa_unae.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/gabriel_eipa_unae.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/gabriel_eipa_unae_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/gabriel_eipa_unae_silho.xml" ),

    Asset( "IMAGE", "bigportraits/gabriel_eipa_unae.tex" ),
    Asset( "ATLAS", "bigportraits/gabriel_eipa_unae.xml" ),
	
	Asset( "IMAGE", "images/map_icons/gabriel_eipa_unae.tex" ),
	Asset( "ATLAS", "images/map_icons/gabriel_eipa_unae.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_gabriel_eipa_unae.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_gabriel_eipa_unae.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_gabriel_eipa_unae.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_gabriel_eipa_unae.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_gabriel_eipa_unae.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_gabriel_eipa_unae.xml" ),
	
	Asset( "IMAGE", "images/names_gabriel_eipa_unae.tex" ),
    Asset( "ATLAS", "images/names_gabriel_eipa_unae.xml" ),
	
    Asset( "IMAGE", "images/names_gold_gabriel_eipa_unae.tex" ),
    Asset( "ATLAS", "images/names_gold_gabriel_eipa_unae.xml" ),

    ---kemu tensara neito
    
    ---perkas wilklit aezton

    --HUD related
    Asset("IMAGE", "images/hud/criptian_tech.tex"),
    Asset("ATLAS", "images/hud/criptian_tech.xml"),

    --inventory images

    ---basic resources

    Asset("ATLAS", "images/inventoryimages/gravel.xml"),
    Asset("IMAGE", "images/inventoryimages/gravel.tex"),

    Asset("ATLAS", "images/inventoryimages/sand.xml"),
    Asset("IMAGE", "images/inventoryimages/sand.tex"),

    Asset("ATLAS", "images/inventoryimages/glass.xml"),
    Asset("IMAGE", "images/inventoryimages/glass.tex"),

    ---HOLY TECH
    Asset("ATLAS", "images/inventoryimages/circuit_tier_i.xml"),
    Asset("IMAGE", "images/inventoryimages/circuit_tier_i.tex"),

    Asset("ATLAS", "images/inventoryimages/circuit_tier_ii.xml"),
    Asset("IMAGE", "images/inventoryimages/circuit_tier_ii.tex"),

    Asset("ATLAS", "images/inventoryimages/circuit_tier_iii.xml"),
    Asset("IMAGE", "images/inventoryimages/circuit_tier_iii.tex"),

    Asset("ATLAS", "images/map_icons/neutron_collector.xml"),
    Asset("IMAGE", "images/map_icons/neutron_collector.tex"),

    --CRISTALYIUM STUFF
    Asset("ATLAS", "images/inventoryimages/raw_cristalyium.xml"),
    Asset("IMAGE", "images/inventoryimages/raw_cristalyium.tex"),

    Asset("ATLAS", "images/inventoryimages/pure_cristalyium.xml"),
    Asset("IMAGE", "images/inventoryimages/pure_cristalyium.tex"),

    Asset("ATLAS", "images/inventoryimages/cristalyium_juice.xml"),
    Asset("IMAGE", "images/inventoryimages/cristalyium_juice.tex"),

    Asset("ATLAS", "images/inventoryimages/redlium_juice.xml"),
    Asset("IMAGE", "images/inventoryimages/redlium_juice.tex"),

    Asset("ATLAS", "images/inventoryimages/ornalenium_juice.xml"),
    Asset("IMAGE", "images/inventoryimages/ornalenium_juice.tex"),

    Asset("ATLAS", "images/inventoryimages/yellonite_juice.xml"),
    Asset("IMAGE", "images/inventoryimages/yellonite_juice.tex"),

    Asset("ATLAS", "images/inventoryimages/greenulium_juice.xml"),
    Asset("IMAGE", "images/inventoryimages/greenulium_juice.tex"),

    Asset("ATLAS", "images/inventoryimages/cyanulium_juice.xml"),
    Asset("IMAGE", "images/inventoryimages/cyanulium_juice.tex"),

    Asset("ATLAS", "images/inventoryimages/blunium_juice.xml"),
    Asset("IMAGE", "images/inventoryimages/blunium_juice.tex"),

    Asset("ATLAS", "images/inventoryimages/purpulium_juice.xml"),
    Asset("IMAGE", "images/inventoryimages/purpulium_juice.tex"),

    Asset("ATLAS", "images/inventoryimages/magente_juice.xml"),
    Asset("IMAGE", "images/inventoryimages/magente_juice.tex"),

    Asset("ATLAS", "images/map_icons/cristalyium_ore.xml"),
    Asset("IMAGE", "images/map_icons/cristalyium_ore.tex"),

    --INFINITY STUFF
    Asset("ATLAS", "images/inventoryimages/infinity_matter.xml"),
    Asset("IMAGE", "images/inventoryimages/infinity_matter.tex"),

    Asset("ATLAS", "images/inventoryimages/infinity_catalyst_seeds.xml"),
    Asset("IMAGE", "images/inventoryimages/infinity_catalyst_seeds.tex"),

    Asset("ATLAS", "images/inventoryimages/infinity_catalyst.xml"),
    Asset("IMAGE", "images/inventoryimages/infinity_catalyst.tex"),

    Asset("ATLAS", "images/inventoryimages/impure_infinity.xml"),
    Asset("IMAGE", "images/inventoryimages/impure_infinity.tex"),

    --NEUTRONIUM TOOLS AND STUFF
    Asset("ATLAS", "images/inventoryimages/neutronium.xml"),
    Asset("IMAGE", "images/inventoryimages/neutronium.tex"),

    Asset("ATLAS", "images/inventoryimages/neutronium_pile.xml"),
    Asset("IMAGE", "images/inventoryimages/neutronium_pile.tex"),

    Asset("ATLAS", "images/inventoryimages/neutronium_pickaxe.xml"),
    Asset("IMAGE", "images/inventoryimages/neutronium_pickaxe.tex"),

    Asset("ATLAS", "images/inventoryimages/neutronium_axe.xml"),
    Asset("IMAGE", "images/inventoryimages/neutronium_axe.tex"),

    Asset("ATLAS", "images/inventoryimages/neutronium_shovel.xml"),
    Asset("IMAGE", "images/inventoryimages/neutronium_shovel.tex"),

    Asset("ATLAS", "images/inventoryimages/neutronium_hammer.xml"),
    Asset("IMAGE", "images/inventoryimages/neutronium_hammer.tex"),

    Asset("ATLAS", "images/inventoryimages/neutronium_pitchfork.xml"),
    Asset("IMAGE", "images/inventoryimages/neutronium_pitchfork.tex"),

    Asset("ATLAS", "images/inventoryimages/neutronium_hoe.xml"),
    Asset("IMAGE", "images/inventoryimages/neutronium_hoe.tex"),

    Asset("ATLAS", "images/inventoryimages/neutronium_sword.xml"),
    Asset("IMAGE", "images/inventoryimages/neutronium_sword.tex"),
}

--[[ for future translations
local mod_loc_files = {
    "common",
    "ui",
}

local locale = {
    "en-us",
    "es-es",
}

local user_setting_lan = GetModConfigData("language")       --读取Mod语言自定义设置
local loc = require "languages/loc"
local lan = loc and loc.GetLanguage and loc.GetLanguage()   --读取玩家的客户端语言设置
local folder = ""
if user_setting_lan == "CHINESE" then
    folder = "zh-cn"
elseif user_setting_lan == "ENGLISH" then
    folder = "en"
else
    if lan == LANGUAGE.CHINESE_S or lan == LANGUAGE.CHINESE_S_RAIL then
        folder = "zh-cn"
    else
        folder = "en"
    end
end
assert(folder and folder ~= "", "[Efficient Agriculture Error] Failed to load loc file")    --语言设置报错
for _, f_name in ipairs(mod_loc_files) do
    modimport("scripts/localization/"..folder.."/"..f_name)     --加载所有本地化文件
end
]]

--external imported important scripts
modimport("scripts/locale/common_locale.lua")
modimport("corescripts/mod_plants.lua")
modimport("corescripts/mod_recipes.lua")

--inventory and widgets ugh
modimport("corescripts/mod_ui.lua")
modimport("corescripts/mod_containers.lua")

--minimap atlas
AddMinimapAtlas("images/map_icons/gabriel_eipa_unae.xml")
AddMinimapAtlas("images/map_icons/neutron_collector.xml")
AddMinimapAtlas("images/map_icons/cristalyium_ore.xml")

--add other things
AddModCharacter("gabriel_eipa_unae", "NEUTRAL", nil)