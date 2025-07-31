local joker = {
	key = 'sour',
	config = { 
		numetal = true, -- Stone sour can be considered nu-metal, so I'll add this flag to make Buffonery's mod maggit work with this joker
		extra = {  } 
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "leornd_sour", set = "Other" }
		return { vars = {  } }
	end,
	rarity = 1,
	atlas = 'jokers',
	pos = { x = 3, y = 1 },
	pixel_size = { h = 69 },

	cost = 4,

	in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_stone') then
                return true
            end
        end
        return false
    end,

	calculate = function(self, card, context)
		if context.before and context.main_eval and not context.blueprint then
			local count = 0
			for _, scored_card in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(scored_card, 'm_stone') and not scored_card.ability.leornd_sour then
					scored_card.ability.leornd_sour = true
					count = count + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
			if count > 0 then
				return {
					message = localize("k_upgrade_ex")
				}
			end
		end
	end
}

return joker