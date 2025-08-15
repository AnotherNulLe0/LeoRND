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
    local debugplus = dpAPI.registerID("MyMod")
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
	    name = "blind",
	    shortDesc = "Reroll upcoming blinds",
	    desc = "Reroll upcoming blinds. Usage:\n\
				blind [kind] reroll - rerolls selected blind kind.\n\
				blind [kind] set [blind] - replaces [kind]blind with a specified blind.\n\
				Possible blind kinds: 'small', 'big' and 'boss'",
	    exec = function (args, rawArgs, dp)
			if G.STAGE ~= G.STAGES.RUN then
        	    return "This command must be run during a run.", "ERROR"
        	end
        	local subCmd = args[2]
        	local kind = args[1]
        	local replaceWith = args[3]
			if subCmd == "reroll" then
        		if kind == "small" then
        		    G.FUNCS.reroll_small_blind()
        		elseif kind == "big" then
        		    G.FUNCS.reroll_big_blind()
        		elseif kind == "boss" then
					G.from_boss_tag = true
        		    G.FUNCS.reroll_boss()
        		else
        		    return "Uknown kind of blind: '"..kind.."'.Possible blind kinds: 'small', 'big' and 'boss'", "ERROR"
        		end
				return "Rerolling "..kind.." blind."
			elseif subCmd == "set" then
				G.FUNCS.set_blind(kind, replaceWith)
				return "Replacing "..kind.." with "..replaceWith.."."
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

-- Register fruit-themed pool
local fruit_jokers = {
	-- Fruit jokers
	["j_gros_michel"] = true,
	["j_cavendish"] = true,
	["j_leornd_tree"] = true,
	["j_leornd_fruity_joker"] = true,
	["j_leornd_fruityful_joker"] = true,
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

-- Load jokers
LeoRND.utils.load_content("items/jokers/common.lua", SMODS.Joker)
LeoRND.utils.load_content("items/jokers/uncommon.lua", SMODS.Joker)
LeoRND.utils.load_content("items/jokers/rare.lua", SMODS.Joker)
LeoRND.utils.load_content("items/jokers/legendary.lua", SMODS.Joker)

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
