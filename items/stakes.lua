local midnight = {
    key = "midnight",
    applied_stakes = { "gold" },
    prefix_config = { applied_stakes = { mod = false } },

    atlas = "stakes",
    pos = { x = 0, y = 0 },
    colour = HEX("333660"),

    modifiers = function ()
        G.GAME.modifiers.enable_cursed = true
    end
}

return {
    midnight
}