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

	yes_pool_flag = "tboiglass_destroyed",
	eternal_compat = false,
	blueprint_compat = true,
	cost = 8,

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
					func = LeoRND.utils.event_destroy_card(card)
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

local grape_juice = {
	key = 'grape_juice',
	config = { extra = { suit = "Hearts", repetitions = 1, repetition_increase = 1, price = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.repetitions, card.ability.extra.repetition_increase, card.ability.extra.price } }
	end,
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 2, y = 2 },

	unlocked = false,

	eternal_compat = true,
	blueprint_compat = true,
	cost = 10,

	calculate = function(self, card, context)
		if context.cardarea == G.play and context.repetition then
			if context.other_card:is_suit(card.ability.extra.suit) then
				return {
					repetitions = card.ability.extra.repetitions
				}
			end
		end
		-- if context.end_of_round and context.game_over == false and context.beat_boss and not context.blueprint and not context.retrigger_joker and not context.repetition then
		-- 	card.ability.extra.repetitions = card.ability.extra.repetitions + card.ability.extra.repetition_increase
		-- 	return {
		-- 		message = localize('k_upgrade_ex'),
		-- 	}
		-- end
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and not context.repetition and not context.joker_repetition then
            card.ability.extra_value = card.ability.extra_value + card.ability.extra.price
			card:set_cost()
			local extra = nil
			if context.beat_boss then
				card.ability.extra.repetitions = card.ability.extra.repetitions + card.ability.extra.repetition_increase
				extra = {message = localize('k_upgrade_ex')}
			end
            return {
                message = localize('k_val_up'),
                colour = G.C.MONEY,
				extra = extra
            }
        end
	end,

	check_for_unlock = function (self, args)
		if args.type == "obtain_consumable" then
			for _, v in ipairs(G.consumeables.cards) do
				if v.config.center.key == "c_leornd_grape" then
					return true
				end
			end
		end
	end
}

local fruityful = {
	key = 'fruityful_joker',
	config = { extra = { xmult = 1, xmult_mod = 0.1, gain_increase = 0.5 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { 
			card.ability.extra.xmult_mod + card.ability.extra.gain_increase * (math.max(#LeoRND.utils.fruit_themed_consumables(card)-1, 0) + #LeoRND.utils.fruit_themed_jokers(card)),
			card.ability.extra.xmult,
			colours = {HEX(LeoRND.config.fruit_label_colour)}
		} }
	end,
	locked_loc_vars = function(self, info_queue, card)
        return { vars = { colours = {HEX(LeoRND.config.fruit_label_colour)} } }
    end,
	rarity = 3,
	atlas = 'jokers',
	pos = { x = 0, y = 3 },
	unlocked = false,

	blueprint_compat = true,

	cost = 8,

	check_for_unlock = function (self, args)
		if args.type == 'discover_amount' then
			local tally = 0
			local of = 0
            for k, v in pairs(G.P_CENTERS) do
				if v.set == "Fruit" and not v.omit then
					of = of + 1
					if v.discovered then
						tally = tally + 1
					end
				end
			end
			return of ~= 0 and tally >= of
        end
	end,

	calculate = function(self, card, context)
		if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == 'Fruit' then
			card.ability.extra.xmult = card.ability.extra.xmult
			+ card.ability.extra.xmult_mod + card.ability.extra.gain_increase * LeoRND.utils.count_fruit_themed_items(card)
		end
		if context.joker_main then
			return {
				xmult = card.ability.extra.xmult
			}
		end
	end
}

return {
    brimstone,
    sour_glass,
	grape_juice,
	fruityful
}