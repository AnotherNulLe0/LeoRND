local joker = {
	key = 'sour',
	loc_txt = {
		name = 'placeholder',
		text = {
			"placeholder"
		}
	},
	config = { extra = {  } },
	loc_vars = function(self, info_queue, card)
		return { vars = {  } }
	end,
	rarity = 1,
	atlas = 'leornd_j',
	pos = { x = 3, y = 1 },

	cost = 4,

	calculate = function(self, card, context)
		
	end
}

return joker