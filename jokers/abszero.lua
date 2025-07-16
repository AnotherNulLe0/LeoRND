local joker = {
	key = 'abszero',
	config = { extra = { mult = 10, xchips = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.xchips } }
	end,
	rarity = 1,
	atlas = 'leornd_j',
	pos = { x = 2, y = 1 },

	cost = 4,

	calculate = function(self, card, context)
		if context.joker_main then
			if #context.full_hand == 4 and G.GAME.last_hand_played == 'Three of a Kind' then
				return {
					mult = card.ability.extra.mult,
					xchips = card.ability.extra.xchips,
				}
			end
		end
	end
}

return joker