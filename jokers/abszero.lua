local joker = {
	key = 'abszero',
	config = { extra = { mult = 20 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.xchips } }
	end,
	rarity = 1,
	atlas = 'jokers',
	pos = { x = 2, y = 1 },

	cost = 4,

	calculate = function(self, card, context)
		if context.joker_main and #context.full_hand == 4 and next(context.poker_hands['Three of a Kind']) then
			return {
				mult = card.ability.extra.mult,
			}
		end
	end
}

return joker