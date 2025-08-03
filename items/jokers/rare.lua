local brimstone = {
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

local sour_glass = {
	key = 'sour_glass',
	config = { extra = { extra_card = 1, chips_mult = 2.5, odds = 100 } },
	loc_vars = function(self, info_queue, card)
		local base, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'leornd_j_sour_glass')
		return { vars = { card.ability.extra.extra_card, card.ability.extra.chips_mult, base, odds } }
	end,
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 1, y = 1 },
	unlocked = false,

	yes_pool_flag = "tboiglass_destroyed",
	eternal_compat = false,
	blueprint_compat = true,
	cost = 8,

	check_for_unlock = function (self, args)
		if args.type == 'modify_deck' then
            local count = 0
            for _, playing_card in ipairs(G.playing_cards or {}) do
                if SMODS.has_enhancement(playing_card, 'm_glass') then count = count + 1 end
                if count >= #G.playing_cards / 2 then
                    return true
                end
            end
        end
	end,

	calculate = function(self, card, context)
		if context.open_booster then
			card:juice_up()
			if G.GAME.pack_choices + card.ability.extra.extra_card > G.GAME.pack_size then
				G.GAME.pack_choices = G.GAME.pack_size
			else
				G.GAME.pack_choices = G.GAME.pack_choices + card.ability.extra.extra_card
			end
		end

		if context.joker_main then
			return {
				xchips = card.ability.extra.chips_mult,
			}
		end

		if context.end_of_round and not context.repetition and not context.retrigger_joker and context.game_over == false and not context.blueprint then
			if SMODS.pseudorandom_probability(card, 'sour_glass', 1, card.ability.extra.odds, 'leornd_j_sour_glass')then
				-- This part plays the animation.
				G.E_MANAGER:add_event(Event({
					func = utils.event_destroy_card(card)
				}))
				return {
					message = localize("k_broken")
				}
			else
				return {
					message = localize("k_safe_ex")
				}
			end
		end
	end
}

return {
    brimstone,
    sour_glass
}