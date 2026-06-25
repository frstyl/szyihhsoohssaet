local skill = fk.CreateSkill {
  name = "free__meej_skill",
}



skill:addEffect("cardskill", {
  prompt ="#meej_skill",
  -- max_phase_use_time = 1,
  -- target_num = 1,
  -- can_use = function(self, player, card, extra_data)
  --   if player:prohibitUse(card) then return end
    -- return (extra_data and extra_data.bypass_times) or player.phase ~= Player.Play or
    --   table.find(Fk:currentRoom().alive_players, function(p)
    --     return self:withinTimesLimit(player, Player.HistoryPhase, card, "meej", p)
    --   end)
  -- end,
  -- mod_target_filter = function(self, player, to_select, selected, card, extra_data)
  --   return to_select == player and
  --     not (not (extra_data and extra_data.bypass_distances) and not self:withinDistanceLimit(player, true, card, to_select))
  -- end,
  -- target_filter = function(self, player, to_select, selected, _, card, extra_data)
  --   if not Util.CardTargetFilter(self, player, to_select, selected, _, card, extra_data) then return end
  --   return self:modTargetFilter(player, to_select, selected, card, extra_data) and
  --     (
  --       #selected > 0 or
  --       player.phase ~= Player.Play or
  --       (extra_data and extra_data.bypass_times) or
  --       self:withinTimesLimit(player, Player.HistoryPhase, card, "meej", to_select)
  --     )
  -- end,
  -- can_use = Util.TrueFunc, -- ?CanUseToSelf
  -- mod_target_filter =  Util.TrueFunc,

  -- can_use = Util.CanUse,
  mod_target_filter = Util.TrueFunc,
  target_filter = Util.CardTargetFilter,
  target_num = 1,

  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    if  effect.to.dead then return end
    room:addSkill("meej_delay")
    room:setPlayerMark(effect.to,"@@meej-turn",1)
    -- room:broadcastProperty(to, "meej")
  end,
})

return skill
