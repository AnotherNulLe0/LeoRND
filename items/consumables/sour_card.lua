local consumable = {
    key = "sour_card",
    set = "Spectral",
    config = { extra = {max_selection = 2} },
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
return consumable