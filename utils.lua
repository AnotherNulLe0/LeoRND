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
		local objects = assert(SMODS.load_file(path))()
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
	end,
	placeholder_compat = function (card)
		for _, v in ipairs(LeoRND.config.placeholder_excluded_rarities) do
			if card.config.center.rarity == v then
				return false
			end
		end
		return true
	end,
	get_poll_results = function (set, rarity)
		local _pool, _pool_key = get_current_pool(set, rarity, nil, nil)
		local center = pseudorandom_element(_pool, pseudoseed(_pool_key))
		local it = 1
		while center == 'UNAVAILABLE' do
			it = it + 1
			center = pseudorandom_element(_pool, pseudoseed(_pool_key..'_resample'..it))
		end

		center = G.P_CENTERS[center]
		return center
	end
}
utils.fruit_themed_jokers = function (except)
	local items = {}
	if not G.jokers then
	    return {}
	end
	-- Find fruit-themed jokers
	for _, v in ipairs(G.jokers.cards) do
	    if LeoRND.utils.is_in_pool(v, "FruitPool") and v ~= except then
	        items[#items+1] = v
	    end
	end
	return items
end
utils.fruit_themed_consumables = function (except)
	local items = {}
	if not G.consumeables then
	    return {}
	end
	-- Find fruit-themed in consumables
	for _, v in ipairs(G.consumeables.cards) do
	    if v.ability.set == "Fruit" and v ~= except then
	        items[#items+1] = v
	    end
	end
	return items
end
utils.count_fruit_themed_items = function (except)
	return #utils.fruit_themed_jokers(except) + #utils.fruit_themed_consumables(except)
end

-- Global utils
function ease_curse(mod)
    G.E_MANAGER:add_event(Event({
      trigger = 'immediate',
      func = function()
          local curse_UI = G.hand_text_area.curse
          mod = mod or 0
          local text = '+'
          local col = G.C.IMPORTANT
          if mod < 0 then
              text = '-'
              col = G.C.RED
          end
          G.GAME.curse = G.GAME.curse + mod
          curse_UI.config.object:update()
          G.HUD:recalculate()
          --Popup text next to the chips in UI showing number of chips gained/lost
          attention_text({
            text = text..tostring(math.abs(mod)),
            scale = 1, 
            hold = 0.7,
            cover = curse_UI.parent,
            cover_colour = col,
            align = 'cm',
            })
          --Play a chip sound
          play_sound('highlight2', 0.685, 0.2)
          play_sound('generic1')
          return true
      end
    }))
end

return utils