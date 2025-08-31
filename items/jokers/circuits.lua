local circuit_start = {
	key = 'circuit_start',
	config = {
		extra = { }
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {key = "circuit_explanation", set = "Other"}
		return { vars = {  } }
	end,
	rarity = 1,
	atlas = 'jokers',
	pos = { x = 4, y = 1 },
	order = 16,
	pools = {
		["Electric"] = true
	},
	blueprint_compat = false,

	cost = 4,
}

local circuit_filler = {
	key = 'circuit_filler',
	config = {
		extra = { }
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {key = "circuit_explanation", set = "Other"}
		return { vars = {  } }
	end,
	rarity = 1,
	atlas = 'jokers',
	pos = { x = 4, y = 3 },
	order = 17,
	pools = {
		["Electric"] = true,
        ["ElectricUser"] = true
	},

	blueprint_compat = true,

	cost = 2,
}

local circuit_lamp = {
	key = 'circuit_lamp',
	config = {
		extra = { mult = 0, mult_per_user = 5 }
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {key = "circuit_explanation", set = "Other"}
		return { vars = { card.ability.extra.mult_per_user, card.ability.extra.mult } }
	end,
	rarity = 1,
	atlas = 'jokers',
	pos = { x = 4, y = 4 },
	order = 18,
	pools = {
		["Electric"] = true,
        ["ElectricUser"] = true
	},

	blueprint_compat = true,

	cost = 4,

    update = function (self, card, dt)
		if not G.jokers then
			return
		end
        local start = nil
        local self_index = nil
        for i, jkr in ipairs(G.jokers.cards) do
            if jkr == card then
                self_index = i
                break
            end
        end
		if not self_index then
			card.ability.extra.mult = 0
			return
		end
        for i = self_index, 1, -1 do
            if G.jokers.cards[i].config.center_key == "j_leornd_circuit_start" then
                start = i
                break
            end
        end
		if not start then
			card.ability.extra.mult = 0
			return
		end
        local result = LeoRND.utils.check_circuit(start, card)
		if result then
        	card.ability.extra.mult = result * card.ability.extra.mult_per_user
		else
			card.ability.extra.mult = 0
		end
    end,

    calculate = function (self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

local circuit_end = {
	key = 'circuit_end',
	config = {
		extra = { }
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {key = "circuit_explanation", set = "Other"}
		return { vars = {  } }
	end,
	rarity = 1,
	atlas = 'jokers',
	pos = { x = 4, y = 2 },
	order = 18,
	pools = {
		["Electric"] = true
	},

	blueprint_compat = false,

	cost = 4,
}

return {
    circuit_start,
    circuit_filler,
    circuit_end,
    circuit_lamp
}