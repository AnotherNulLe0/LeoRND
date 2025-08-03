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
	load_content = function (path, reg_function)
		local objects = SMODS.load_file(path)()
		for _, v in ipairs(objects) do
			reg_function(v)
		end
	end,
	find_next_edition = function(card)
    	-- Find index of selected card's edition 
    	local edition_index = 1
    	for i, v in ipairs(G.P_CENTER_POOLS.Edition) do
    	    if card.edition and v.key == card.edition.key then
    	        edition_index = i
    	    end
    	end

    	if edition_index + 1 > #G.P_CENTER_POOLS.Edition then
    	    return nil
    	end

    	-- Find next edition in collection
    	local next_edition = G.P_CENTER_POOLS.Edition[edition_index + 1]
    	return next_edition.key
	end,
	is_in_pool = function (card, pool_name)
		if not card.config.center.pools then
			return false
		end
		for k, v in pairs(card.config.center.pools) do
			if k == pool_name then
				return true
			end
		end
		return false
	end
}
return utils