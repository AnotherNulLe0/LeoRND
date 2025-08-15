-- Replace <selected> blind with <blind>
G.FUNCS.set_blind = function (selected, blind)
    local sel_upper = selected:gsub("^%l", string.upper)
    stop_use()
    if selected == "boss" then
        G.GAME.round_resets.boss_rerolled = true
        G.CONTROLLER.locks.boss_reroll = true
    else
        G.GAME.round_resets.blind_rerolled = selected
        G.CONTROLLER.locks.blind_reroll = true
    end
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
            play_sound('other1')
            G.blind_select_opts[selected]:set_role({xy_bond = 'Weak'})
            G.blind_select_opts[selected].alignment.offset.y = 20
            return true
        end
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.3,
        func = (function()
            local par = G.blind_select_opts[selected].parent
            if selected == "boss" then
                G.GAME.round_resets.blind_choices.Boss = blind
            else
                G.GAME.round_resets.blind_choices[sel_upper] = blind
            end

            G.blind_select_opts[selected]:remove()
            G.blind_select_opts[selected] = UIBox{
            T = {par.T.x, 0, 0, 0, },
            definition =
            {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
                UIBox_dyn_container({create_UIBox_blind_choice(sel_upper)},false,get_blind_main_colour(sel_upper), mix_colours(G.C.BLACK, get_blind_main_colour(sel_upper), 0.8))
            }},
            config = { align="bmi",
                    offset = {x=0,y=G.ROOM.T.y + 9},
                    major = par,
                    xy_bond = 'Weak'
                }
            }
            par.config.object = G.blind_select_opts[selected]
            par.config.object:recalculate()
            G.blind_select_opts[selected].parent = par
            G.blind_select_opts[selected].alignment.offset.y = 0

            G.E_MANAGER:add_event(Event({blocking = false, trigger = 'after', delay = 0.5,func = function()
                G.CONTROLLER.locks.blind_reroll = nil
                G.CONTROLLER.locks.boss_reroll = nil
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

-- Small blind reroll
G.FUNCS.reroll_small_blind = function(e)
    G.FUNCS.set_blind("small", get_new_blind("small"))
end

-- Big blind reroll
G.FUNCS.reroll_big_blind = function(e)
    G.FUNCS.set_blind("big", get_new_blind("big"))
end