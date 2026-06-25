local cardSkill = fk.CreateSkill {
  name = "jje_seec_jjek_sius_skill",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt = "#jje_seec_jjek_sius_ssaet",
  max_turn_use_time = 1,
  can_use = function(self, player, card, extra_data)
    return not player:prohibitUse(card) 
    and S.magicCanUse(player, card)
  end,  
  on_use = function (self, room, cardUseEvent)
    S.magicOnUse(cardUseEvent.from, cardUseEvent)
  end,
  target_num = 1,
  mod_target_filter = function(self, player, to_select, selected, card)
    return to_select ~= player
  end,
  target_filter = Util.CardTargetFilter,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    local from = effect.from
    local to = effect.to
    if to.dead or from.dead then return end

    local max = math.max(1, math.min(from:getLostHp(),to.hp-1 ) )

    local num = math.random(1, max)

      room:changeHp(to, -num,nil,cardSkill.name,nil)
      if  to.dead then return end
      room:changeHp(from, num,nil, cardSkill.name,nil)

  end,
})

return cardSkill
