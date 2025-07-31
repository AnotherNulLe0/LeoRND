
SMODS.Atlas {
	key = "jokers",
	path = "jokers.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "stickers",
	path = "stickers.png",
	px = 71,
	py = 95
}

local jokers = config.jokers
local stickers = config.stickers

function event_destroy_card(card)
	function wrap()
		play_sound('tarot1')
		card.T.r = -0.2
		card:juice_up(0.3, 0.4)
		card.states.drag.is = true
		card.children.center.pinch.x = true
		-- This part destroys the card.
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.3,
			blockable = false,
			func = function()
				G.jokers:remove_card(card)
				card:remove()
				card = nil
				return true;
			end
			}))
		return true
	end
	return wrap
end

for _, v in ipairs(jokers) do
	local joker = SMODS.load_file("jokers/"..v..".lua")()
	SMODS.Joker(joker)
end

for _, v in ipairs(stickers) do
	local sticker = SMODS.load_file("stickers/"..v..".lua")()
	SMODS.Sticker(sticker)
end

SMODS.Sound({ key = "crit_hit", path = "crit_hit.ogg"})

SMODS.current_mod.optional_features = {
	retrigger_joker = true
}
