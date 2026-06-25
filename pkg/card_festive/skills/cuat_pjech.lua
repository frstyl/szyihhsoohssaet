local cardSkill = fk.CreateSkill {
  name = "cuat_pjech_skill",
}

cardSkill:addEffect("cardskill", {
  prompt = "#cuat_pjech_skill",
  max_round_use_time=1,
  can_use = function(self, player, card, extra_data)  --无視次數?
    return Util.CanUseToSelf(self, player, card, extra_data) and
      (extra_data and (extra_data.bypass_times ) or
      self:withinTimesLimit(player, Player.HistoryRound, card, "cuat_pjech", player))
  end,
  -- mod_target_filter = function(self, player, to_select)
  --   return to_select:getMark("cuat_pjech")==0
  -- end,
  mod_target_filter = Util.TrueFunc,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    room:addPlayerMark(effect.to,"cuat_pjech",1)
    room:handleAddLoseSkills(effect.to, "&hqjevqcuat", nil, false, false)
  end,
})

return cardSkill
