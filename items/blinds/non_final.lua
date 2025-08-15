local othala = {
    key = "othala",
    boss = {min = 4, max = 10},
    calculate = function (self, blind, context)
        if context.discard and not G.GAME.blind.disabled then
            for _, card in ipairs(G.hand.highlighted) do
				card.ability.leornd_possessed = true
			end
            blind.triggered = true 
            blind:wiggle()
        end
    end,
    boss_colour = HEX '56789A'
}

local cursed_small = {
    key = "cursed_small",
    small = true,
    pos = { x = 0, y = 0 },
    mult = 1.5,
    boss_colour = mix_colours(mix_colours(G.C.BLUE, G.C.BLACK, 0.6), G.C.PURPLE, 0.4),
    in_pool = function (self)
        return LeoRND.utils.poll_curse_effect("smallblind", 5, G.GAME.curse + 2, 1.2)
    end
}

local cursed_big = {
    key = "cursed_big",
    big = true,
    pos = { x = 0, y = 1 },
    mult = 2,
    boss_colour = mix_colours(mix_colours(G.C.ORANGE, G.C.BLACK, 0.6), G.C.PURPLE, 0.4),
    in_pool = function (self)
        return LeoRND.utils.poll_curse_effect("bigblind", 5, G.GAME.curse + 1, 1.2)
    end
}

return {
    othala,
    cursed_small,
    cursed_big
}