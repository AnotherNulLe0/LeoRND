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

return {
    othala
}