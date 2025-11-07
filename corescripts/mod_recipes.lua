local AddRecipe2 = AddRecipe2
local AddCharacterRecipe = AddCharacterRecipe
local AddRecipeFilter = AddRecipeFilter
local Ingredient = Ingredient
local TECH = TECH

--filters
AddRecipeFilter({
    name="CRIPTIAN",
    atlas="images/hud/criptian_tech.xml",
    image="criptian_tech.tex"
})

---OVERRIDE OR NEWER OG DST RECIPES
AddRecipe2(
    "messagebottleempty", 
    {
        Ingredient("glass", 1, "images/inventoryimages/glass.xml"),
    }, 
    TECH.SCIENCE_ONE, 
    { --config
        numtogive = 1
    },
    { --filters
        "REFINE",
    }
)

--circuits and tech
AddRecipe2(
    "circuit_tier_i", 
    {
        Ingredient("log", 1),
        Ingredient("goldnugget", 2),
    }, 
    TECH.SCIENCE_TWO, 
    { --config
        atlas = "images/inventoryimages/circuit_tier_i.xml",
        numtogive = 4
    },
    { --filters
        "SCIENCE",
        "REFINE",
    }
)

AddRecipe2(
    "circuit_tier_ii", 
    {
        Ingredient("circuit_tier_i", 4, "images/inventoryimages/circuit_tier_i.xml"),
        Ingredient("transistor", 1),
        Ingredient("goldnugget", 1),
    }, 
    TECH.SCIENCE_TWO, 
    { --config
        atlas = "images/inventoryimages/circuit_tier_ii.xml",
        numtogive = 2
    },
    { --filters
        "SCIENCE",
        "REFINE",
    }
)

AddRecipe2(
    "circuit_tier_iii", 
    {
        Ingredient("circuit_tier_i", 4, "images/inventoryimages/circuit_tier_i.xml"),
        Ingredient("circuit_tier_ii", 2, "images/inventoryimages/circuit_tier_ii.xml"),
        Ingredient("transistor", 3),
        Ingredient("goldnugget", 3),
    }, 
    TECH.SCIENCE_TWO, 
    { --config
        atlas = "images/inventoryimages/circuit_tier_iii.xml",
        numtogive = 1
    },
    { --filters
        "SCIENCE",
        "REFINE",
    }
)

---machines
AddCharacterRecipe(
    "neutron_collector", 
    {
        Ingredient("circuit_tier_iii", 2, "images/inventoryimages/circuit_tier_iii.xml"),
        Ingredient("cutstone", 8),
        Ingredient("transistor", 2),
        Ingredient("boards", 4),
        Ingredient("raw_cristalyium", 8, "images/inventoryimages/raw_cristalyium.xml"),
        Ingredient("gears", 4),
        Ingredient("purplegem", 2),
        Ingredient("orangegem", 2),
    }, 
    TECH.SCIENCE_TWO, 
    { --config
        builder_tag = "criptian",
        atlas = "images/map_icons/neutron_collector.xml",
        placer = "neutron_collector_placer"
    },
    { --filters
        "SCIENCE",
        "CRIPTIAN",
    }
)

--new and general materials

---basic resources

AddRecipe2(
    "gravel", 
    {
        Ingredient("rocks", 4),
    }, 
    TECH.SCIENCE_ONE, 
    { --config
        atlas = "images/inventoryimages/gravel.xml",
        numtogive = 12
    },
    { --filters
        "REFINE",
    }
)
AddRecipe2(
    "sand", 
    {
        Ingredient("gravel", 12, "images/inventoryimages/gravel.xml"),
    }, 
    TECH.SCIENCE_ONE, 
    { --config
        atlas = "images/inventoryimages/sand.xml",
        numtogive = 12
    },
    { --filters
        "REFINE",
    }
)

