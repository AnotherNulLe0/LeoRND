local function find_next_edition(card)
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
end
local consumable = {
    key = "apple_card",
    set = "Fruit",
    config = {  },

    can_use = function (self, card)
        if #G.jokers.highlighted >= 1 and #G.hand.highlighted >= 1 then
            return false
        end
        local highlighted = G.hand.highlighted
        if #G.jokers.highlighted == 1 then
            highlighted = G.jokers.highlighted
        end
        return #highlighted == 1 and find_next_edition(highlighted[1])
    end,

    use = function (self, card, area, copier)
        local highlighted = G.hand.highlighted[1]
        if #G.jokers.highlighted == 1 then
            highlighted = G.jokers.highlighted[1]
        end

        local next_edition = find_next_edition(highlighted)

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
return consumable