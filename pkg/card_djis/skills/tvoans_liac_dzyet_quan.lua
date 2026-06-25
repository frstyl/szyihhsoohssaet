local skill = fk.CreateSkill {
  name = "tvoans_liac_dzyet_quan_skill",
}
-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

skill:addEffect("cardskill", {
  prompt = "#tvoans_liac_dzyet_quan_skill",
  distance_limit = 1,
  mod_target_filter = function(self, player, to_select, selected, card, extra_data)
    return to_select ~= player and not (not (extra_data and extra_data.bypass_distances) and
      not self:withinDistanceLimit(player, false, card, to_select))
  end,
  target_filter = Util.CardTargetFilter,
  target_num = 1,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    local to = effect.to
    local judge = {
      who = to,
      reason = "tvoans_liac_dzyet_quan",
      pattern = ".|.|spade,heart,diamond",
    }
    room:judge(judge)
    if judge:matchPattern() then
      --
      local discardNum = #table.filter(
        to:getCardIds(Player.Hand), function(id)
          local card = Fk:getCardById(id)
          return table.every(room.status_skills[MaxCardsSkill] or Util.DummyTable, function(skill)
            return not skill:excludeFrom(to, card)
          end)
        end
      ) - to:getMaxCards()
      room:broadcastProperty(to, "MaxCards")
      if discardNum > 0 then
        room:askToDiscard(to, {min_num = discardNum, max_num = discardNum, include_equip = false, skill_name = "phase_discard", cancelable = false})
      end
      to:skip(Player.Draw)
      -- S.skipPhase(to.id , Player.Draw)
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