AddRecipe2(
    "glass", 
    {
        Ingredient("sand", 12, "images/inventoryimages/sand.xml"),
    }, 
    TECH.SCIENCE_ONE, 
    { --config
        atlas = "images/inventoryimages/glass.xml",
        numtogive = 4
    },
    { --filters
        "REFINE",
    }
)

---cristalyium

AddCharacterRecipe(
    "raw_cristalyium", 
    {
        Ingredient("cristalyium_juice", 1, "images/inventoryimages/cristalyium_juice.xml"),
    }, 
    TECH.SCIENCE_TWO, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/raw_cristalyium.xml",
        numtogive = 4
    },
    { --filters
        "REFINE",
        "SCIENCE",
        "CRIPTIAN",
    }
)
AddCharacterRecipe(
    "pure_cristalyium", 
    {
        Ingredient("raw_cristalyium", 4, "images/inventoryimages/raw_cristalyium.xml"),
        Ingredient("redlium_juice", 1, "images/inventoryimages/redlium_juice.xml"),
        Ingredient("ornalenium_juice", 1, "images/inventoryimages/ornalenium_juice.xml"),
        Ingredient("yellonite_juice", 1, "images/inventoryimages/yellonite_juice.xml"),
        Ingredient("greenulium_juice", 1, "images/inventoryimages/greenulium_juice.xml"),
        Ingredient("cyanulium_juice", 1, "images/inventoryimages/cyanulium_juice.xml"),
        Ingredient("blunium_juice", 1, "images/inventoryimages/blunium_juice.xml"),
        Ingredient("purpulium_juice", 1, "images/inventoryimages/purpulium_juice.xml"),
        Ingredient("magente_juice", 1, "images/inventoryimages/magente_juice.xml"),
    }, 
    TECH.SCIENCE_TWO, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/pure_cristalyium.xml",
        numtogive = 4
    },
    { --filters
        "REFINE",
        "CRIPTIAN",
    }
)

----ogh, the pain
AddCharacterRecipe(
    "cristalyium_juice", 
    {
        Ingredient("raw_cristalyium", 2, "images/inventoryimages/raw_cristalyium.xml"),
        Ingredient("messagebottleempty", 1),
    }, 
    TECH.SCIENCE_TWO, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/cristalyium_juice.xml",
        numtogive = 1,
    },
    { --filters
        "REFINE",
        "SCIENCE",
        "CRIPTIAN",
    }
)
AddCharacterRecipe(
    "redlium_juice", 
    {
        Ingredient("cristalyium_juice", 1, "images/inventoryimages/cristalyium_juice.xml"),
    }, 
    TECH.SCIENCE_TWO, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/redlium_juice.xml",
        numtogive = 1
    },
    { --filters
        "REFINE",
        "SCIENCE",
        "CRIPTIAN",
    }
)
AddCharacterRecipe(
    "ornalenium_juice", 
    {
        Ingredient("cristalyium_juice", 1, "images/inventoryimages/cristalyium_juice.xml"),
    }, 
    TECH.SCIENCE_TWO, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/ornalenium_juice.xml",
        numtogive = 1
    },
    { --filters
        "REFINE",
        "SCIENCE",
        "CRIPTIAN",
    }
)
AddCharacterRecipe(
    "yellonite_juice", 
    {
        Ingredient("cristalyium_juice", 1, "images/inventoryimages/cristalyium_juice.xml"),
    }, 
    TECH.SCIENCE_TWO, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/yellonite_juice.xml",
        numtogive = 1
    },
    { --filters
        "REFINE",
        "SCIENCE",
        "CRIPTIAN",
    }
)
AddCharacterRecipe(
    "greenulium_juice", 
    {
        Ingredient("cristalyium_juice", 1, "images/inventoryimages/cristalyium_juice.xml"),
    }, 
    TECH.SCIENCE_TWO, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/greenulium_juice.xml",
        numtogive = 1
    },
    { --filters
        "REFINE",
        "SCIENCE",
        "CRIPTIAN",
    }
)
AddCharacterRecipe(
    "cyanulium_juice", 
    {
        Ingredient("cristalyium_juice", 1, "images/inventoryimages/cristalyium_juice.xml"),
    }, 
    TECH.SCIENCE_TWO, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/cyanulium_juice.xml",
        numtogive = 1
    },
    { --filters
        "REFINE",
        "SCIENCE",
        "CRIPTIAN",
    }
)
AddCharacterRecipe(
    "blunium_juice", 
    {
        Ingredient("cristalyium_juice", 1, "images/inventoryimages/cristalyium_juice.xml"),
    }, 
    TECH.SCIENCE_TWO, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/blunium_juice.xml",
        numtogive = 1
    },
    { --filters
        "REFINE",
        "SCIENCE",
        "CRIPTIAN",
    }
)
AddCharacterRecipe(
    "purpulium_juice", 
    {
        Ingredient("cristalyium_juice", 1, "images/inventoryimages/cristalyium_juice.xml"),
    }, 
    TECH.SCIENCE_TWO, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/purpulium_juice.xml",
        numtogive = 1
    },
    { --filters
        "REFINE",
        "SCIENCE",
        "CRIPTIAN",
    }
)
AddCharacterRecipe(
    "magente_juice", 
    {
        Ingredient("cristalyium_juice", 1, "images/inventoryimages/cristalyium_juice.xml"),
    }, 
    TECH.SCIENCE_TWO, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/magente_juice.xml",
        numtogive = 1
    },
    { --filters
        "REFINE",
        "SCIENCE",
        "CRIPTIAN",
    }
)

