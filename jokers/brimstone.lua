local joker = {
	key = 'brimstone',
	config = { extra = { e_mult = 1, e_mult_gain = 0.1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.e_mult, card.ability.extra.e_mult_gain } }
	end,
	locked_loc_vars = function(self, info_queue, card)
        return { vars = { 10, G.PROFILES[G.SETTINGS.profile].career_stats.c_wins } }
    end,
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 2, y = 0 },
	unlocked = false,
	
	check_for_unlock = function (self, args)
		if args.type == 'career_stat'then
            return G.PROFILES[G.SETTINGS.profile].career_stats.c_wins >= 10
        end
	end,
	

	cost = 10,
	blueprint_compat = true,

	calculate = function(self, card, context)
		if context.joker_main then
			return {
				e_mult = card.ability.extra.e_mult
			}
		end
		if context.end_of_round and context.game_over == false and context.beat_boss and not context.blueprint and not context.retrigger_joker and not context.repetition then
			card.ability.extra.e_mult = card.ability.extra.e_mult + card.ability.extra.e_mult_gain
			return {
				remove_default_message = true,
				message = localize("k_upgrade_ex"),
				colour = G.C.DARK_EDITION
			}
		end
	end
}

return joker