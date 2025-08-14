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

-- Small blind reroll
 G.FUNCS.reroll_small_blind = function(e) 
    stop_use()
    G.GAME.round_resets.blind_rerolled = "small"
    G.CONTROLLER.locks.blind_reroll = true
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
          play_sound('other1')
          G.blind_select_opts.small:set_role({xy_bond = 'Weak'})
          G.blind_select_opts.small.alignment.offset.y = 20
          return true
        end
      }))
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.3,
      func = (function()
        local par = G.blind_select_opts.small.parent
        G.GAME.round_resets.blind_choices.Small = get_new_blind("small")

        G.blind_select_opts.small:remove()
        G.blind_select_opts.small = UIBox{
          T = {par.T.x, 0, 0, 0, },
          definition =
            {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
              UIBox_dyn_container({create_UIBox_blind_choice('Small')},false,get_blind_main_colour('Small'), mix_colours(G.C.BLACK, get_blind_main_colour('Small'), 0.8))
            }},
          config = {align="bmi",
                    offset = {x=0,y=G.ROOM.T.y + 9},
                    major = par,
                    xy_bond = 'Weak'
                  }
        }
        par.config.object = G.blind_select_opts.small
        par.config.object:recalculate()
        G.blind_select_opts.small.parent = par
        G.blind_select_opts.small.alignment.offset.y = 0
        
        G.E_MANAGER:add_event(Event({blocking = false, trigger = 'after', delay = 0.5,func = function()
            G.CONTROLLER.locks.small_reroll = nil
            return true
          end
        }))

        save_run()
        for i = 1, #G.GAME.tags do
          if G.GAME.tags[i]:apply_to_run({type = 'new_blind_choice'}) then break end
        end
          return true
      end)
    }))
  end

-- Big blind reroll
 G.FUNCS.reroll_big_blind = function(e) 
    stop_use()
    G.GAME.round_resets.blind_rerolled = "big"
    G.CONTROLLER.locks.blind_reroll = true
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
          play_sound('other1')
          G.blind_select_opts.big:set_role({xy_bond = 'Weak'})
          G.blind_select_opts.big.alignment.offset.y = 20
          return true
        end
      }))
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.3,
      func = (function()
        local par = G.blind_select_opts.big.parent
        G.GAME.round_resets.blind_choices.Big = get_new_blind("big")

        G.blind_select_opts.big:remove()
        G.blind_select_opts.big = UIBox{
          T = {par.T.x, 0, 0, 0, },
          definition =
            {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
              UIBox_dyn_container({create_UIBox_blind_choice('Big')},false,get_blind_main_colour('Big'), mix_colours(G.C.BLACK, get_blind_main_colour('Big'), 0.8))
            }},
          config = {align="bmi",
                    offset = {x=0,y=G.ROOM.T.y + 9},
                    major = par,
                    xy_bond = 'Weak'
                  }
        }
        par.config.object = G.blind_select_opts.big
        par.config.object:recalculate()
        G.blind_select_opts.big.parent = par
        G.blind_select_opts.big.alignment.offset.y = 0
        
        G.E_MANAGER:add_event(Event({blocking = false, trigger = 'after', delay = 0.5,func = function()
            G.CONTROLLER.locks.big_reroll = nil
            return true
          end
        }))

        save_run()
        for i = 1, #G.GAME.tags do
          if G.GAME.tags[i]:apply_to_run({type = 'new_blind_choice'}) then break end
        end
          return true
      end)
    }))
  end

return utils