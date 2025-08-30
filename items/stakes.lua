local midnight = {
    key = "midnight",
    applied_stakes = { "gold" },
    above_stake = "gold",
    prefix_config = { applied_stakes = { mod = false }, above_stake = { mod = false } },

    atlas = "stakes",
    pos = { x = 0, y = 0 },
    colour = HEX("333660"),

    modifiers = function ()
        G.GAME.modifiers.enable_cursed = true
    end
}

local molten = {
    key = "molten",
    applied_stakes = { "leornd_midnight" },
    prefix_config = { applied_stakes = { mod = false }, above_stake = { mod = false } },

    atlas = "stakes",
    pos = { x = 1, y = 0 },
    colour = HEX("333660"),

    modifiers = function ()
        G.GAME.curse_rate = 3
    end
}

return {
    midnight,
    -- molten
}