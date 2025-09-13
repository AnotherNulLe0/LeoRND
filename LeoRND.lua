-- Question: why does this mod has a load priority of 667?
-- Answer: Entropy's load priority is 666, so I had to make a little lower(higher) proprity
LeoRND = SMODS.current_mod
LeoRND.utils = SMODS.load_file("utils.lua")()
LeoRND.config = SMODS.load_file("config.lua")()
SMODS.load_file("lib/hooks.lua")()
SMODS.load_file("lib/ownerships.lua")()
-- Additions to blinds
SMODS.load_file("lib/blinds.lua")()

-- Debug+ api
local success, dpAPI = pcall(require, "debugplus-api")

if success and dpAPI.isVersionCompatible(1) then
    local debugplus = dpAPI.registerID("LeoRND")
	debugplus.addCommand({
	    name = "curse",
	    shortDesc = "Set or add to your curse",
	    desc = "(Must have a curse counter present) Set or add to your curse. Usage:\ncurse set [amount] - Set the current curse to the given amount\ncurse add [amount] - Adds the given number of curse.",
	    exec = function (args, rawArgs, dp)
	        if G.STAGE ~= G.STAGES.RUN then
        	    return "This command must be run during a run.", "ERROR"
        	end
			if not G.GAME.modifiers.enable_cursed then
				return "This command must be run during a run with curses enabled", "ERROR"
			end
        	local subCmd = args[1]
        	local amount = tonumber(args[2])
        	if subCmd == "set" then
        	    if not amount then
        	        return "Please provide a valid number to set/add.", "ERROR"
        	    end
        	    ease_curse(amount - G.GAME.curse)
				return "Curse is now " .. amount
        	elseif subCmd == "add" then
        	    if not amount then
        	        return "Please provide a valid number to set/add.", "ERROR"
        	    end
        	    ease_curse(amount)
				return "Curse is now " .. G.GAME.curse + amount
        	else
        	    return "Please choose whether you want to add or set. For more info, run 'help curse'"
        	end
	    end
	})
	debugplus.addCommand({
	    name = "voucher",
	    shortDesc = "Reedeem a voucher",
	    desc = "Reedeem a voucher by it's game ID. Usage:\nvoucher reedeem [id] - Reedeem voucher by it's id\nvoucher unreedeem [id] - Unreedeem voucher by it's id.",
	    exec = function (args, rawArgs, dp)
	        if G.STAGE ~= G.STAGES.RUN then
        	    return "This command must be run during a run.", "ERROR"
        	end
        	local subCmd = args[1]
			local id = args[2]
			if subCmd == "reedeem" and G.P_CENTERS[id] then
				G.GAME.used_vouchers[id] = true
        		Card.apply_to_run(nil, G.P_CENTERS[id])
				return "Reedeemed!"
			elseif subCmd == "reedeem" and not G.P_CENTERS[id] then
				return "Unknown key '"..id.."'.", "ERROR"
			elseif subCmd == "unreedeem" and G.GAME.used_vouchers[id] then
				G.GAME.used_vouchers[id] = nil
				return "Unreedeemed!"
			elseif subCmd == "unreedeem" and not G.P_CENTERS[id] then
				return "Unknown key '"..id.."'.", "ERROR"
			elseif subCmd == "unreedeem" and not G.GAME.used_vouchers[id] then
				return "This voucher is not reedeemed yet.", "ERROR"
			else
        	    return "Please choose whether you want to reedeem or unreedeem. For more info, run 'help voucher'"
			end
	    end
	})
	debugplus.addCommand({
	    name = "cheat",
	    shortDesc = "Infinite money",
	    desc = "Infinite money",
	    exec = function (args, rawArgs, dp)
	        ease_dollars(10^10^100) -- Googolplex money (hehe)
	    end
	})
	debugplus.addCommand({
	    name = "blind",
	    shortDesc = "Reroll upcoming blinds",
	    desc = "Reroll upcoming blinds. Usage:\nblind reroll [kind] - rerolls selected blind kind.\nblind [kind] set [blind] - replaces [kind]blind with a specified blind.\nPossible blind kinds: 'small', 'big' and 'boss'",
	    exec = function (args, rawArgs, dp)
			if G.STAGE ~= G.STAGES.RUN then
        	    return "This command must be run during a run.", "ERROR"
        	end
			if args[1] == "reroll" then
        		if args[2] == "small" then
        		    G.FUNCS.reroll_small_blind()
        		elseif args[2] == "big" then
        		    G.FUNCS.reroll_big_blind()
        		elseif args[2] == "boss" then
					G.from_boss_tag = true
        		    G.FUNCS.reroll_boss()
				elseif args[2] == "all" then
					G.FUNCS.reroll_small_blind()
					G.FUNCS.reroll_big_blind()
					G.from_boss_tag = true
        		    G.FUNCS.reroll_boss()
        		else
        		    return "Unknown kind of blind: '"..args[2].."' .Possible blind kinds: 'small', 'big' and 'boss'. Also you can reroll all blinds by selecting 'all' blind kind.", "ERROR"
        		end
				return "Rerolling "..args[2].." blind."
			elseif args[2] == "set" and args[3] and (args[1] == "boss" or args[1] == "small" or args[1] == "big") and G.P_BLINDS[args[3]] then
				G.FUNCS.set_blind(args[1], args[3])
				return "Replaced "..args[1].." with "..args[3].."."
			elseif args[2] == "set" and args[3] and (args[1] == "boss" or args[1] == "small" or args[1] == "big") then
				return "'"..args[3].."' is not a valid blind.", "ERROR"
			elseif args[2] == "set" and args[3] then
				return "'"..args[1].."' is not a valid blind.", "ERROR"
			elseif args[2] == "set" and not args[3] then
				return "Please specify with what blind you want to replace "..args[1].." blind.", "ERROR"
			else
				return "Please choose whether you want to reroll or set. For more info, run 'help blind'"
			end

	    end
	})
