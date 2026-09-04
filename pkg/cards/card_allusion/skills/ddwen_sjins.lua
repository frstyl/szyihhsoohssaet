local cardSkill = fk.CreateSkill {
  name = "ddwen_kaah_sjins_skill",
}
-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt = "#tvoans_liac_dzyet_quan_skill",
  target_num = 0,
  mod_target_filter = Util.FalseFunc,
  target_filter = Util.FalseFunc,
  offset_func= Util.FalseFunc,
  on_use = function (self, room, cardUseEvent)
    cardUseEvent.toCard=cardUseEvent.card
  end,
  on_effect = function(self, room, effect)
    local cards= table.filter(room.void, function(id) return Fk:getCardById(id).trueName=="deep" end)
    if #cards==0 then return  end
    local card= room:tableRandomPick(cards,1)
    room:moveCardTo(card, Card.DrawPile, nil, fk.ReasonJustMove, cardSkill.name)
  end,
})


return cardSkill
