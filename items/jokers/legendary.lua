local placeholder = {
	key = 'placeholder',
	config = {  },
	loc_vars = function(self, info_queue, card)
		return { vars = {  } }
	end,
	rarity = 4,
	atlas = 'jokers',
	pos = { x = 3, y = 0 },
	order = 16,
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
	config = { extra = { curse = 1 } },
	loc_vars = function(self, info_queue, card)
		if G.GAME.modifiers.enable_cursed then
            return { vars = { card.ability.extra.curse * G.GAME.curse_rate }, key = self.key.."_alt" }
        else
            return { vars = { } }
        end
	end,
	rarity = 4,
	atlas = 'jokers',
	pos = { x = 1, y = 3 },
	soul_pos = { x = 2, y = 3 },
	order = 15,
	unlocked = false,
	no_pool_flag = "leornd_pacted",
	pools = {
		["Demonic"] = true
	},

	blueprint_compat = false,

	cost = 20,

	add_to_deck = function (self, card, from_debuff)
		if not G.GAME.pool_flags.leornd_pacted then
			G.GAME.pool_flags.leornd_pacted = true
		end
		if G.GAME.modifiers.enable_cursed then
			ease_curse(card.ability.extra.curse * G.GAME.curse_rate)
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