local config = {
	curses_enabled = true,
	sour_sticker_reduce = 0.9,
	sour_sticker_chips = -20,
	possessed_mult_mod = 0.5,
	possessed_numerator = 1,
	possessed_denominator = 7,
	fruit_rot_time = 2,
	fruit_rate = 4,
	fruit_label_colour = "6CA147",
	ch_pact_debuff = 0.4,
	placeholder_excluded_rarities = {
		4,
		"cry_exotic", -- Exotic jokers are more powerful than legendary, so I'll exclude them
		-- Astronomica's beyond exotic jokers
		"ast_empyrean",
		-- Entropy beyond exotic jokers / 
		-- alt legendaries
		"entr_entropic",
		"entr_zenith",
		"ent_reverse_legendary"
	}
}
return config