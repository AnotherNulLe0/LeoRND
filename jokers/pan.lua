local joker = {
	key = 'pan',
	config = { extra = { e_mult = 2, base = 1, odds = 100, odd_increase = 1 } },
	loc_vars = function(self, info_queue, card)
		local base, odds = SMODS.get_probability_vars(card, card.ability.extra.base, card.ability.extra.odds, 'leornd_j_pan')
		local diff = base / card.ability.extra.base
		return { vars = { 
				card.ability.extra.e_mult, 
				base, 
				odds, 
				card.ability.extra.odd_increase * diff
			}
		}
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 0, y = 0 },

	cost = 6,

	calculate = function(self, card, context)
		if context.joker_main then
			if SMODS.pseudorandom_probability(card, 'pan', card.ability.extra.base, card.ability.extra.odds, 'leornd_j_pan') then
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
				return {
					remove_default_message = true,
					message = localize("k_nope_ex")
				}
			end
		end
	end
}

return joker