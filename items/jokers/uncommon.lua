local unfair_dice = {
	key = 'dice',
	config = {  },
	loc_vars = function(self, info_queue, card)
		return { vars = {  } }
	end,
	rarity = 2,
	atlas = 'jokers',
    unlocked = false,
	pos = { x = 0, y = 2 },

	blueprint_compat = true,

	cost = 6,

    -- I'll leave this unlock method for other joker, it's way too cool
    -- check_for_unlock = function (self, args)
	-- 	if args.type == 'modify_jokers' and G.jokers then
    --         local checked = {}
    --         for _, joker in ipairs(G.jokers.cards) do
    --             if joker.ability.set == 'Joker' and not checked[joker.config.center.key] then
    --                 checked[joker.config.center.key] = 1
    --             elseif checked[joker.config.center.key] then
    --                 checked[joker.config.center.key] = checked[joker.config.center.key] + 1
    --                 if checked[joker.config.center.key] >= 3 then
    --                     return true
    --                 end
    --             end
    --         end
    --     end
    --     return false
	-- end,
    check_for_unlock = function (self, args)
		if args.type == 'modify_jokers' and G.jokers then
            local has_dice = false
            for _, joker in ipairs(G.jokers.cards) do
                if joker.ability.set == 'Joker' and joker.config.center.key == "j_oops" and not has_dice then
                    has_dice = true
                elseif has_dice then
                    return true
                end
            end
        end
        return false
	end,

	calculate = function(self, card, context)
		if context.mod_probability and not context.blueprint then
        	return {
        		numerator = context.numerator / 2
        	}
        end
	end
}

local tboi_glass = {
	key = 'tboi_glass',
	config = { extra = { extra_card = 1, chips_mult = 2, mult = 0.8, odds = 20 } },
	loc_vars = function(self, info_queue, card)
		local base, odds = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'leornd_j_tboi_glass')
		return { vars = { card.ability.extra.extra_card, card.ability.extra.chips_mult, card.ability.extra.mult, base, odds } }
	end,
	rarity = 2,
	atlas = 'jokers',
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
					func = utils.event_destroy_card(card)
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

local sour = {
	key = 'sour',
	config = { 
		numetal = true, -- Stone sour can be considered nu-metal, so I'll add this flag to make Buffonery's mod maggit work with this joker
		extra = {  } 
	},
	unlocked = false,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "leornd_sour", set = "Other" }
		return { vars = {  } }
	end,
	rarity = 2,
	atlas = 'jokers',
	pos = { x = 3, y = 1 },
	pixel_size = { h = 69 },

	cost = 6,

	check_for_unlock = function (self, args)
		if args.type == "hand_contents" then
			local tally = 0
            for j = 1, #args.cards do
				print(args.cards[j].edition)
                if SMODS.has_enhancement(args.cards[j], 'm_stone') and args.cards[j].edition then
                    tally = tally + 1
                    if tally == 5 then
                        return true
                    end
                end
            end
			return false
		end
	end,

	in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_stone') then
                return true
            end
        end
        return false
    end,

	calculate = function(self, card, context)
		if context.before and context.main_eval and not context.blueprint then
			local count = 0
			for _, scored_card in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(scored_card, 'm_stone') and not scored_card.ability.leornd_sour then
					scored_card.ability.leornd_sour = true
					count = count + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
			if count > 0 then
				return {
					message = localize("k_upgrade_ex")
				}
			end
		end
	end
}

local pan = {
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

return {
    unfair_dice,
    tboi_glass,
    sour,
    pan
}