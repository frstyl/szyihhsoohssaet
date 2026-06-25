local cardSkill = fk.CreateSkill {
  name = "tshoak_hsvoah_tsjek_sjin_skill",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{ 
  ["#tshoak_hsvoah_tsjek_sjin_skill"] = "厝火積薪 所受火傷+1" ,
}

cardSkill:addEffect("cardskill", {
  prompt = "#tshoak_hsvoah_tsjek_sjin_skill",
  can_use = Util.CanUse,
  mod_target_filter = Util.TrueFunc,
  target_filter = Util.CardTargetFilter,
  target_num = 1,
  offset_func= Util.FalseFunc,
  on_use = function (self, room, cardUseEvent)
    room:addSkill("tshoak_hsvoah_tsjek_sjin_check")
  end,
  on_effect = function(self, room, effect)
    if  effect.responseToEvent then 
      -- room:sendLog{ type = "#changeDamageBySkill", from = effect.to.id, arg = "tshoak_hsvoah_tsjek_sjin" ,arg2=1}
      -- effect.responseToEvent:changeDamage(1)
      S.changeDamage({damageData=effect.responseToEvent,skillName="tshoak_hsvoah_tsjek_sjin",num=1})
      self:onNullified(room, effect)
    else
      room:moveCards{
        ids = room:getSubcardsByRule(effect.card, { Card.Processing }),
        toArea = Card.DiscardPile,
        moveReason = fk.ReasonPut,
      }
    end


    

  end,
  on_nullified = function(self, room, effect)
    -- room:moveCards{
    --   ids = room:getSubcardsByRule(effect.card, { Card.Processing }),
    --   toArea = Card.DiscardPile,
    --   moveReason = fk.ReasonUse,
    -- }
    
    if effect.card:isVirtual() then
      effect.to:addVirtualEquip(effect.card)
    end
    room:moveCards{
      ids = room:getSubcardsByRule(effect.card, { Card.Processing }),
      to = effect.to,
      toArea = Card.PlayerJudge,
      moveReason = fk.ReasonPut,
    }
  end,
})

return cardSkill

