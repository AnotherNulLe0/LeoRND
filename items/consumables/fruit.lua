local apple = {
    key = "apple",
    set = "Fruit",
    config = { extra = {} },
    atlas = "fruit",
    pos = { x = 0, y = 0 },

    can_use = function (self, card)
        if #G.jokers.highlighted >= 1 and #G.hand.highlighted >= 1 then
            return false
        end
        local highlighted = G.hand.highlighted
        if #G.jokers.highlighted == 1 then
            highlighted = G.jokers.highlighted
        end
        return #highlighted == 1 and LeoRND.utils.find_next_edition(highlighted[1])
    end,

    use = function (self, card, area, copier)
        local highlighted = G.hand.highlighted[1]
        if #G.jokers.highlighted == 1 then
            highlighted = G.jokers.highlighted[1]
        end

        local next_edition = LeoRND.utils.find_next_edition(highlighted)

        -- Set new edition of selected card\joker
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function ()
                highlighted:set_edition(next_edition, true)
                return true
            end
        }))
    end
}

local lemon = {
    key = "lemon",
    set = "Fruit",
    config = { extra = {max_selection = 2} },
    atlas = "fruit",
    pos = { x = 1, y = 0 },
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "leornd_sour", set = "Other" }
        return { vars = {card.ability.extra.max_selection} }
    end,
    can_use = function (self, card)
        return #G.hand.highlighted >= 1 and #G.hand.highlighted <= card.ability.extra.max_selection
    end,
    use = function (self, card, area, copier)
        local highlighted = G.hand.highlighted
        if highlighted then
            for i, v in ipairs(highlighted) do
                v.ability.leornd_sour = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        v:juice_up()
                        return true
                    end
                }))
            end
        end
    end
}

-- Used in orange.can_use(), orange.use() and orange.loc_vars()
local function count_fruit_themed_items(except)
    local counter = 0
    if not G.consumeables then
        return 0
    end

    -- Find fruit-themed in consumables
    for _, v in ipairs(G.consumeables.cards) do
        if (v.ability.set == "Fruit" or v.config.fruit_themed) and v ~= except then
            counter = counter + 1
        end
    end

    -- Find fruit-themed jokers
    for _, v in ipairs(G.jokers.cards) do
        if v.ability.fruit_themed or LeoRND.utils.is_in_pool(v, "FruitPool") then
            counter = counter + 1
        end
    end

    return counter
end

local orange = {
    key = "orange",
    set = "Fruit",
    config = { extra = { } },
    atlas = "fruit",
    pos = { x = 2, y = 0 },
    loc_vars = function (self, info_queue, card)
        return { vars = {count_fruit_themed_items(card)} }
    end,
    can_use = function (self, card)
        return count_fruit_themed_items(card) > 0
    end,
    use = function (self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function ()
                ease_dollars(count_fruit_themed_items(card), true)
                return true
            end
        }))
    end
}

local peach = {
    key = "peach",
    set = "Fruit",
    config = { extra = { rot_modifier = 2 } },
    atlas = "fruit",
    pos = { x = 3, y = 0 },
    loc_vars = function (self, info_queue, card)
        return { vars = { } }
    end,
    can_use = function (self, card)
        return false
    end
}

local pear = {
    key = "pear",
    set = "Fruit",
    config = { extra = { } },
    atlas = "fruit",
    pos = { x = 0, y = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = { } }
    end,
    can_use = function (self, card)
        return false
    end,
    use = function (self, card, area, copier)
        
    end
}

local coconut = {
    key = "coconut",
    set = "Fruit",
    config = { extra = { additional_slots = 2 } },
    atlas = "fruit",
    pos = { x = 0, y = 2 },
    no_pool_flag = "coconut_appeared",
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.additional_slots } }
    end,
    can_use = function (self, card)
        return true
    end,
    calculate = function (self, card, context)
        if context.card_added then
            G.GAME.pool_flags.coconut_appeared = true
        end
    end,
    use = function (self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function ()
                G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.additional_slots
                return true
            end
        }))
    end
}

local cracked_coconut = {
    key = "cracked_coconut",
    set = "Fruit",
    config = { extra = { rot_reduce = 1.5 } },
    atlas = "fruit",
    pos = { x = 1, y = 2 },
    yes_pool_flag = "coconut_appeared",
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.rot_reduce } }
    end,
    can_use = function (self, card)
        return true
    end,
    use = function (self, card, area, copier)
        G.GAME.fruit_rot_time = G.GAME.fruit_rot_time * card.ability.extra.rot_reduce
    end
}

