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
		        },
				unlock = {
					"Win #1# runs",
					"{C:inactive}(#2#){}"
				}
            },
            j_leornd_brimstone_alt = {
                name = "Brimstone",
                text = {
					"+{C:purple}#3# curse{}",
		        	"Gains {X:dark_edition,C:white}^#2#{} Mult",
		        	"when boss blind",
		        	"gets defeated",
		        	"{C:inactive}(Currently {X:dark_edition,C:white}^#1#{}{C:inactive} Mult)"
		        },
				unlock = {
					"Win #1# runs",
					"{C:inactive}(#2#){}"
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
		        },
				unlock = {
					"Have at least half of your deck",
                    "become {C:attention}glass{}",
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
				}
			},
			j_leornd_abszero = {
				name = "Absolute zero",
				text = {
					"{C:mult}+#1#{} Mult",
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
				},
                unlock={
                    "{E:1,s:1.3}?????",
                },
			},
			j_leornd_tree = {
				name = "Tree",
				text = {
					{
						"Spawns a random {C:attention}fruit{} card",
						"at the start of each ante",
						"{C:inactive}(must have room){}"
					},
					{
						"Fruit cards {C:attention}rot{} after #1# antes",
						"so you should use them before they are gone"
					}
				},
				unlock = {
					"Obtain a card with {C:attention}sour{} sticker"
				}
			},
			j_leornd_sour = {
				name = "Stone sour",
				text = {
					"Gives every played stone card",
					"a {C:attention}sour{} sticker",
				},
				unlock = {
					"Play a 5 card hand",
                    "that contains only",
                    "{C:enhanced,E:1}editioned{} stone cards",
					"{C:inactive}(ex: 1 polychrome stone + 4 foil stones)"
				}
			},
			j_leornd_dice = {
				name = "Unfair dice",
				text = {
					"Halves all {C:attention}listed",
                    "{C:green,E:1,S:1.1}probabilities",
                    "{C:inactive}(ex: {C:green}2 in 3{C:inactive} -> {C:green}1 in 3{C:inactive})"
				},
				unlock = {
					"Have 2 {C:attention}Oops! All 6s{}",
                    "at the same time",
				}
			},
			j_leornd_unfairer_dice = {
				name = "Unfairer dice",
				text = {
					"No listed {C:green,E:1,S:1.1}probability{}",
                    "will trigger",
                    "{C:inactive}(ex: {C:green}3 in 4{C:inactive} = {C:green}0 in 4{C:inactive})",
				},
				unlock = {
					"Have 3 {C:attention}Unfair dice{}",
                    "at the same time",
				}
			},
			j_leornd_unfairer_dice_alt = {
				name = "Unfairer dice",
				text = {
					"+{C:purple}#1# curse{}",
					"No listed {C:green,E:1,S:1.1}probability{}",
                    "will trigger",
                    "{C:inactive}(ex: {C:green}3 in 4{C:inactive} = {C:green}0 in 4{C:inactive})",
				},
				unlock = {
					"Have 3 {C:attention}Unfair dice{}",
                    "at the same time",
				}
			},
			j_leornd_grape_juice = {
				name = "Grape juice",
				text = {
					"Retrigger every {C:heart}heart{} card",
					"{C:attention}#1#{} times",
					"Increase retriggers by {C:attention}#2#{}",
					"at the end of ante",
					"Gains {C:money}$#3#{} of",
                    "{C:attention}sell value{} at",
                    "end of round",
				},
				unlock = {
					"Obtain a grape fruit card",
				}
			},
			j_leornd_fruity_joker = {
				name = "Fruity joker",
				text = {
					"Gives {C:chips}+#1#{} chips",
					"per fruit-themed card",
					"{C:inactive}(Currently {C:chips}+#2#{C:inactive} chips){}"
				},
				unlock = {
					"Discover half of all",
					"{E:1,V:1}Fruit{} cards"
				}
			},
			j_leornd_fruityful_joker = {
				name = "Fruityful joker",
				text = {
					"Gains {X:mult,C:white}X#1#{} mult",
					"when a {V:1}Fruit{} card is used",
					"Gain is increased for",
					"every {C:attention}fruit-themed{} card",
					"you have",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} mult){}"
				},
				unlock = {
					"Discover every",
					"{E:1,V:1}Fruit{} card"
				}
			},
			j_leornd_cursed_joker = {
				name = "Cursed joker",
				text = {
					"+{C:purple}#3# curse{}",
					"Gives {C:mult}+#1#{} mult",
					"for each {C:purple}curse{} level you have",
					"{C:inactive}(Currently {C:mult}+#2#{C:inactive} mult){}"
				},
				unlock = {
					"Win a run with {C:purple}curse{}",
					"level more than 20"
				}
			},
			j_leornd_purified_joker = {
				name = "Purified joker",
				text = {
					"{C:purple}-#3#{} curse at the start of blind",
					"Gains {X:mult,C:white}X#1#{} mult",
					"for each {C:purple}curse{} level",
					"you lost this way",
					"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} mult){}"
				},
				unlock = {
					"Win a run at least on",
					"{C:purple}Midnight{} stake",
					"without having any curses"
				}
			},
        },
		Fruit = {
			c_leornd_lemon = {
				name = "Lemon",
				text = {
					{
						"Add a {C:attention}sour{} sticker",
						"up to {C:attention}#1#{} cards",
						"in your hand",
					},
					{"{C:inactive}(#2# ante left){}"}
				}
			},
			c_leornd_apple = {
				name = "Apple",
				text = {
					{
						"Upgrades edition of {C:attention}1{} selected card",
						"{C:inactive}(ex: foil -> holographic){}",
					},
					{"{C:inactive}(#1# ante left){}"}
				}
			},
			c_leornd_orange = {
				name = "Orange",
				text = {
					{
						"Gives {C:money}$1{} for each",
						"fruit-themed card or joker",
						"{C:inactive}(currently {C:money}$#1#{C:inactive}){}",
					},
					{"{C:inactive}(#2# ante left){}"}
				}
			},
			c_leornd_peach = {
				name = "Peach",
				text = {
					{
						"Does nothing",
						"It's just tasty",
						"and rots faster"
					},
					{"{C:inactive}(#1# ante left){}"}
				}
			},
			c_leornd_pear = {
				name = "Pear",
				text = {
					{
						"{C:money}-$#1#{} when used",
						"Creates a random {V:1}#2#{} joker",
						"{C:inactive}(must have room){}"
					},
					{"{C:inactive}(#3# ante left){}"}
				}
			},
			c_leornd_coconut_alt = {
				name = "Coconut",
				text = {
					{
						"{C:dark_edition}+#1#{} consumable slots",
						"{C:red}Cannot appear twice in a run{}",
						"{C:inactive,s:0.7}(litterally, this is the last{}",
						"{C:inactive,s:0.7}time you see this coconut in",
						"{C:inactive,s:0.7}your run.){}"
					},
					{"{C:inactive}(#2# ante left){}"}
				}
			},
			c_leornd_coconut = {
				name = "Coconut",
				text = {
					{
						"{C:dark_edition}+#1#{} consumable slots",
						"{C:red}Cannot appear twice in a run{}"
					},
					{"{C:inactive}(#2# ante left){}"}
				}
			},
			c_leornd_cracked_coconut = {
				name = "Cracked coconut",
				text = {
					{
						"Slows fruit rotting",
						"{C:inactive}({C:attention}#1#X{C:inactive} slower){}",
					},
					{"{C:inactive}(#2# ante left){}"}
				}
			},
			c_leornd_cherry = {
				name = "Cherry",
				text = {
					{
						"Gives {C:money}$1{} for each",
						"{C:hearts}heart{} card",
						"in your deck",
						"{C:inactive}(Currently +{C:money}$#1#{C:inactive}){}"
					},
					{"{C:inactive}(#2# ante left){}"}
				}
			},
			c_leornd_watermelon = {
				name = "Watermelon",
				text = {
					{
						"Creates a random",
						"{E:1,V:1}fruit-{}themed joker",
						"{C:inactive}(must have room){}"
					},
					{"{C:inactive}(#1# ante left){}"}
				}
			},
			c_leornd_grape = {
				name = "Grape",
				text = {
					{
						"When grape rots, it becomes grape juice",
						"{C:inactive}(rots {C:attention}#1#X{C:inactive} slower){}",
					},
					{"{C:inactive}(#2# ante left){}"}
				}
			},
			c_leornd_golden_apple = {
				name = "Golden apple",
				text = {
					{
						"Apply {C:money}gold{} to",
						"all cards in your hand",
					},
					{"Doesn't rot"}
				}
			}
		},
		Blind = {
			bl_leornd_othala = {
				name = "The Othala",
				text = {
					"Discarded cards gain",
					"possessed sticker"
				}
			},
			bl_leornd_cursed_small = {
				name = "Small blind",
			},
			bl_leornd_cursed_big = {
				name = "Big blind",
			},
		},
		Stake = {
			stake_leornd_midnight = {
				name = "Midnight Stake",
				text={
                    "Shop can have {C:purple}Cursed{} Jokers",
                    "{C:inactive,s:0.8}(having too much curse will make game harder)",
                    "{s:0.8}Applies all previous Stakes",
                },
			}
		},
		Other = {
			leornd_sour = {
				name = "Sour",
				text = {
					"{X:attention,C:white}X#1#{} of blind size",
					"when scored.",
					"{C:chips}#2#{} chips when scored"
				}
			},
			leornd_possessed = {
				name = "Possessed",
				text = {
					"{X:mult,C:white}X#1#{} mult when scored",
					"{C:green,E:1}#2# to #3#{} chance to return",
					"into hand when discarded",
				}
			},
			leornd_cursed = {
				name = "Cursed",
				text = {
					"+{C:purple}#1# curse{} when",
					"added to deck",
				}
			},
		}
    },
	misc = {
		dictionary = {
			k_broken_ex = "Broken!",
			k_rotten_ex = "Rotten!",
			k_returned_ex = "Returned!",
			k_possess_ex = "Possessed!",
			k_nosoul_ex = "No soul!",
			k_fruit = "Fruit",
			k_curse = "Curse",
			b_fruit_cards = "Fruit cards"
		},
		challenge_names = {
			c_leornd_pact = "Devil's pact"
		},
		v_text = {
			ch_c_leornd_pact = {
				"Start with Brimstone Mult equal {X:dark_edition,C:white}^"..LeoRND.config.ch_pact_debuff.."{}",
			},
			ch_m_curses={
				"{C:purple}#1#{} Curse",
			},
		},
		labels = {
			leornd_sour = "Sour",
			leornd_possessed = "Possessed",
			leornd_cursed = "Cursed",
		}
	}
}