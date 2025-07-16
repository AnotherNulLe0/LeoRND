local function ante_scale_threshold()
	-- return (get_blind_amount((G.GAME.round_resets and G.GAME.round_resets.ante) or 1) or 300) / 100
	return (G.GAME.round_resets.ante or 1) * 3
end

local joker = {
	key = 'a_grade',
	config = { extra = { mult_modifier = 5, mult = 0, threshold_mod = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.mult_modifier, card.ability.extra.mult, ante_scale_threshold()} }
	end,
	rarity = 1,
	atlas = 'leornd_j',
	pos = { x = 1, y = 0 },

	cost = 4,
	blueprint_compat = true,

	calculate = function(self, card, context)
		if context.end_of_round and context.game_over == false and not context.blueprint and not context.repetition and not context.retrigger_joker and G.GAME.chips > G.GAME.blind.chips * (G.GAME.round_resets.ante or 1) * card.ability.extra.threshold_mod then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_modifier
			return {
				message = localize("k_upgrade_ex")
			}
		end

		if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		end
	end
}

return joker