local apple = {
    key = "apple",
    set = "Fruit",
    config = {  },
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
    loc_vars = function (self, info_queue)
        info_queue[#info_queue + 1] = { key = "leornd_sour", set = "Other" }
        return { vars = {self.config.extra.max_selection} }
    end,
    can_use = function (self, card)
        return #G.hand.highlighted >= 1 and #G.hand.highlighted <= self.config.extra.max_selection
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

return {
    apple,
    lemon,
    orange
}