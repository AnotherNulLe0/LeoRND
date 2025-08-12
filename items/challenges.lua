local pact = {
    key = "pact_challenge",
    unlocked = function (self)
        return G.P_CENTERS["j_leornd_unfairer_dice"].discovered and G.P_CENTERS["j_leornd_brimstone"].discovered
    end,
    rules = {
        custom = {
            { id = "leornd_pact" },
        },
        modifiers = {
            { id = "joker_slots", value = 3 },
            { id = "hands", value = 1}
        }
    },
    jokers = {
        {
            id = "j_leornd_brimstone",
            edition = "negative",
            -- Use Entropy's aleph, fallbacks to Cryptid's absolute, fallbacks to vanilla eternal
            eternal =  not (Entropy and Cryptid.enabled("entr_aleph") or Cryptid and Cryptid.enabled("cry_absolute")),
            stickers = {(Entropy and Cryptid.enabled("entr_aleph") and "entr_aleph") or (Cryptid and Cryptid.enabled("cry_absolute") and "cry_absolute")},
        },
        {
            id = "j_leornd_unfairer_dice",
            -- Use Entropy's aleph, fallbacks to Cryptid's absolute, fallbacks to vanilla eternal
            eternal =  not (Entropy and Cryptid.enabled("entr_aleph") or Cryptid and Cryptid.enabled("cry_absolute")),
            stickers = {(Entropy and Cryptid.enabled("entr_aleph") and "entr_aleph") or (Cryptid and Cryptid.enabled("cry_absolute") and "cry_absolute")},
        },
    },
    restrictions = {
        banned_cards = {
            { id = "c_sun"}, -- There's no need to change heart cards into heart cards (huh)
            { id = "c_moon" }, -- Changes suit
            { id = "c_star" }, -- Changes suit
            { id = "c_world" }, -- Changes suit
            { id = "c_sigil" }, -- 75% chance to convert into non-hearts suit
            { id = "c_familiar" }, -- Spawns cards with random suits
            { id = "c_grim" }, -- Spawns cards with random suits
            { id = "c_incantation" }, -- Spawns cards with random suits
            { id = "c_ectoplasm" }, -- Applies negative
            { id = "c_lovers" }, -- Changes suit (into all-suit)
            { id = "v_grabber" }, -- +1 hands 
            { id = "v_nacho_tong" }, -- +1 hands
            { id = "v_hieroglyph"}, -- -1 hands (=0)
            { id = "v_blank" }, -- Potentially +1 joker slot
            { id = "v_antimatter" }, -- +1 joker slot
            { id = "v_magic_trick" }, -- Spawns cards with random suits
            { id = "v_illusion" }, -- Spawns cards with random suits
            { id = "j_greedy_joker"}, -- Suit-effect
            { id = "j_wrathful_joker"}, -- Suit-effect
            { id = "j_gluttenous_joker"}, -- Suit-effect
            { id = "j_rough_gem" }, -- Suit-effect
            { id = "j_arrowhead" }, -- Suit-effect
            { id = "j_onyx_agate" }, -- Suit-effect
            { id = "j_seeing_double" }, -- Suit-based effect
            { id = "j_smeared" }, -- Suit-based effect
            { id = "j_flower_pot" }, -- Suit-based effect
            { id = "j_blackboard" }, -- Suit-based effect
            { id = "j_ancient" }, -- Suit-based effect
            { id = "j_castle" }, -- Suit-based effect
            { id = "j_idol" }, -- Suit-based effect
            { id = "j_burglar"}, -- +3 hands
            { id = "j_troubadour" }, -- -1 hands (=0)
            { id = 'p_standard_normal_1', 
              ids = {
                'p_standard_normal_1', 'p_standard_normal_2', 'p_standard_normal_3', 'p_standard_normal_4',
                'p_standard_jumbo_1', 'p_standard_jumbo_2', 'p_standard_mega_1', 'p_standard_mega_2'
              }
            },
        },
        banned_tags = {
            { id = 'tag_negative' }, -- Banned this, so player cannot easily get negatives
            { id = 'tag_standard' }, -- Banned this, so player cannot get non-hearts cards
        },
        banned_other = {
            { id = "bl_club", type = "blind" }, -- Suit-debuff blinds
            { id = "bl_goad", type = "blind" }, -- Suit-debuff blinds
            { id = "bl_window", type = "blind" }, -- Suit-debuff blinds
            { id = "bl_head", type = "blind" }, -- Maybe I should include this...
            { id = "bl_needle", type = "blind" }, -- The needle does nothing actually
        }
    },
    deck = {
        type = 'Challenge Deck',
        cards = {
            {s = "H", r = "A", e = "m_glass"},
            {s = "H", r = "A", e = "m_glass"},
            {s = "H", r = "K", e = "m_glass"},
            {s = "H", r = "K", e = "m_glass"},
            {s = "H", r = "Q", e = "m_glass"},
            {s = "H", r = "Q", e = "m_glass"},
            {s = "H", r = "J", e = "m_glass"},
            {s = "H", r = "J", e = "m_glass"},
            {s = "H", r = "T", e = "m_glass"},
            {s = "H", r = "T", e = "m_glass"},
            {s = "H", r = "9", e = "m_glass"},
            {s = "H", r = "9", e = "m_glass"},
            {s = "H", r = "8", e = "m_glass"},
            {s = "H", r = "8", e = "m_glass"},
            {s = "H", r = "7", e = "m_glass"},
            {s = "H", r = "7", e = "m_glass"},
            {s = "H", r = "6", e = "m_glass"},
            {s = "H", r = "6", e = "m_glass"},
            {s = "H", r = "5", e = "m_glass"},
            {s = "H", r = "5", e = "m_glass"},
            {s = "H", r = "4", e = "m_glass"},
            {s = "H", r = "4", e = "m_glass"},
            {s = "H", r = "3", e = "m_glass"},
            {s = "H", r = "3", e = "m_glass"},
            {s = "H", r = "2", e = "m_glass"},
            {s = "H", r = "2", e = "m_glass"},
        }
    }
}

return {
    pact
}