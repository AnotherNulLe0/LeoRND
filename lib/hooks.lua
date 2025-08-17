-- Hook to add unlock event
-- I think this should be added to SMODS because it's very convenient
local emplace_hook = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
	emplace_hook(self, card, location, stay_flipped)
	if self == G.consumeables then
		check_for_unlock({type = "obtain_consumable"}) -- Called whenever a consumable is added to G.consumeables
	end
end

local start_run_hook = G.start_run
function G:start_run(args)
    start_run_hook(self, args)
	-- This adds fruit rotting
    self.GAME.fruit_rot_time = LeoRND.config.fruit_rot_time
	if LeoRND.config.curses_enabled then
		self.hand_text_area.curse = self.HUD:get_UIE_by_ID('curse_UI_count')
	end
end

local init_game_hook = Game.init_game_object
function Game:init_game_object()
	local proto = init_game_hook(self)
	-- Curses
	proto.curse = 0
	proto.max_curse = 0
	proto.curse_rate = 1
	return proto
end

local get_starting_params_hook = get_starting_params
function get_starting_params()
	local res = get_starting_params_hook()
	res.curses = 0
	return res
end

local hud_ref = create_UIBox_HUD
function create_UIBox_HUD()
	local old_hud = hud_ref()
	if G.GAME.modifiers.enable_cursed then
		local scale = 0.4
    	local stake_sprite = get_stake_sprite(G.GAME.stake or 1, 0.5)

    	local spacing = 0.13
    	local temp_col = G.C.DYN_UI.BOSS_MAIN
    	local temp_col2 = G.C.DYN_UI.BOSS_DARK

    	local contents = {
    	  {n=G.UIT.C, config={id = 'hud_ante',align = "cm", padding = 0.05, minw = 1, minh = 1, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
            {n=G.UIT.R, config={align = "cm", minh = 0.33, maxw = 0.9}, nodes={
              {n=G.UIT.T, config={text = localize('k_ante'), scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
            }},
            {n=G.UIT.R, config={align = "cm", r = 0.1, minw = 0.8, colour = temp_col2}, nodes={
              {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME.round_resets, ref_value = 'ante'}}, colours = {G.C.IMPORTANT},shadow = true, font = G.LANGUAGES['en-us'].font, scale = 2*scale}),id = 'ante_UI_count'}},
              {n=G.UIT.T, config={text = " ", scale = 0.3*scale}},
              {n=G.UIT.T, config={text = "/ ", scale = 0.7*scale, colour = G.C.WHITE, shadow = true}},
              {n=G.UIT.T, config={ref_table = G.GAME, ref_value='win_ante', scale = scale, colour = G.C.WHITE, shadow = true}}
            }},
          }},
          {n=G.UIT.C, config={minw = spacing},nodes={}},
          {n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 1, minh = 1, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
            {n=G.UIT.R, config={align = "cm", maxw = 0.9}, nodes={
              {n=G.UIT.T, config={text = localize('k_round'), minh = 0.33, scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
            }},
            {n=G.UIT.R, config={align = "cm", r = 0.1, minw = 0.8, colour = temp_col2, id = 'row_round_text'}, nodes={
              {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'round'}}, colours = {G.C.IMPORTANT},shadow = true, scale = 2*scale}),id = 'round_UI_count'}},
            }},
          }},
		  {n=G.UIT.C, config={minw = spacing},nodes={}},
		  {n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 1, minh = 1, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
				{n=G.UIT.R, config={align = "cm", maxw = 0.9}, nodes={
					{n=G.UIT.T, config={text = localize('k_curse'), minh = 0.33, scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
				  }},
				  {n=G.UIT.R, config={align = "cm", r = 0.1, minw = 0.8, colour = temp_col2, id = 'row_curse_text'}, nodes={
					  {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'curse'}}, colours = {G.C.PURPLE},shadow = true, scale = 2*scale}),id = 'curse_UI_count'}},
				  }},
			  }},
    	}
		old_hud.nodes[1].nodes[1].nodes[5].nodes[2].nodes[5].nodes = contents

	end
	return old_hud
end