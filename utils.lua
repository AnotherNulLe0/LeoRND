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
	end,
	poll_curse_effect = function (seed, min_curse, weight, scaling)
		local min_curse = min_curse or 5
		local weight = weight or G.GAME.curse
		local scaling = scaling or 1
		if weight == 0 then
			return false
		end
		local threshold = (min_curse * scaling) / weight
		local result = pseudorandom("curse"..seed)
		if G.GAME.modifiers.enable_cursed
           and G.GAME.curse >= min_curse
           and result > threshold then
            return true
        end
        return false
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
		  local threshold = nil
		  local modifier = nil

		  -- Rental cost increase
		  threshold = 3
		  modifier = 1
		  if not G.GAME.rental_rate_buffer then
			G.GAME.rental_rate_buffer = 0
		  end
		  G.GAME.rental_rate_buffer = G.GAME.rental_rate_buffer + mod

		  if math.abs(G.GAME.rental_rate_buffer) >= threshold then
			G.GAME.rental_rate = G.GAME.rental_rate + math.floor(G.GAME.rental_rate_buffer / threshold) * modifier
			G.GAME.rental_rate_buffer = 0
		  end

		  -- Inflation
		  threshold = 5
		  modifier = 2
		  if not G.GAME.inflation_buffer then
			G.GAME.inflation_buffer = 0
		  end
		  G.GAME.inflation_buffer = G.GAME.inflation_buffer + mod

		  if math.abs(G.GAME.inflation_buffer) >= threshold then
			G.GAME.inflation = G.GAME.inflation + math.floor(G.GAME.inflation_buffer / threshold) * modifier
			G.GAME.inflation_buffer = 0
			if G.STATE == G.STATES.SHOP then
		  		for _, card in ipairs(G.shop_jokers.cards) do
					card:set_cost()
		  		end
		  		for _, card in ipairs(G.shop_vouchers.cards) do
					card:set_cost()
		  		end
		  		for _, card in ipairs(G.shop_booster.cards) do
					card:set_cost()
		  		end
			end
		  end
		  -- Reroll cost increase
		  threshold = 2
		  modifier = 1
		  if not G.GAME.round_resets.reroll_cost_buffer then
			G.GAME.round_resets.reroll_cost_buffer = 0
		  end
		  G.GAME.round_resets.reroll_cost_buffer = G.GAME.round_resets.reroll_cost_buffer + mod

		  if math.abs(G.GAME.round_resets.reroll_cost_buffer) >= threshold then
			G.E_MANAGER:add_event(Event{
				func = function ()
					G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost + math.floor(G.GAME.round_resets.reroll_cost_buffer / threshold) * modifier
					calculate_reroll_cost(true)
					return true
				end
			})
			G.GAME.round_resets.reroll_cost_buffer = 0
		  end


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