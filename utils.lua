local utils = {
    event_destroy_card = function(card)
    	local function wrap()
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
    end,
	load_content = function (load_list, path, reg_function)
		for _, v in ipairs(load_list) do
			local cur_directory = path.."/"..v..".lua"
			local obj = SMODS.load_file(cur_directory)
			if not obj then
				print("LeoRND: unable to load "..cur_directory)
			else
				reg_function(obj())
			end
		end
	end
}
return utils