end

SMODS.Atlas {
	key = "jokers",
	path = "jokers.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "stickers",
	path = "stickers.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "fruit",
	path = "fruit.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "stakes",
	path = "chips.png",
	px = 29,
	py = 29
}

-- Register fruit cards
SMODS.ConsumableType {
	key = "Fruit",
	primary_colour = {},
	secondary_colour = HEX(LeoRND.config.fruit_label_colour),
	loc_txt = {
		name = "Fruit",
		collection = "Fruit"
	},
	shop_rate = G.PROFILES[G.SETTINGS.profile].leornd_fruity and LeoRND.config.fruit_rate or 0
}

SMODS.UndiscoveredSprite {
	key = "Fruit",
	atlas = "fruit",
	pos = { x = 3, y = 2}
}

-- Register fruit-themed pool
local fruit_jokers = {
	-- Fruit jokers
	["j_gros_michel"] = true,
	["j_cavendish"] = true,
}

-- Gonna add theese strawberry jokers
if next(SMODS.find_mod("Buffoonery")) then
	fruit_jokers["j_buf_gfondue"] = true
	fruit_jokers["j_buf_camarosa"] = true
end

if next(SMODS.find_mod("extracredit")) then
	fruit_jokers["j_ExtraCredit_starfruit"] = true
	fruit_jokers["j_ExtraCredit_badapple"] = true
end

if next(SMODS.find_mod("Cryptid")) then
	fruit_jokers["j_cry_starfruit"] = true
end

if next(SMODS.find_mod("entr")) then
	fruit_jokers["j_entr_dragonfruit"] = true
end

SMODS.ObjectType {
	key = "FruitPool",
	default = "j_joker",
	cards = fruit_jokers
}

SMODS.ObjectType {
	key = "Demonic",
	default = "j_joker",
}

-- Load jokers
local jokers = {}
for _, file in ipairs(NFS.getDirectoryItems(LeoRND.path.."/items/jokers/")) do
	for _, jkr in ipairs(SMODS.load_file("items/jokers/"..file)()) do
		jokers[#jokers+1] = jkr
	end
end
table.sort(
	jokers,
	function (a, b)
		return a.order < b.order
	end
)
for _, jkr in ipairs(jokers) do
	SMODS.Joker(jkr)
end

-- Load stickers
LeoRND.utils.load_content("items/stickers.lua", SMODS.Sticker)

-- Load consumables
LeoRND.utils.load_content("items/consumables/fruit.lua", SMODS.Consumable)

-- Load blinds
LeoRND.utils.load_content("items/blinds/non_final.lua", SMODS.Blind)

-- Load editions
LeoRND.utils.load_content("items/editions.lua", SMODS.Edition)

-- Load challenges
LeoRND.utils.load_content("items/challenges.lua", SMODS.Challenge)

-- Load stakes
LeoRND.utils.load_content("items/stakes.lua", SMODS.Stake)

-- Load sounds
SMODS.Sound({ key = "crit_hit", path = "crit_hit.ogg"})

SMODS.current_mod.optional_features = {
	retrigger_joker = true
}
