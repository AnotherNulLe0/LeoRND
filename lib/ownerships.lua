-- Soul cannot appear when a "demonic" item obtained
SMODS.Consumable:take_ownership("soul",
    {
        no_pool_flag = "leornd_pacted",
        add_to_deck = function (self, card, from_debuff)
            if G.GAME.pool_flags.leornd_pacted then
                G.E_MANAGER:add_event(Event({
                    func = LeoRND.utils.event_destroy_card(card)
                }))
            end
        end,
        calculate = function (self, card, context)
            if (context.buying_card or context.card_added) and G.GAME.pool_flags.leornd_pacted then
                local func = function() 
                    G.E_MANAGER:add_event(Event({
                        func = LeoRND.utils.event_destroy_card(card)
                    }))
                    return true
                end
                return {
	            	message = localize("k_nosoul_ex"),
                    func = func
	            }
            end
        end
    },
    true
)
if next(SMODS.find_mod("Cryptid")) then
    SMODS.Stake:take_ownership("cry_pink",
        {
            applied_stakes = { "leornd_midnight" },
        },
        true
    )
end