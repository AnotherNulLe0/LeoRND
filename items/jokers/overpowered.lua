local gradient = SMODS.Gradient {
	key = "unobtainable",
	colours = {
        HEX('fe5f55'),
		HEX("4BC292"),
		HEX('009dff'),
	},
	cycle = 3,
	interpolation = "linear"
}
SMODS.Rarity({
	key = "unobtainable",
	loc_txt = {},
	badge_colour = gradient
})

local hyperjoker = {
    key = 'hyperjoker',
	config = { extra = { mult = 3, op = -1, increase = 1 } },
	loc_vars = function(self, info_queue, card)
		local operator = string.rep("^", card.ability.extra.op)
		if card.ability.extra.op == -1 then
			operator = "+"
		elseif card.ability.extra.op == 0 then
			operator = "X"
		elseif card.ability.extra.op >= 6 then
			operator = "{"..tostring(card.ability.extra.op).."}"
		end
		return { vars = { operator, card.ability.extra.mult } }
	end,
	rarity = "leornd_unobtainable",
	atlas = 'jokers',
	pos = { x = 2, y = 4 },
	soul_pos = { x = 3, y = 4},
	order = 17,
	unlocked = false,

	blueprint_compat = true,

	cost = 50,

	calculate = function(self, card, context)
		if context.retrigger_joker then
			card.ability.extra.op = card.ability.extra.op + card.ability.extra.increase
        end
		if context.joker_main then
			local effect = {}
			if not context.retrigger_joker then
				effect.func = function ()
					card.ability.extra.op = card.ability.extra.op + card.ability.extra.increase
				end
			end
			if card.ability.extra.op == -1 then
				effect.mult = card.ability.extra.mult
			elseif card.ability.extra.op == 0 then
				effect.xmult = card.ability.extra.mult
			elseif card.ability.extra.op == 1 then
				effect.emult = card.ability.extra.mult
			elseif card.ability.extra.op == 2 then
				effect.eemult = card.ability.extra.mult
			elseif card.ability.extra.op == 3 then
				effect.eeemult = card.ability.extra.mult
			else
				effect.hyper_mult = { card.ability.extra.op, card.ability.extra.mult }
			end
			return effect
        end
	end
}

local retrigger = {
    key = 'retrigger',
	config = { extra = { retriggers = 1, increase = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.retriggers, card.ability.extra.increase } }
	end,
	rarity = "leornd_unobtainable",
	atlas = 'jokers',
	pos = { x = 2, y = 4 },
	soul_pos = { x = 3, y = 4},
	order = 18,
	unlocked = false,

	blueprint_compat = true,

	cost = 50,

	calculate = function(self, card, context)
		if context.retrigger_joker_check and context.other_card ~= card then
			return {
				repetitions = card.ability.extra.retriggers,
				card = context.blueprint_card or card
			}
		end
		if context.repetition then
			return {
				repetitions = card.ability.extra.retriggers,
				card = context.blueprint_card or card
			}
		end
		if context.joker_main then
			card.ability.extra.retriggers = card.ability.extra.retriggers + card.ability.extra.increase
		end
	end
}

local stopwatch = {
    key = 'stopwatch',
	config = { extra = { start = nil, chips = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.start and math.floor((love.timer.getTime() - card.ability.extra.start) * 1000) or 0 } }
	end,
	rarity = "leornd_unobtainable",
	atlas = 'jokers',
	pos = { x = 2, y = 4 },
	soul_pos = { x = 3, y = 4},
	order = 19,
	unlocked = false,

	blueprint_compat = true,

	cost = 50,
	add_to_deck = function (self, card, from_debuff)
		card.ability.extra.start = love.timer.getTime()
	end,

	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = math.floor((love.timer.getTime() - card.ability.extra.start) * 1000)
			}
		end
	end
}

return {
    hyperjoker,
	retrigger,
	stopwatch
}