---infinity stuff
AddCharacterRecipe(
    "infinity_matter", 
    {
        Ingredient("moonglass", 4),
        Ingredient("moonrocknugget", 4),
        Ingredient("infinity_catalyst", 2, "images/inventoryimages/infinity_catalyst.xml"),
        Ingredient("impure_infinity", 4, "images/inventoryimages/impure_infinity.xml"),
        Ingredient("pure_cristalyium", 1, "images/inventoryimages/pure_cristalyium.xml"),
        Ingredient("opalpreciousgem", 1),
    }, 
    TECH.SCIENCE_TWO, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/infinity_matter.xml"
    },
    { --filters
        "REFINE",
        "CRIPTIAN",
    }
)

AddCharacterRecipe(
    "infinity_catalyst", 
    {
        Ingredient("impure_infinity", 20, "images/inventoryimages/impure_infinity.xml"),
        Ingredient("pure_cristalyium", 4, "images/inventoryimages/pure_cristalyium.xml"),
        Ingredient("purebrilliance", 8),
    }, 
    TECH.SCIENCE_TWO, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/infinity_catalyst.xml",
        numtogive = 2
    },
    { --filters
        "CRIPTIAN",
    }
)

AddCharacterRecipe(
    "infinity_catalyst_seeds", 
    {
        Ingredient("moonglass", 4),
        Ingredient("pure_cristalyium", 2, "images/inventoryimages/pure_cristalyium.xml"),
        Ingredient("seeds", 4),
    }, 
    TECH.SCIENCE_TWO, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/infinity_catalyst_seeds.xml",
        numtogive = 4
    },
    { --filters
        "CRIPTIAN",
    }
)

---neutronium stuff
AddCharacterRecipe(
    "neutronium", 
    {
        Ingredient("nightmarefuel", 8),
        Ingredient("horrorfuel", 4),
        Ingredient("dreadstone", 4),
        Ingredient("neutronium_pile", 9, "images/inventoryimages/neutronium_pile.xml"),
        Ingredient("infinity_matter", 1, "images/inventoryimages/infinity_matter.xml"),
    }, 
    TECH.SCIENCE_TWO, 
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

AddCharacterRecipe(
    "neutronium_axe", 
    {
        Ingredient("neutronium", 3, "images/inventoryimages/neutronium.xml"),
        Ingredient("infinity_matter", 1, "images/inventoryimages/infinity_matter.xml"),
        Ingredient("cane", 1),
        Ingredient("nightmarefuel", 2),
        Ingredient("goldenaxe", 1),
    }, 
    TECH.SCIENCE_TWO, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/neutronium_axe.xml"
    },
    { --filters
        "TOOLS",
        "CRIPTIAN",
    }
)

