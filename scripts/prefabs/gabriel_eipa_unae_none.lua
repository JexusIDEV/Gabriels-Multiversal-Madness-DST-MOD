local assets =
{
	Asset( "ANIM", "anim/gabriel_eipa_unae.zip" ),
	Asset( "ANIM", "anim/ghost_gabriel_eipa_unae_build.zip" ),
}

local skins =
{
	normal_skin = "gabriel_eipa_unae",
	ghost_skin = "ghost_gabriel_eipa_unae_build",
}

return CreatePrefabSkin("gabriel_eipa_unae_none",
{
	base_prefab = "gabriel_eipa_unae",
	type = "base",
	assets = assets,
	skins = skins, 
	skin_tags = {"GABRIEL_EIPA_UNAE", "CHARACTER", "BASE"},
	build_name_override = "gabriel_eipa_unae",
	rarity = "Character",
})