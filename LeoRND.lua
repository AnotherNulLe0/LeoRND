LeoRND = SMODS.current_mod
LeoRND.utils = SMODS.load_file("utils.lua")()
LeoRND.config = SMODS.load_file("config.lua")()

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
	secondary_colour = HEX '6CA147',
	loc_txt = {
		name = "Fruit",
		collection = "Fruit"
	},
	shop_rate = G.PROFILES[G.SETTINGS.profile].leornd_fruity and LeoRND.config.fruit_rate or 0
}

-- Register fruit-themed pool
SMODS.ObjectType {
	key = "FruitPool",
	default = "j_gros_michel",
	cards = {
		-- Fruit jokers
		["j_gros_michel"] = true,
		["j_cavendish"] = true,
		["j_leornd_tree"] = true,
		-- Fruit cards
		["c_leornd_lemon"] = true,
		["c_leornd_apple"] = true,
		["c_leornd_orange"] = true,
		["c_leornd_peach"] = true,
	}
}

-- Load jokers
LeoRND.utils.load_content("items/jokers/common.lua", SMODS.Joker)
LeoRND.utils.load_content("items/jokers/uncommon.lua", SMODS.Joker)
LeoRND.utils.load_content("items/jokers/rare.lua", SMODS.Joker)
LeoRND.utils.load_content("items/jokers/legendary.lua", SMODS.Joker)

-- Load stickers
LeoRND.utils.load_content("items/stickers/stickers.lua", SMODS.Sticker)

-- Load consumables
LeoRND.utils.load_content("items/consumables/fruit.lua", SMODS.Consumable)

-- Load blinds
LeoRND.utils.load_content("items/blinds/non_final.lua", SMODS.Blind)


-- Load sounds
SMODS.Sound({ key = "crit_hit", path = "crit_hit.ogg"})

SMODS.current_mod.optional_features = {
	retrigger_joker = true
}
