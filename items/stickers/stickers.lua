local sour = {
    key = "sour",
    badge_colour = HEX 'ffdd49',
    pos = { x = 0, y = 0 },
    atlas = "stickers",
    should_apply = false,
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
    should_apply = false,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                xmult = LeoRND.config.possessed_mult_mod
            }
        end
        if context.hand_drawn then
            card.ability.possessed_can_destroy = true
        end
        if context.discard and card.ability.possessed_can_destroy and context.other_card == card then
            card:start_dissolve()
        end
    end
}

return {
    sour,
    possessed
}