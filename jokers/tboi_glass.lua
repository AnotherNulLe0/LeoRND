local joker = {
	key = 'tboi_glass',
	config = { extra = { extra_card = 1, chips_mult = 2, mult = 0.8, odds = 20 } },
	loc_vars = function(self, info_queue, card)
		local base, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'leornd_j_tboi_glass')
		return { vars = { card.ability.extra.extra_card, card.ability.extra.chips_mult, card.ability.extra.mult, base, odds } }
	end,
	rarity = 2,
	atlas = 'leornd_j',
	pos = { x = 0, y = 1 },

	no_pool_flag = "tboiglass_destroyed",
	eternal_compat = false,
	blueprint_compat = true,
	cost = 6,

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
				xmult = card.ability.extra.mult,
			}
		end

		if context.end_of_round and not context.repetition and not context.retrigger_joker and context.game_over == false and not context.blueprint then
			if SMODS.pseudorandom_probability(card, 'tboi_glass', 1, card.ability.extra.odds, 'leornd_j_tboi_glass') then
				G.E_MANAGER:add_event(Event({
					func = event_destroy_card(card)
				}))
				G.GAME.pool_flags.tboiglass_destroyed = true
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

return joker