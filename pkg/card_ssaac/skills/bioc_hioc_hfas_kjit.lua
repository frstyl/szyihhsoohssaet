local skill = fk.CreateSkill {
  name = "bioc_hsioc_hsfas_kjit_skill",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

skill:addEffect("cardskill", {
  prompt = "#bioc_hsioc_hsfas_kjit_skill",
  can_use = function(self, player, card, extra_data)
    return  Util.GlobalCanUse(self, player, card, extra_data) 
    and S.magicCanUse(player, card)
  end,  
  on_use = function (self, room, cardUseEvent)
    S.magicOnUse(cardUseEvent.from, cardUseEvent)
    Util.AoeCardOnUse(self, cardUseEvent.from, cardUseEvent, true)
  end,
  mod_target_filter = Util.TrueFunc,
  offset_func= Util.FalseFunc,
  about_to_effect = function(self, room, effect)
    if not effect.to:isWounded() then
      return true
    end
  end,
  on_effect = function(self, room, effect)
    if (not effect.to:isWounded())  or effect.to.dead then  return end
    -- effect.to:drawCards(math.min(effect.to:getLostHp(),3), skill.name)
      effect.to:drawCards(effect.to:getLostHp(), skill.name)
  end,
})


return skill

