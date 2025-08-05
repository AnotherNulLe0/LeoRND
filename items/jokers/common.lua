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
		return { vars = { LeoRND.config.fruit_rot_time } }
	end,
	rarity = 1,
	atlas = 'jokers',
	pos = { x = 1, y = 2 },

	blueprint_compat = true,
	unlocked = false,

	cost = 4,

	check_for_unlock = function (self, args)
		if args.type == 'modify_deck' then
            local count = 0
            for _, playing_card in ipairs(G.playing_cards or {}) do
                if playing_card.ability and playing_card.ability.leornd_sour then
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
					-- I stole this code from Balatro source, I really don't understand what it does but it works
					-- (lines 2113-2121)
					local _pool, _pool_key = get_current_pool("Fruit", nil, nil, nil)
					local center = pseudorandom_element(_pool, pseudoseed(_pool_key))
					local it = 1
					while center == 'UNAVAILABLE' do
						it = it + 1
						center = pseudorandom_element(_pool, pseudoseed(_pool_key..'_resample'..it))
					end

					center = G.P_CENTERS[center]
					-- ...stolen code ends

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

return {
    a_grade,
    abszero,
    tree
}