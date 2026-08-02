local skill = fk.CreateSkill {
  name = "khxes_kheet_sis_tssaas_skill",
}
-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

skill:addEffect("cardskill", {
  prompt = "#khxes_kheet_sis_tssaas_skill",
  mod_target_filter = function(self, player, to_select, selected, card, distance_limited)
    return to_select ~= player
  end,
  target_filter = Util.CardTargetFilter,
  target_num = 1,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    local to = effect.to
    local judge = {
      who = to,
      reason = "khxes_kheet_sis_tssaas",
      pattern = ".|.|spade,club,diamond",
    }
    room:judge(judge)
    if judge:matchPattern() then
      to:skip(Player.Play)
      -- S.skipPhase(to.id , Player.Play)
    end
    self:onNullified(room, effect)
  end,
  on_nullified = function(self, room, effect)
    room:moveCards{
      ids = room:getSubcardsByRule(effect.card, { Card.Processing }),
      toArea = Card.DiscardPile,
      moveReason = fk.ReasonUse,
    }
  end,
})

skill:addAI(nil, "__card_skill")

return skill
