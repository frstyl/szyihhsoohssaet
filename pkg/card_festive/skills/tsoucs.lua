local cardSkill = fk.CreateSkill {
  name = "tsoucs_skill",
}

cardSkill:addEffect("cardskill", {
  prompt = "#tsoucs_skill",
  -- mod_target_filter = function(self, player, to_select)
  --   return to_select:getMark("tsoucs")==0
  -- end,
  max_round_use_time=1,
  can_use = function(self, player, card, extra_data)  --无視次數?
    return Util.CanUseToSelf(self, player, card, extra_data) and
      (extra_data and (extra_data.bypass_times ) or
      self:withinTimesLimit(player, Player.HistoryRound, card, "tsoucs", player))
  end,
  mod_target_filter = Util.TrueFunc,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    room:addPlayerMark(effect.to,"tsoucs",1)
    room:changeMaxHp(effect.to, 1)
    if effect.to:isWounded() and not effect.to.dead then
      room:recover{
        who = effect.to,
        num = 1,
        card = effect.card,
        recoverBy = effect.from,
        skillName = cardSkill.name,
        event_data= effect,
      }
    end
      room:handleAddLoseSkills(effect.to, "ljeqsoav", nil, false, false)
  end,
})

return cardSkill
