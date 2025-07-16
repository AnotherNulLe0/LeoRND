local joker = {
	key = 'pan',
	config = { extra = { e_mult = 2, base = 1, odds = 100, odd_increase = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { 
				card.ability.extra.e_mult, 
				(G.GAME.probabilities.normal * card.ability.extra.base or card.ability.extra.base), 
				card.ability.extra.odds, 
				(G.GAME.probabilities.normal * card.ability.extra.odd_increase or card.ability.extra.odd_increase)
			}
		}
	end,
	rarity = 2,
	atlas = 'leornd_j',
	pos = { x = 0, y = 0 },

	cost = 6,

	calculate = function(self, card, context)
		if context.joker_main then
			if pseudorandom("pan") <= G.GAME.probabilities.normal * card.ability.extra.base / card.ability.extra.odds then
				card.ability.extra.base = 1
				return {
					e_mult = card.ability.extra.e_mult,
					message = "^" .. card.ability.extra.e_mult .. " " .. localize("k_mult"),
					sound = "leornd_crit_hit",
					remove_default_message = true,
					colour = G.C.MULT
				}
			else
				card.ability.extra.base = card.ability.extra.base + card.ability.extra.odd_increase
				if card.ability.extra.base * G.GAME.probabilities.normal > card.ability.extra.odds then
					card.ability.extra.base = card.ability.extra.odds / G.GAME.probabilities.normal
				end
				return {
					remove_default_message = true,
					message = localize("k_nope_ex")
				}
			end
		end
	end
}

return joker