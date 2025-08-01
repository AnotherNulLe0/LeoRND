local joker = {
	key = 'dice',
	config = {  },
	loc_vars = function(self, info_queue, card)
		return { vars = {  } }
	end,
	rarity = 2,
	atlas = 'jokers',
    unlocked = false,
	pos = { x = 0, y = 2 },

	blueprint_compat = true,

	cost = 6,

    -- I'll leave this unlock method for other joker, it's way too cool
    -- check_for_unlock = function (self, args)
	-- 	if args.type == 'modify_jokers' and G.jokers then
    --         local checked = {}
    --         for _, joker in ipairs(G.jokers.cards) do
    --             if joker.ability.set == 'Joker' and not checked[joker.config.center.key] then
    --                 checked[joker.config.center.key] = 1
    --             elseif checked[joker.config.center.key] then
    --                 checked[joker.config.center.key] = checked[joker.config.center.key] + 1
    --                 if checked[joker.config.center.key] >= 3 then
    --                     return true
    --                 end
    --             end
    --         end
    --     end
    --     return false
	-- end,
    check_for_unlock = function (self, args)
		if args.type == 'modify_jokers' and G.jokers then
            local has_dice = false
            for _, joker in ipairs(G.jokers.cards) do
                if joker.ability.set == 'Joker' and joker.config.center.key == "j_oops" and not has_dice then
                    has_dice = true
                elseif has_dice then
                    return true
                end
            end
        end
        return false
	end,

	calculate = function(self, card, context)
		if context.mod_probability and not context.blueprint then
        	return {
        		numerator = context.numerator / 2
        	}
        end
	end
}

return joker