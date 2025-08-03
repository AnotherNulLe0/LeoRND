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

return {
    apple,
    lemon
}