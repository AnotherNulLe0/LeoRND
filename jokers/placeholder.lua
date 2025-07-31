-- Does random shit in your run
local joker = {
	key = 'placeholder',
	config = {  },
	loc_vars = function(self, info_queue, card)
		return { vars = {  } }
	end,
	rarity = 4,
	atlas = 'leornd_j',
	pos = { x = 3, y = 0 },

	blueprint_compat = true,

	cost = 20,

	calculate = function(self, card, context)
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card.config.center.rarity <= 3 then
			return {
				message = localize('k_again_ex'),
				repetitions = 1,
				card = context.blueprint_card or card,
			}
		end
	end
}

return joker