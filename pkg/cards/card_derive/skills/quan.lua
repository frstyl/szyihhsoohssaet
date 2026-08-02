local cardSKill = fk.CreateSkill {
  name = "quan_skill",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSKill:addEffect("cardskill", {
  prompt = "#quan_skill",
  mod_target_filter = Util.TrueFunc,
  -- can_use = Util.CanUseToSelf,
  target_num=1,
  target_filter = function(self, player, to_select, selected, _, card, extra_data)
    return S.useToSelfFilter(self, player, to_select, selected, _, card, extra_data)
  end,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    if effect.to.dead then return end
    local n=player.maxHp-player:getHandcardNum()
    if n>0 then
      effect.to:drawCards(n, cardSKill.name)
    end
  end,
})

return cardSKill