local cherry = {
    key = "cherry",
    set = "Fruit",
    config = { extra = { } },
    atlas = "fruit",
    pos = { x = 2, y = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = { } }
    end,
    can_use = function (self, card)
        return false
    end,
    use = function (self, card, area, copier)
        
    end
}

local grape = {
    key = "grape",
    set = "Fruit",
    config = { extra = { rot_modifier = 0.5 } },
    atlas = "fruit",
    pos = { x = 1, y = 1 },
    override_calculate = true,
    loc_vars = function (self, info_queue, card)
        return { vars = { 1 / card.ability.extra.rot_modifier } }
    end,
    can_use = function (self, card)
        return false
    end,
    calculate = function (self, card, context)
        if context.end_of_round and context.game_over == false and context.beat_boss and not context.repetition then
	    	card.ability.extra.ante_count = card.ability.extra.ante_count + 1
            if card.ability.extra.ante_count >= math.floor(G.GAME.fruit_rot_time / (card.ability.extra.rot_modifier or 1)) then
                SMODS.add_card({set = "Joker", key = "j_leornd_wine"})
                G.E_MANAGER:add_event(Event({
                    func = LeoRND.utils.event_destroy_card(card)
                }))
                return {
                    message = localize("k_rotten"),
                    remove_default_message = true
                }
            end
            return {
                message = "-1",
                remove_default_message = true
            }
	    end
    end,
}

local golden_apple = {
    key = "golden_apple",
    set = "Fruit",
    config = { extra = { convert_to = "m_gold" } },
    atlas = "fruit",
    pos = { x = 2, y = 2 },
    override_calculate = true,
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS[card.ability.extra.convert_to]
        return { vars = { } }
    end,
    can_use = function (self, card)
        return true
    end,
    use = function (self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i, k in ipairs(G.hand.cards) do
            local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    k:flip()
                    play_sound('card1', percent)
                    k:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        local _suit = pseudorandom_element(SMODS.Suits, 'sigil')
        for i, k in ipairs(G.hand.cards) do
            G.E_MANAGER:add_event(Event({
                func = function()
                    k:set_ability(card.ability.extra.convert_to)
                    return true
                end
            }))
        end
        for i, k in ipairs(G.hand.cards) do
            local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    k:flip()
                    play_sound('tarot2', percent, 0.6)
                    k:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.5)
    end,
    
}

local watermelon = {
    key = "watermelon",
    set = "Fruit",
    config = { extra = { } },
    atlas = "fruit",
    pos = { x = 3, y = 1 },
    loc_vars = function (self, info_queue, card)
        return { vars = { } }
    end,
    can_use = function (self, card)
        return false
    end,
    use = function (self, card, area, copier)
        
    end
}

local fruits = {
    apple,
    lemon,
    orange,
    peach,
    pear,
    coconut,
    cracked_coconut,
    cherry,
    watermelon,
    grape,
    golden_apple
}

-- This makes every fruit rot
for _, fruit in ipairs(fruits) do
    fruit.config.extra.ante_count = 0

    local calculate_ref = (fruit.calculate or function (self, card, context) end)
    if not fruit.override_calculate then
        fruit.calculate = function (self, card, context)
            calculate_ref(self, card, context)
            if context.end_of_round and context.game_over == false and context.beat_boss and not context.repetition then
	    		card.ability.extra.ante_count = card.ability.extra.ante_count + 1
                if card.ability.extra.ante_count >= math.floor(G.GAME.fruit_rot_time / (fruit.config.extra.rot_modifier or 1)) then
                    G.E_MANAGER:add_event(Event({
                        func = LeoRND.utils.event_destroy_card(card)
                    }))
                    return {
                        message = localize("k_rotten"),
                        remove_default_message = true
                    }
                end
                return {
                    message = "-1",
                    remove_default_message = true
                }
	    	end
        end
    end

    local loc_vars_ref = (fruit.loc_vars or 
        function ()
            return {vars={}}
        end
    )
    fruit.loc_vars = function (self, info_queue, card)
        local result_table = loc_vars_ref(self, info_queue, card)
        table.insert(result_table.vars, math.floor((G.GAME and G.GAME.fruit_rot_time or LeoRND.config.fruit_rot_time) / (card.ability.extra.rot_modifier or 1)) - card.ability.extra.ante_count)
        return result_table
    end

    local in_pool_ref = fruit.in_pool
    fruit.in_pool = function (self, args)
        local condition = G.PROFILES[G.SETTINGS.profile].leornd_fruity
        return (in_pool_ref and in_pool_ref(self, args) or true) and condition
    end
end

return fruits