local cardSkill = fk.CreateSkill {
  name = "tshoak_hsvoah_tsjek_sjin_skill",
}

Fk:loadTranslationTable{ 
  ["#tshoak_hsvoah_tsjek_sjin_skill"] = "厝火積薪 所受火傷+1" ,
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt = "#tshoak_hsvoah_tsjek_sjin_skill",
  can_use = Util.CanUse,
  target_num = 1,
  mod_target_filter = function(self, player, to_select, selected, card, distance_limited)
    return to_select ~= player
  end,
  target_filter = function(self, player, to_select, selected, _, card, extra_data)
    return S.delayTargetFilter(self, player, to_select, selected, _, card, extra_data)
  end,
  offset_func= Util.FalseFunc,
  on_use = function (self, room, cardUseEvent)
    room:addSkill("tshoak_hsvoah_tsjek_sjin_check")
  end,
  on_effect = function(self, room, effect)
    if  effect.extra_data and effect.extra_data.tshoak_hsvoah_tsjek_sjin then 
      S.changeDamage({damageData=effect.extra_data.tshoak_hsvoah_tsjek_sjin, skillName="tshoak_hsvoah_tsjek_sjin", num=1})
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