AddCharacterRecipe(
    "neutronium_pickaxe", 
    {
        Ingredient("neutronium", 3, "images/inventoryimages/neutronium.xml"),
        Ingredient("infinity_matter", 1, "images/inventoryimages/infinity_matter.xml"),
        Ingredient("cane", 1),
        Ingredient("nightmarefuel", 2),
        Ingredient("goldenpickaxe", 1),
    },
    TECH.SCIENCE_TWO, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/neutronium_pickaxe.xml"
    },
    { --filters
        "TOOLS",
        "CRIPTIAN",
    }
)

AddCharacterRecipe(
    "neutronium_shovel", 
    {
        Ingredient("neutronium", 3, "images/inventoryimages/neutronium.xml"),
        Ingredient("infinity_matter", 1, "images/inventoryimages/infinity_matter.xml"),
        Ingredient("cane", 1),
        Ingredient("nightmarefuel", 2),
        Ingredient("goldenshovel", 1),
    },
    TECH.SCIENCE_TWO, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/neutronium_shovel.xml"
    },
    { --filters
        "TOOLS",
        "CRIPTIAN",
    }
)

AddCharacterRecipe(
    "neutronium_hammer", 
    {
        Ingredient("neutronium", 4, "images/inventoryimages/neutronium.xml"),
        Ingredient("infinity_matter", 1, "images/inventoryimages/infinity_matter.xml"),
        Ingredient("cane", 1),
        Ingredient("nightmarefuel", 2),
        Ingredient("hammer", 1),
    }, 
    TECH.SCIENCE_TWO, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/neutronium_hammer.xml"
    },
    { --filters
        "TOOLS",
        "CRIPTIAN",
    }
)

AddCharacterRecipe(
    "neutronium_hoe", 
    {
        Ingredient("neutronium", 2, "images/inventoryimages/neutronium.xml"),
        Ingredient("infinity_matter", 1, "images/inventoryimages/infinity_matter.xml"),
        Ingredient("cane", 1),
        Ingredient("nightmarefuel", 2),
        Ingredient("golden_farm_hoe", 1),
    }, 
    TECH.SCIENCE_TWO, 
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

AddCharacterRecipe(
    "neutronium_pitchfork", 
    {
        Ingredient("neutronium", 4, "images/inventoryimages/neutronium.xml"),
        Ingredient("infinity_matter", 1, "images/inventoryimages/infinity_matter.xml"),
        Ingredient("cane", 1),
        Ingredient("nightmarefuel", 2),
        Ingredient("pitchfork", 1),
    },
    TECH.SCIENCE_TWO, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/neutronium_pitchfork.xml"
    },
    { --filters
        "TOOLS",
        "CRIPTIAN",
    }
)

AddCharacterRecipe(
    "neutronium_sword", 
    {
        Ingredient("neutronium", 6, "images/inventoryimages/neutronium.xml"),
        Ingredient("infinity_matter", 1, "images/inventoryimages/infinity_matter.xml"),
        Ingredient("nightmarefuel", 2),
        Ingredient("horrorfuel", 2),
        Ingredient("nightsword", 1),
        Ingredient("glasscutter", 1),
    },
    TECH.SCIENCE_TWO, 
    { --config
        builder_tag = "criptian",
        atlas = "images/inventoryimages/neutronium_sword.xml"
    },
    { --filters
        "WEAPONS",
        "CRIPTIAN",
    }
)

