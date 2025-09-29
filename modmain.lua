PrefabFiles = {
    --chars
    "gabriel_eipa_unae",
    "gabriel_eipa_unae_none",

    --material world prefab
    "mod_rocks",

    --materials
    "raw_cristalyium",
    "neutronium",
    "infinity_matter",

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
    --SHADERS
    --Asset("SHADER","shaders/infinity.ksh"),

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

    --HUD related
    Asset("IMAGE", "images/hud/criptian_tech.tex"),
    Asset("ATLAS", "images/hud/criptian_tech.xml"),

    --inventory images

    --CRISTALYIUM STUFF
    Asset("ATLAS", "images/inventoryimages/raw_cristalyium.xml"),
    Asset("IMAGE", "images/inventoryimages/raw_cristalyium.tex"),

    Asset("ATLAS", "images/map_icons/cristalyium_ore.xml"),
    Asset("IMAGE", "images/map_icons/cristalyium_ore.tex"),

    --INFINITY STUFF
    Asset("ATLAS", "images/inventoryimages/infinity_matter.xml"),
    Asset("IMAGE", "images/inventoryimages/infinity_matter.tex"),

    --NEUTRONIUM TOOLS AND STUFF
    Asset("ATLAS", "images/inventoryimages/neutronium.xml"),
    Asset("IMAGE", "images/inventoryimages/neutronium.tex"),

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

AddRecipeFilter({
    name="CRIPTIAN",
    atlas="images/hud/criptian_tech.xml",
    image="criptian_tech.tex"
})

STRINGS.UI.CRAFTING_FILTERS.CRIPTIAN = "Criptian Technology"

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

--CRISTALYIUM

AddMinimapAtlas("images/map_icons/cristalyium_ore.xml")
STRINGS.NAMES.CRISTALYIUM_ORE = "Cristalyium Ore"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.CRISTALYIUM_ORE = "Why is it so purple and shiny?"

AddMinimapAtlas("images/inventoryimages/raw_cristalyium.xml")
STRINGS.NAMES.RAW_CRISTALYIUM = "Raw Cristalyium"
STRINGS.RECIPE_DESC.RAW_CRISTALYIUM = "What???"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.RAW_CRISTALYIUM = "What a weird material..."

AddCharacterRecipe(
    "raw_cristalyium", 
    {
        Ingredient("moonglass", 10),
    }, 
    TECH.SCIENCE_THREE, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/raw_cristalyium.xml"
    },
    { --filters
        "REFINE",
        "SCIENCE",
        "CRIPTIAN",
    }
)

--infinity stuff

AddMinimapAtlas("images/inventoryimages/infinity_matter.xml")
STRINGS.NAMES.INFINITY_MATTER = "Infinity"
STRINGS.RECIPE_DESC.INFINITY_MATTER = "¡Wait! How this exists?"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.INFINITY_MATTER = "Too bright...\nBut beautifully colorfull."

AddCharacterRecipe(
    "infinity_matter", 
    {
        Ingredient("moonglass", 10),
    }, 
    TECH.SCIENCE_THREE, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/infinity_matter.xml"
    },
    { --filters
        "REFINE",
        "SCIENCE",
        "CRIPTIAN",
    }
)

--tools and neutronium stuff

AddMinimapAtlas("images/inventoryimages/neutronium.xml")
STRINGS.NAMES.NEUTRONIUM = "Neutronium"
STRINGS.RECIPE_DESC.NEUTRONIUM = "More beyond the stars..."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.NEUTRONIUM = "It's feels strangely dense...\nAnd it's so dark and bright at the same time..."

AddCharacterRecipe(
    "neutronium", 
    {
        Ingredient("nightmarefuel", 20),
        Ingredient("horrorfuel", 20),
    }, 
    TECH.SCIENCE_THREE, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/neutronium.xml"
    },
    { --filters
        "REFINE",
        "SCIENCE",
        "CRIPTIAN",
    }
)

AddMinimapAtlas("images/inventoryimages/neutronium_axe.xml")
STRINGS.NAMES.NEUTRONIUM_AXE = "Neutronium Axe"
STRINGS.RECIPE_DESC.NEUTRONIUM_AXE = "¡Become the real Chopper!"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.NEUTRONIUM_AXE = "Cutting cutter"

AddCharacterRecipe(
    "neutronium_axe", 
    { Ingredient("neutronium", 5, "images/inventoryimages/neutronium.xml") }, 
    TECH.NONE, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/neutronium_axe.xml"
    },
    { --filters
        "TOOLS",
        "CRIPTIAN",
    }
)

