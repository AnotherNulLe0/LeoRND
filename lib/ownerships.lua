-- Soul cannot appear when a "demonic" item obtained
SMODS.Consumable:take_ownership("soul",
    {
        no_pool_flag = "leornd_pacted",
        calculate = function (self, card, context)
            if (context.buying_card or context.card_added) and G.GAME.pool_flags.leornd_pacted then
                local func = function() 
                    G.E_MANAGER:add_event(Event({
                        func = LeoRND.utils.event_destroy_card(card)
                    }))
                    return true
                end
                return {
					message = localize("k_sold_ex"),
                    func = func
				}
            end
        end
    },
    true
)