local joker = {
	key = 'dice',
	config = {  },
	loc_vars = function(self, info_queue, card)
		return { vars = {  } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 0, y = 2 },

	blueprint_compat = true,

	cost = 6,

	calculate = function(self, card, context)
		if context.mod_probability and not context.blueprint then
        	return {
        		numerator = context.numerator / 2
        	}
        end
	end
}

return joker