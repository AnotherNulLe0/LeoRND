-- Does random shit in your run
local joker = {
	key = 'placeholder',
	config = { extra = { min = 0, max = 20 }, immutable = { choices_main = 8, choices_before = 2, choices_individual = 2 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.odds } }
	end,
	rarity = 4,
	atlas = 'leornd_j',
	pos = { x = 3, y = 0 },

	blueprint_compat = true,

	cost = 100,

	calculate = function(self, card, context)
		if context.joker_main then
			local choice = math.floor(pseudorandom("placeholder", 1, card.ability.immutable.choices_main) + 0.5)
			if choice == 1 then
				return {
					mult = pseudorandom("placeholder", card.ability.extra.min, card.ability.extra.max)
				}
			elseif choice == 2 then
				return {
					chips = pseudorandom("placeholder", card.ability.extra.min, card.ability.extra.max)
				}
			elseif choice == 3 then
				return {
					xmult = pseudorandom("placeholder", card.ability.extra.min, card.ability.extra.max)
				}
			elseif choice == 4 then
				return {
					xchips = pseudorandom("placeholder", card.ability.extra.min, card.ability.extra.max)
				}
			elseif choice == 5 then
				return {
					e_mult = pseudorandom("placeholder", card.ability.extra.min, card.ability.extra.max)
				}
			elseif choice == 6 then
				return {
					e_chips = pseudorandom("placeholder", card.ability.extra.min, card.ability.extra.max)
				}
			elseif choice == 7 then
				return {
					swap = true
				}
			else
				return {
					mult = 4
				}
			end
		end
		if context.before then
			local choice = math.floor(pseudorandom("placeholder", 1, card.ability.immutable.choices_before) + 0.5)
			if choice == 1 then
				return {
					level_up = pseudorandom("placeholder", card.ability.extra.min, card.ability.extra.max)
				}
			elseif choice == 2 then
				return {
					dollars = pseudorandom("placeholder", card.ability.extra.min, card.ability.extra.max)
				}
			end
		end
		if context.repetition and not context.repetition_only then
			return {
				message = localize("k_again_ex"),
				repetitions = pseudorandom("placeholder", card.ability.extra.min, card.ability.extra.max),
			}
		end
		if context.individual and context.cardarea == G.play then
			local choice = math.floor(pseudorandom("placeholder", 1, card.ability.immutable.choices_individual) + 0.5)
			if choice == 1 then
				context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
            	context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + pseudorandom("placeholder", card.ability.extra.min, card.ability.extra.max)
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.CHIPS,
					card = context.other_card
				}
			elseif choice == 2 then
				return {
					chips = pseudorandom("placeholder", card.ability.extra.min, card.ability.extra.max),
					mult = pseudorandom("placeholder", card.ability.extra.min, card.ability.extra.max),
				}
			end
		end
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= card then
			return {
				-- message = localize('k_again_ex'),
				remove_default_message = true,
				repetitions = pseudorandom("placeholder", card.ability.extra.min, card.ability.extra.max),
				card = context.blueprint_card or card,
			}
		end
	end
}

return joker