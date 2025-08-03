return {
    descriptions = {
        Joker = {
            j_leornd_brimstone = {
                name = "Сера",
                text = {
		        	"Получает {X:dark_edition,C:white}^#2#{} множ.",
		        	"при победе над",
		        	"босс-блайндом",
		        	"{C:inactive}(сейчас: {X:dark_edition,C:white}^#1#{}{C:inactive} множ.)"
		        },
				unlock = {
					"Завершите #1# забегов",
					"{C:inactive}(#2#){}"
				}
            },
            j_leornd_tboi_glass = {
                name = '20/20',
		        text = {
                    "Можете взять {C:attention}#1#{} доп.",
		        	"карту в {C:attention}бустер-паках{}",
		        	"{X:chips,C:white}X#2#{} фишек",
		        	"{X:mult,C:white}X#3#{} множ.",
		        	"Шанс {C:green}#4# к #5#{} что этот",
		        	"джокер сломается",
		        	"в конце раунда"
		        }
            },
            j_leornd_sour_glass = {
                name = '30/30-150',
		        text = {
                    "Можете взять {C:attention}#1#{} доп.",
                    "карту в {C:attention}бустер-паках{}",
                    "{X:chips,C:white}X#2#{} фишек",
                    "Шанс {C:green}#3# к #4#{} что этот",
                    "джокер сломается",
                    "в конце раунда"
		        },
				unlock = {
					"Превратите половину вашей колоды",
                    "в {C:attention}стеклянные{} карты",
				}
            },
            j_leornd_a_grade = {
                name = 'Анархия',
		        text = {
                    "{C:inactive,s:0.85}— мать порядка{}",
		        	"Получает {C:mult}+#1#{} множ.",
		        	"когда итоговый счёт превышает",
		        	"{C:attention}#3#x{} размер блайнда.",
		        	"Порог увеличивается с каждым анте",
		        	"{C:inactive}(сейчас: множ. {C:mult}+#2#{C:inactive}){}"
		        }
            },
			j_leornd_pan = {
				name = "Сковородка",
				text = {
					"Шанс {C:green}#2# к #3#{}",
					"на {X:dark_edition,C:white}^#1#{} множ.",
					"Шанс увеличивается на {C:attention}#4#{}",
					"с каждой рукой.",
					"Шанс сбрасывается когда выдаётся множ.",
					"{C:inactive,s:0.85}Случайные криты честные и сбалансированые{}"
				}
			},
			j_leornd_abszero = {
				name = "Абсолютный ноль",
				text = {
					"{C:inactive,s:0.85}(Absolute zero){}",
					"Даёт",
					"{C:mult}+#1#{} множ.",
					"если сыграть {C:attention}сет{}",
					"с 1 неразыгранной картой",
					"{C:inactive,s:0.85}\"Man\" is a four-letter word{}"
				}
			},
			j_leornd_placeholder = {
				name = "placeholder",
				text = {
					"Перезапуск всех",
					"не {C:legendary}легендарных{} джокеров",
				}
			},
			j_leornd_tree = {
				name = "Дерево",
				text = {
					"Создаёт случайную {C:attention}фруктовую{} карту",
					"в начале каждого анте",
					"{C:inactive}(должно быть место){}"
				},
				unlock = {
					"Получите карту с {C:attention}кислым{} стикером"
				}
			},
			j_leornd_sour = {
				name = "Кислый камень",
				text = {
					"{C:inactive,s:0.85}(Stone sour){}",
					"Накладывает на каждую разыгранную каменную карту",
					"{C:attention}кислый{} стикер",
				},
				unlock = {
					"Сыграйте руку из 5 карт,",
                    "которая содержит только",
                    "каменные карты {C:enhanced,E:1}улучшенного{} выпуска",
					"{C:inactive}(напр.: 1 полихромный камень + 4 фойловых камня)"
				}
			},
			j_leornd_dice = {
				name = "Нечестная кость",
				text = {
					"Уменьшает все {C:attention}перечисленные",
                    "{C:green,E:1,S:1.1}вероятности в {C:attention}2{} раза",
                    "{C:inactive}(напр.: {C:green}2 из 3{C:inactive} -> {C:green}1 из 3{C:inactive})",
				},
				unlock = {
					"Имейте одновременно 2",
					"{C:attention}Упс! Все шестёрки{}",
				}
			},
        },
		Fruit = {
			c_leornd_lemon = {
				name = "Лимон",
				text = {
					"Добавляет {C:attention}кислый{} стикер",
					"до {C:attention}#1#{} выбранных карт",
					"в вашей руке"
				}
			},
			c_leornd_apple = {
				name = "Яблоко",
				text = {
					"Улучшает выпуск {C:attention}1{} выбранной карты",
					"{C:inactive}(напр.: фойловый -> голографический){}"
				}
			},
			c_leornd_orange = {
				name = "Апельсин",
				text = {
					"Даёт {C:money}1${} за каждую",
					"фруктовую карту или джокера",
					"{C:inactive}(сейчас: {C:money}#1#${C:inactive}){}",
					"{C:inactive,s:0.7}Вы не Александр.{}",
					"{C:inactive,s:0.5}Это отсылка на отсылку{}"
				}
			}
		},
		Blind = {
			bl_leornd_othala = {
				name = "Одал",
				text = {
					"Сброшенные карты получают",
					"стикер одержимости"
				}
			}
		},
		Other = {
			leornd_sour = {
				name = "Кислый",
				text = {
					"Уменьшает размер блайнда на {X:attention,C:white}X"..LeoRND.config.sour_sticker_reduce.."{}",
					"от текущего размера блайнда",
					"когда разыграна.",
					"{C:chips}"..LeoRND.config.sour_sticker_chips.."{} фишек когда разыграна"
				}
			},
			leornd_possessed = {
				name = "Одержимый",
				text = {
					"{X:mult,C:white}X"..LeoRND.config.possessed_mult_mod.."{} множ.",
					"Уничтожается при сбросе",
				}
			},
		}
    },
	misc = {
		dictionary = {
			k_broken = "Сломано!",
			k_fruit = "Фрукт",
			b_fruit_cards = "Фрукты"
		},
		labels = {
			leornd_sour = "Кислая",
			leornd_possessed = "Одержимая",
		}
	}
}