AddMinimapAtlas("images/inventoryimages/neutronium_pickaxe.xml")
STRINGS.NAMES.NEUTRONIUM_PICKAXE = "Neutronium Pickaxe"
STRINGS.RECIPE_DESC.NEUTRONIUM_PICKAXE = "¡Better, Faster, Stronger!"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.NEUTRONIUM_PICKAXE = "Pretty, sharp and terrifying."

AddCharacterRecipe(
    "neutronium_pickaxe", 
    { Ingredient("neutronium", 5, "images/inventoryimages/neutronium.xml") }, 
    TECH.NONE, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/neutronium_pickaxe.xml"
    },
    { --filters
        "TOOLS",
        "CRIPTIAN",
    }
)

AddMinimapAtlas("images/inventoryimages/neutronium_shovel.xml")
STRINGS.NAMES.NEUTRONIUM_SHOVEL = "Neutronium Shovel"
STRINGS.RECIPE_DESC.NEUTRONIUM_SHOVEL = "Dig the World"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.NEUTRONIUM_SHOVEL = "An truly excavator"

AddCharacterRecipe(
    "neutronium_shovel", 
    { Ingredient("neutronium", 5, "images/inventoryimages/neutronium.xml") }, 
    TECH.NONE, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/neutronium_shovel.xml"
    },
    { --filters
        "TOOLS",
        "CRIPTIAN",
    }
)

AddMinimapAtlas("images/inventoryimages/neutronium_hammer.xml")
STRINGS.NAMES.NEUTRONIUM_HAMMER = "Neutronium Hammer"
STRINGS.RECIPE_DESC.NEUTRONIUM_HAMMER = "Destroy everything"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.NEUTRONIUM_HAMMER = "Feels dense and TRULY terrifying..."

AddCharacterRecipe(
    "neutronium_hammer", 
    { Ingredient("neutronium", 5, "images/inventoryimages/neutronium.xml") }, 
    TECH.NONE, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/neutronium_hammer.xml"
    },
    { --filters
        "TOOLS",
        "CRIPTIAN",
    }
)

AddMinimapAtlas("images/inventoryimages/neutronium_hoe.xml")
STRINGS.NAMES.NEUTRONIUM_HOE = "Neutronium Gardener Hoe"
STRINGS.RECIPE_DESC.NEUTRONIUM_HOE = "¡¡¡GARDENING IS NOT ENOUGH!!!"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.NEUTRONIUM_HOE = "¡Sharpey!"

AddCharacterRecipe(
    "neutronium_hoe", 
    { Ingredient("neutronium", 5, "images/inventoryimages/neutronium.xml") }, 
    TECH.NONE, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/neutronium_hoe.xml"
    },
    { --filters
        "TOOLS",
        "GARDENING",
        "CRIPTIAN",
    }
)

AddMinimapAtlas("images/inventoryimages/neutronium_pitchfork.xml")
STRINGS.NAMES.NEUTRONIUM_PITCHFORK = "Neutronium Pitchfork"
STRINGS.RECIPE_DESC.NEUTRONIUM_PITCHFORK = "¡Become the best decorator!"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.NEUTRONIUM_PITCHFORK = "The beauty of decoration"

AddCharacterRecipe(
    "neutronium_pitchfork", 
    { Ingredient("neutronium", 5, "images/inventoryimages/neutronium.xml") }, 
    TECH.NONE, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/neutronium_pitchfork.xml"
    },
    { --filters
        "TOOLS",
        "CRIPTIAN",
    }
)

AddMinimapAtlas("images/inventoryimages/neutronium_sword.xml")
STRINGS.NAMES.NEUTRONIUM_SWORD = "Neutronium Sword"
STRINGS.RECIPE_DESC.NEUTRONIUM_SWORD = "The infinity and \nthe cosmos in your hand."
STRINGS.CHARACTERS.GENERIC.DESCRIBE.NEUTRONIUM_SWORD = "I'm the destructor now,\n¡HAHAHA!"

AddCharacterRecipe(
    "neutronium_sword", 
    { Ingredient("neutronium", 5, "images/inventoryimages/neutronium.xml") }, 
    TECH.NONE, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/neutronium_sword.xml"
    },
    { --filters
        "WEAPONS",
        "CRIPTIAN",
    }
)