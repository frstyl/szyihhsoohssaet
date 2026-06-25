local cardSkill = fk.CreateSkill {
  name = "hsoo_piuc_hsvoans_quoh_skill",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt = "#hsoo_piuc_hsvoans_quoh_skill",
  mod_target_filter = Util.TrueFunc,
  can_use = function(self, player, card, extra_data)
    return Util.CanUseToSelf
    and S.magicCanUse(player, card)
  end,
  on_use = function (self, room, cardUseEvent)
    S.magicOnUse(cardUseEvent.from, cardUseEvent)
  end,
  on_effect = function(self, room, effect)
    local to = effect.to
    to:drawCards(2,cardSkill.name)
  end,
  on_nullified = function(self, room, effect)
    room:moveCards{
      ids = room:getSubcardsByRule(effect.card, { Card.Processing }),
      toArea = Card.DiscardPile,
      moveReason = fk.ReasonUse,
    }
  end,
})

cardSkill:addAI(nil, "__card_skill")

return cardSkill
