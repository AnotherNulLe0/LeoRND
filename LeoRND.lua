LeoRND = SMODS.current_mod
LeoRND.utils = SMODS.load_file("utils.lua")()
LeoRND.config = SMODS.load_file("config.lua")()
SMODS.load_file("lib/hooks.lua")()

SMODS.Atlas {
	key = "jokers",
	path = "jokers.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "stickers",
	path = "stickers.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "fruit",
	path = "fruit.png",
	px = 71,
	py = 95
}

-- Register fruit cards
SMODS.ConsumableType {
	key = "Fruit",
	primary_colour = 0,
	secondary_colour = HEX(LeoRND.config.fruit_label_colour),
	loc_txt = {
		name = "Fruit",
		collection = "Fruit"
	},
	shop_rate = G.PROFILES[G.SETTINGS.profile].leornd_fruity and LeoRND.config.fruit_rate or 0
}

-- Register fruit-themed pool
SMODS.ObjectType {
	key = "FruitPool",
	default = "j_joker",
	cards = {
		-- Fruit jokers
		["j_gros_michel"] = true,
		["j_cavendish"] = true,
		["j_leornd_tree"] = true,
		["j_leornd_fruity_joker"] = true,
		["j_leornd_fruityful_joker"] = true,
	}
}

-- Load jokers
LeoRND.utils.load_content("items/jokers/common.lua", SMODS.Joker)
LeoRND.utils.load_content("items/jokers/uncommon.lua", SMODS.Joker)
LeoRND.utils.load_content("items/jokers/rare.lua", SMODS.Joker)
LeoRND.utils.load_content("items/jokers/legendary.lua", SMODS.Joker)

-- Load stickers
LeoRND.utils.load_content("items/stickers.lua", SMODS.Sticker)

-- Load consumables
LeoRND.utils.load_content("items/consumables/fruit.lua", SMODS.Consumable)

-- Load blinds
LeoRND.utils.load_content("items/blinds/non_final.lua", SMODS.Blind)

-- Load editions
LeoRND.utils.load_content("items/editions.lua", SMODS.Edition)


-- Load sounds
SMODS.Sound({ key = "crit_hit", path = "crit_hit.ogg"})

SMODS.current_mod.optional_features = {
	retrigger_joker = true
}
