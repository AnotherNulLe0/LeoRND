local sour = {
    key = "sour",
    badge_colour = HEX 'ffdd49',
    pos = { x = 0, y = 0 },
    atlas = "stickers",
    should_apply = function (self, card, center, area, bypass_roll)
        return false
    end,
    loc_vars = function (self, info_queue, card)
        return { vars = {
            LeoRND.config.sour_sticker_reduce,
            LeoRND.config.sour_sticker_chips,
        } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            G.E_MANAGER:add_event(
            Event({func = function()
						G.GAME.blind.chips = math.floor(G.GAME.blind.chips - G.GAME.blind.chips * LeoRND.config.sour_sticker_reduce)
						G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
						G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
						G.HUD_blind:recalculate()
						G.hand_text_area.blind_chips:juice_up()
						card:juice_up()
                return true
            end}))
            return {
                chips = LeoRND.config.sour_sticker_chips
            }
        end
    end
}

local possessed = {
    key = "possessed",
    badge_colour = HEX '1f1f1f',
    pos = { x = 1, y = 0 },
    atlas = "stickers",
    should_apply = function (self, card, center, area, bypass_roll)
        return false
    end,
    loc_vars = function (self, info_queue, card)
        local n, d = SMODS.get_probability_vars(card, LeoRND.config.possessed_numerator, LeoRND.config.possessed_denominator, 'othala')
        return { vars = {
            LeoRND.config.possessed_mult_mod,
            n, -- numerator
            d -- denominator
        } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                xmult = LeoRND.config.possessed_mult_mod
            }
        end
        if not context.discard then
            card.ability.possessed_active = true
        end
        if context.discard and card.ability.possessed_active and context.other_card == card 
        and SMODS.pseudorandom_probability(card, 'possessed', LeoRND.config.possessed_numerator, LeoRND.config.possessed_denominator, 'othala')  then
            G.E_MANAGER:add_event(Event({
                func = function ()
                    draw_card(G.discard, G.hand, nil, 'up', true, card, nil, nil, true)
                    return true
                end
            }))
            return {
                message = localize("k_returned_ex")
            }
        end
    end
}

local cursed = {
    key = "cursed",
    badge_colour = HEX '8867a5',
    pos = { x = 2, y = 0 },
    atlas = "stickers",

    loc_vars = function (self, info_queue, card)
        return { vars = { G.GAME.curse_rate or 1 } }
    end,

    should_apply = function (self, card, center, area, bypass_roll)
        if G.GAME.modifiers.enable_cursed and card.ability.set == "Joker" and pseudorandom((area == G.pack_cards and 'packetper' or 'etperpoll')..G.GAME.round_resets.ante) > 0.7 then
            return true
        end
    end,

    -- sets = {
        -- Joker = true
    -- },
    -- needs_enable_flag = true,
    -- rate = 1,

    apply = function(self, card, val)
        card.ability[self.key] = val
        if card.ability[self.key] then
            local ref = card.config.center.add_to_deck
            card.config.center.add_to_deck = function (self, card, from_debuff)
                if ref then
                    ref(self, card, from_debuff)
                end
                ease_curse(1)
            end
        end
    end,
}

return {
    sour,
    possessed,
    cursed
}