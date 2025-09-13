SMODS.Shader {
    key = "nostalgic",
    path = "nostalgic.fs"
}

local fruity = {
    key = "fruity",
    shader = false,
    config = { extra = { 
        ee_mult = 1.01
    } },

    extra_cost = 3,

	in_shop = G.PROFILES[G.SETTINGS.profile].leornd_fruity or false,
	weight = G.PROFILES[G.SETTINGS.profile].leornd_fruity and 0.5 or 0,

    loc_vars = function (self, info_queue, card)
        return { vars = { card.edition.extra.ee_mult  } }
    end,

    calculate = function(self, card, context)
        if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                ee_mult = card.edition.extra.ee_mult
            }
        end
    end
}

local nostalgic = {
    key = "nostalgic",
    shader = "nostalgic",
    config = { },

    extra_cost = 3,

	in_shop = true,
	weight = 0.6,

    loc_vars = function (self, info_queue, card)
        return { vars = {  } }
    end,

    on_apply = function (card)
        local ref = card.config.center.add_to_deck
        card.config.center.add_to_deck = function (_self, _card, from_debuff)
            if ref then
                ref(_self, _card, from_debuff)
            end
            G.E_MANAGER:add_event(Event({
                func = function ()
                    ease_ante(-1)
                    return true
                end
            }))
        end
    end,
}

return {
    fruity,
    nostalgic
}