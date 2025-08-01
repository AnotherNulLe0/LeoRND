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


-- Load jokers
LeoRND.utils.load_content(LeoRND.config.jokers, "jokers", SMODS.Joker)

-- Load stickers
LeoRND.utils.load_content(LeoRND.config.stickers, "stickers", SMODS.Sticker)

-- Load sounds
SMODS.Sound({ key = "crit_hit", path = "crit_hit.ogg"})

SMODS.current_mod.optional_features = {
	retrigger_joker = true
}
