
SMODS.Atlas {
	key = "leornd_j",
	path = "jokers.png",
	px = 71,
	py = 95
}

local config = SMODS.load_file("config.lua")()
local jokers = config.jokers

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
	local joker_obj = SMODS.Joker(joker)
	for k_, v_ in pairs(joker) do
    if type(v_) == 'function' then
      joker_obj[k_] = joker[k_]
    end
  end
end

SMODS.Sound({ key = "crit_hit", path = "crit_hit.ogg"})

SMODS.current_mod.optional_features = {
	retrigger_joker = true
}

--#region Debug deck
-- This deck should be removed as soon as possible
if config.debug_mode then
	SMODS.Back{
	    key = 'getinside',
	    unlocked = true,
	    discovered = true,
	    atlas = 'leornd_j', -- Uses a placeholder texture
	    pos = {
	        x = 3,
	        y = 0,
	    },
	    config = { joker_slot = 0 },
		loc_txt = {
			name= "Leo's debug deck",
			text= {
				"{C:attention} Start with every Leo's joker"
			}
		},

	    apply = function(self, back)
			for _, v in ipairs(jokers) do
				back.effect.config.joker_slot = back.effect.config.joker_slot + 1
	        	G.E_MANAGER:add_event(Event({
						trigger = 'immediate',
						func = function()
	        		    	SMODS.add_card({
								set = 'joker',
								area = G.jokers,
								key = 'j_leornd_'..v,
								no_edition = true,
							})
	        				return true

						end
					}))
			end
			G.GAME.probabilities.normal = 1
	    end,
	}
end
--#endregion