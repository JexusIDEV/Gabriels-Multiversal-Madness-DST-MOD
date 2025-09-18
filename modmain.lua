PrefabFiles = {
    --chars
    "gabriel_eipa_unae",
    "gabriel_eipa_unae_none",

    --prefab tool
    "neutronium_pickaxe",
    "neutronium_axe",
    "neutronium_shovel",
    "neutronium_hammer",
    "neutronium_hoe",
    "neutronium_pitchfork",
    "neutronium_sword",
}

Assets = {
    --characters textures
    --gabriel
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

    --inventory images

    --NEUTRONIUM TOOLS
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

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local TECH = GLOBAL.TECH  --get the tech level for unlocking the recipe
local Ingredient = GLOBAL.Ingredient --get ingredients for recipes
local RECIPETABS = GLOBAL.RECIPETABS --recipe tabs no further explanation
local STRINGS = GLOBAL.STRINGS --putting info for your item
local ACTIONS = GLOBAL.ACTIONS --make item
local Action = GLOBAL.Action --ditto

STRINGS.CHARACTER_TITLES.gabriel_eipa_unae = "The Alien and Outer One."
STRINGS.CHARACTER_NAMES.gabriel_eipa_unae = "Gabriel Eipa Unae"
STRINGS.CHARACTER_DESCRIPTIONS.gabriel_eipa_unae = "*a\n*b\n*c"
STRINGS.CHARACTER_QUOTES.gabriel_eipa_unae = "oh dear, ¡The multiversal madness!"
STRINGS.CHARACTER_SURVIVABILITY.gabriel_eipa_unae = "Slim or Grim?"

STRINGS.CHARACTERS.GABRIEL_EIPA_UNAE = require "speech_gabriel_eipa_unae"

STRINGS.NAMES.GABRIEL_EIPA_UNAE = "Gabriel Eipa Unae"
STRINGS.SKIN_NAMES.gabriel_eipa_unae_none = "Basic"

AddMinimapAtlas("images/map_icons/gabriel_eipa_unae.xml")
AddModCharacter("gabriel_eipa_unae", "NEUTRAL", nil)

--tools

AddMinimapAtlas("images/inventoryimages/neutronium_axe.xml")
STRINGS.NAMES.NEUTRONIUM_AXE = "Neutronium Axe"
STRINGS.RECIPE_DESC.NEUTRONIUM_AXE = "¡Become the real Chopper!"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.NEUTRONIUM_AXE = "Cutting cutter"

AddCharacterRecipe(
    "neutronium_axe", 
    { Ingredient("nightmarefuel", 5) }, 
    TECH.NONE, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/neutronium_axe.xml"
    },
    { --filters
        "TOOLS",
    }
)

AddMinimapAtlas("images/inventoryimages/neutronium_pickaxe.xml")
STRINGS.NAMES.NEUTRONIUM_PICKAXE = "Neutronium Pickaxe"
STRINGS.RECIPE_DESC.NEUTRONIUM_PICKAXE = "¡Better, Faster, Stronger!"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.NEUTRONIUM_PICKAXE = "Pretty, sharp and terrifying."

AddCharacterRecipe(
    "neutronium_pickaxe", 
    { Ingredient("nightmarefuel", 5) }, 
    TECH.NONE, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/neutronium_pickaxe.xml"
    },
    { --filters
        "TOOLS",
    }
)

AddMinimapAtlas("images/inventoryimages/neutronium_shovel.xml")
STRINGS.NAMES.NEUTRONIUM_SHOVEL = "Neutronium Shovel"
STRINGS.RECIPE_DESC.NEUTRONIUM_SHOVEL = "Dig the World"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.NEUTRONIUM_SHOVEL = "An truly excavator"

AddCharacterRecipe(
    "neutronium_shovel", 
    { Ingredient("nightmarefuel", 5) }, 
    TECH.NONE, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/neutronium_shovel.xml"
    },
    { --filters
        "TOOLS",
    }
)

AddMinimapAtlas("images/inventoryimages/neutronium_hammer.xml")
STRINGS.NAMES.NEUTRONIUM_HAMMER = "Neutronium Hammer"
STRINGS.RECIPE_DESC.NEUTRONIUM_HAMMER = "Destroy everything"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.NEUTRONIUM_HAMMER = "Feels dense and TRULY terrifying..."

AddCharacterRecipe(
    "neutronium_hammer", 
    { Ingredient("nightmarefuel", 5) }, 
    TECH.NONE, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/neutronium_hammer.xml"
    },
    { --filters
        "TOOLS",
    }
)

AddMinimapAtlas("images/inventoryimages/neutronium_hoe.xml")
STRINGS.NAMES.NEUTRONIUM_HOE = "Neutronium Gardener Hoe"
STRINGS.RECIPE_DESC.NEUTRONIUM_HOE = "¡¡¡GARDENING IS NOT ENOUGH!!!"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.NEUTRONIUM_HOE = "¡Sharpey!"

AddCharacterRecipe(
    "neutronium_hoe", 
    { Ingredient("nightmarefuel", 5) }, 
    TECH.NONE, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/neutronium_hoe.xml"
    },
    { --filters
        "TOOLS",
        "GARDENING"
    }
)

AddMinimapAtlas("images/inventoryimages/neutronium_pitchfork.xml")
STRINGS.NAMES.NEUTRONIUM_PITCHFORK = "Neutronium Pitchfork"
STRINGS.RECIPE_DESC.NEUTRONIUM_PITCHFORK = "¡Become the best decorator!"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.NEUTRONIUM_PITCHFORK = "The beauty of decoration"

AddCharacterRecipe(
    "neutronium_pitchfork", 
    { Ingredient("nightmarefuel", 5) }, 
    TECH.NONE, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/neutronium_pitchfork.xml"
    },
    { --filters
        "TOOLS",
    }
)

AddMinimapAtlas("images/inventoryimages/neutronium_sword.xml")
STRINGS.NAMES.NEUTRONIUM_SWORD = "Neutronium Sword"
STRINGS.RECIPE_DESC.NEUTRONIUM_SWORD = "The infinity and \nthe cosmos in your hand."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.NEUTRONIUM_SWORD = "I'm the destructor now,\n¡HAHAHA!"

AddCharacterRecipe(
    "neutronium_sword", 
    { Ingredient("nightmarefuel", 5) }, 
    TECH.NONE, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/neutronium_sword.xml"
    },
    { --filters
        "WEAPONS",
    }
)