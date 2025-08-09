-- Hook to add unlock event
-- I think this should be added to SMODS because it's very convenient
local emplace_hook = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
	emplace_hook(self, card, location, stay_flipped)
	if self == G.consumeables then
		check_for_unlock({type = "obtain_consumable"}) -- Called whenever a consumable is added to G.consumeables
	end
end

-- This adds fruit rotting
local start_run_hook = G.start_run
function G:start_run(args)
    start_run_hook(self, args)
    self.GAME.fruit_rot_time = LeoRND.config.fruit_rot_time
end