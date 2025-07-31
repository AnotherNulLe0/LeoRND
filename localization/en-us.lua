return {
    descriptions = {
        Joker = {
            j_leornd_brimstone = {
                name = "Brimstone",
                text = {
		        	"Gains {X:dark_edition,C:white}^#2#{} Mult",
		        	"when boss blind",
		        	"gets defeated",
		        	"{C:inactive}(Currently {X:dark_edition,C:white}^#1#{}{C:inactive} Mult)"
		        }
            },
            j_leornd_tboi_glass = {
                name = '20/20',
		        text = {
					"Pick {C:attention}#1#{} addtitional",
		        	"card in {C:attention}booster pack{}",
		        	"{X:chips,C:white}X#2#{} Chips",
		        	"{X:mult,C:white}X#3#{} Mult",
		        	"{C:green}#4# in #5#{} chance this",
		        	"card is destroyed",
		        	"at end of round"
		        }
            },
            j_leornd_sour_glass = {
                name = '30/30-150',
		        text = {
		        	"Pick {C:attention}#1#{} addtitional",
		        	"cards in {C:attention}booster pack{}",
		        	"{X:chips,C:white}X#2#{} Chips",
		        	"{C:green}#3# in #4#{} chance this",
		        	"card is destroyed",
		        	"at end of round"
		        }
            },
            j_leornd_a_grade = {
                name = 'A+ grade',
		        text = {
		        	"Gains {C:mult}+#1#{} Mult",
		        	"when total chips exceeded",
		        	"{C:attention}#3#x{} blind size.",
		        	"Threshold increases with each ante",
		        	"{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}"
		        }
            },
			j_leornd_pan = {
				name = "Pan",
				text = {
					"{C:green}#2# in #3#{} chance",
					"for {X:dark_edition,C:white}^#1#{} Mult.",
					"Odds increase by {C:attention}#4#{}",
					"per played hand.",
					"Odds reset when mult is given",
					"{C:inactive,s:0.7}Random crits are fair and balanced{}"
				}
			},
			j_leornd_abszero = {
				name = "Absolute zero",
				text = {
					"{C:mult}+#1#{} Mult",
					"{X:chips,C:white}X#2#{} Chips",
					"when playing a {C:attention}three of a kind{}",
					"with 1 unscored card",
					"{C:inactive,s:0.7}\"Man\" is a four-letter word{}"
				}
			},
			j_leornd_placeholder = {
				name = "placeholder",
				text = {
					"Retrigger every",
					"non-{C:legendary}legendary{} joker",
				}
			}
        }
    },
	misc = {
		dictionary = {
			k_broken = "Broken!"
		}
	}
}