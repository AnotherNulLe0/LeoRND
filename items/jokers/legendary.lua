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

return {
    placeholder
}