local fruity = {
    key = "fruity",
    shader = false,
    config = { mult=15 },

    extra_cost = 3,

	in_shop = G.PROFILES[G.SETTINGS.profile].leornd_fruity or false,
	weight = G.PROFILES[G.SETTINGS.profile].leornd_fruity and 0.5 or 0,

    calculate = function(self, card, context)
        if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                mult = card.edition.mult
            }
        end
    end
}

return {
    fruity
}