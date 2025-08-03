local othala = {
    key = "othala",
    boss = {min = 4, max = 10},
    calculate = function (self, blind, context)
        if context.discard and not G.GAME.blind.disabled then
            for _, card in ipairs(G.hand.highlighted) do
				card.ability.leornd_possessed = true
			end
        end
    end
}

return {
    othala
}