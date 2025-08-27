-- It became a way too complicated to save these values in joker config
local function a_grade_scaling(card)
	return 2 + math.floor((1.4 * (G.GAME.round_resets.ante or 1) * (G.GAME.round_resets.ante or 1))/ 8)
end

local a_grade = {
	key = 'a_grade',
	config = { extra = { mult_modifier = 5, mult = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.mult_modifier, card.ability.extra.mult, a_grade_scaling(card)} }
	end,
	rarity = 1,
	atlas = 'jokers',
	pos = { x = 1, y = 0 },
	order = 1,

	cost = 4,
	blueprint_compat = true,

	calculate = function(self, card, context)
		if context.end_of_round and context.game_over == false and not context.blueprint and not context.repetition and not context.retrigger_joker and G.GAME.chips > G.GAME.blind.chips * a_grade_scaling(card) then
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

local abszero = {
	key = 'abszero',
	config = { extra = { mult = 20 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.xchips } }
	end,
	rarity = 1,
	atlas = 'jokers',
	pos = { x = 2, y = 1 },
	order = 2,

	cost = 4,

	calculate = function(self, card, context)
		if context.joker_main and #context.full_hand == 4 and next(context.poker_hands['Three of a Kind']) then
			return {
				mult = card.ability.extra.mult,
			}
		end
	end
}

local tree = {
    key = 'tree',
	config = {
		extra = { active = false }
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.fruit_rot_time or LeoRND.config.fruit_rot_time } }
	end,
	rarity = 1,
	atlas = 'jokers',
	pos = { x = 1, y = 2 },
	order = 8,
	pools = {
		["FruitPool"] = true
	},

	blueprint_compat = true,
	unlocked = false,

	cost = 4,

	check_for_unlock = function (self, args)
		if args.type == 'modify_deck' then
            local count = 0
            for _, playing_card in ipairs(G.playing_cards or {}) do
                if playing_card.ability and playing_card.ability.leornd_sour then
					G.GAME.fruit_rate = LeoRND.config.fruit_rate
					G.PROFILES[G.SETTINGS.profile].leornd_fruity = true
					return true
				end
            end
			return false
        end
	end,

	calculate = function(self, card, context)
		if not G.PROFILES[G.SETTINGS.profile].leornd_fruity then
			G.GAME.fruit_rate = LeoRND.config.fruit_rate
			G.PROFILES[G.SETTINGS.profile].leornd_fruity = true
		end
		if context.beat_boss and context.game_over == false and not context.blueprint and not context.retrigger_joker and not context.repetition then
			card.ability.extra.active = true
		end
		if context.ending_shop and card.ability.extra.active and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
			card.ability.extra.active = false
			G.E_MANAGER :add_event(Event({
				func = function ()
					local center = LeoRND.utils.get_poll_results("Fruit")

					if center.set ~= "Fruit" then
						return true
					end

					local new_card = create_card("Fruit", G.consumeables, nil, nil, nil, nil, nil, "leornd_c_sour_card")
					new_card:add_to_deck()
					G.consumeables:emplace(new_card)
					if new_card.ability.set ~= "Fruit" then
						print("What the fuck, why did the tree spawn something beside Fruit consumeable, even after the pool check thing")
					end

					G.GAME.consumeable_buffer = 0
					return true
				end
			}))
		end
	end
}

local fruity_joker = {
	key = 'fruity_joker',
	config = {
		extra = { chips_per_fruit = 50 }
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chips_per_fruit, card.ability.extra.chips_per_fruit * LeoRND.utils.count_fruit_themed_items() } }
	end,
	locked_loc_vars = function(self, info_queue, card)
        return { vars = { colours = {HEX(LeoRND.config.fruit_label_colour)} } }
    end,
	rarity = 1,
	atlas = 'jokers',
	pos = { x = 3, y = 2 },
	soul_pos = { x = 3 , y = 3},
	order = 9,
	pools = {
		["FruitPool"] = true
	},

	blueprint_compat = true,
	unlocked = false,

	cost = 4,

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
			return of ~= 0 and tally >= of / 2
        end
	end,

	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips_per_fruit * LeoRND.utils.count_fruit_themed_items()
			}
		end
	end
}

local cursed_joker = {
	key = 'cursed_joker',
	config = {
		extra = { mult_per_curse = 1, curse = 1 }
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult_per_curse, G.GAME.curse * card.ability.extra.mult_per_curse, card.ability.extra.curse * G.GAME.curse_rate } }
	end,
	rarity = 1,
	atlas = 'jokers',
	pos = { x = 0, y = 4 },
	order = 13,

	blueprint_compat = true,
	unlocked = false,

	cost = 4,

	add_to_deck = function (self, card, from_debuff)
		if G.GAME.modifiers.enable_cursed then
			G.E_MANAGER:add_event(Event({
                func = function ()
					ease_curse(card.ability.extra.curse * G.GAME.curse_rate)
					return true
				end
            }))
		else
			G.E_MANAGER:add_event(Event({
                func = LeoRND.utils.event_destroy_card(card)
            }))
		end
	end,

	check_for_unlock = function (self, args)
		-- Unlocked if you win with more than 20 curse
		-- Can be obtained only in midnight+ stake runs (obviously)
		if args.type == "win" and G.GAME.curse >= 20 then
			return true
		end
	end,

	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult = card.ability.extra.mult_per_curse * G.GAME.curse
			}
		end
	end
}

return {
    a_grade,
    abszero,
    tree,
	fruity_joker,
	cursed_joker,
}