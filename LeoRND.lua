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

-- Register fruit cards
SMODS.ConsumableType {
	key = "Fruit",
	primary_colour = 0,
	secondary_colour = HEX '0000ff',
	loc_txt = {
		name = "Fruit",
		collection = "Fruit"
	},
	shop_rate = 0
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

-- Load sounds
SMODS.Sound({ key = "crit_hit", path = "crit_hit.ogg"})

SMODS.current_mod.optional_features = {
	retrigger_joker = true
}
