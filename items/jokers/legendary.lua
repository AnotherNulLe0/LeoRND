local placeholder = {
	key = 'placeholder',
	config = {  },
	loc_vars = function(self, info_queue, card)
		return { vars = {  } }
	end,
	rarity = 4,
	atlas = 'jokers',
	pos = { x = 3, y = 0 },
	unlocked = false,

	blueprint_compat = true,

	cost = 20,

	calculate = function(self, card, context)
		if context.retrigger_joker_check
		and not context.retrigger_joker
		and LeoRND.utils.placeholder_compat(context.other_card) then
			return {
				message = localize('k_again_ex'),
				repetitions = 1,
				card = context.blueprint_card or card,
			}
		end
	end
}

local unfairer_dice = {
	key = 'unfairer_dice',
	config = { extra = { } },
	loc_vars = function(self, info_queue, card)
		local n, d = SMODS.get_probability_vars(card, LeoRND.config.possessed_numerator, LeoRND.config.possessed_denominator, 'othala')
		info_queue[#info_queue + 1] = { 
			vars = {
				LeoRND.config.possessed_mult_mod,
				n,
				d
			},
			key = "leornd_possessed",
			set = "Other"
		}
		return {}
	end,
	rarity = 4,
	atlas = 'jokers',
	pos = { x = 1, y = 3 },
	soul_pos = { x = 2, y = 3 },
	unlocked = false,
	no_pool_flag = "leornd_pacted",

	blueprint_compat = false,

	cost = 20,

	add_to_deck = function (self, card, from_debuff)
		if not G.GAME.pool_flags.leornd_pacted then
			G.GAME.pool_flags.leornd_pacted = true
		end
		if LeoRND.config.curses_enabled then
			ease_curse(1)
		end
	end,

    check_for_unlock = function (self, args)
		if args.type == 'modify_jokers' and G.jokers then
            local tally = 0
            for _, joker in ipairs(G.jokers.cards) do
                if joker.config.center.key == "j_leornd_dice" then
					tally = tally + 1
				end
            end
			if tally >= 3 then
				return true
			end
        end
        return false
	end,

	calculate = function(self, card, context)
		if context.selling_self and G.GAME.blind.in_blind and not context.blueprint and not context.retrigger and not context.retrigger_joker then
			local possess = function()
				for i, k in ipairs(G.hand.cards) do
       			    local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
       			    G.E_MANAGER:add_event(Event({
       			        trigger = 'after',
       			        delay = 0.15,
       			        func = function()
       			            k:flip()
       			            play_sound('card1', percent)
       			            k:juice_up(0.3, 0.3)
       			            return true
       			        end
       			    }))
       			end
       			for i, k in ipairs(G.hand.cards) do
       			    G.E_MANAGER:add_event(Event({
       			        func = function()
       			            k.ability.leornd_possessed = true
       			            return true
       			        end
       			    }))
       			end
       			for i, k in ipairs(G.hand.cards) do
       			    local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
       			    G.E_MANAGER:add_event(Event({
       			        trigger = 'after',
       			        delay = 0.15,
       			        func = function()
       			            k:flip()
       			            play_sound('tarot2', percent, 0.6)
       			            k:juice_up(0.3, 0.3)
       			            return true
       			        end
       			    }))
       			end
			end
			return {
				message = localize("k_possess_ex"),
				func = possess
			}
		end
		if context.mod_probability and not context.blueprint and not context.retrigger and not context.retrigger_joker then
			return {
				numerator = 0
			}
		end
	end
}

return {
    placeholder,
	unfairer_dice
}