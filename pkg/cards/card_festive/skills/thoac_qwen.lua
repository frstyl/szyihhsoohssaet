local cardSkill = fk.CreateSkill {
  name = "biu_qwen_tsih_skill",
}

Fk:loadTranslationTable{
  ["#MoveSeatTo"] = "%from 迻至 %to %arg",
  ["TheLast"] = "上家",
  ["TheNext"] = "下家",
}
cardSkill:addEffect("cardskill", {
  prompt = "#biu_qwen_tsih_skill",
  max_round_use_time=1,
  -- can_use = function(self, player, card, extra_data)  --无視次數?
  --   if player:prohibitUse(card) then return end
  --   return true
  --   return (extra_data and extra_data.bypass_times) 
  --     or
  --     table.find(Fk:currentRoom().alive_players,
  --       -- extra_data and extra_data.fix_targets and   table.map(extra_data.fix_targets,Util.Id2PlayerMapper ) or {player},
  --      function(p)
  --       return  self:withinTimesLimit(player, Player.HistoryRound, card, "biu_qwen_tsih", p)
  --     end)
  -- end,
  mod_target_filter = function(self, player, to_select)
    return to_select~=player
  end,
  target_num = 1,
  target_filter = function(self, player, to_select, selected, _, card, extra_data)
    if  not  Util.CardTargetFilter(self, player, to_select, selected, _, card, extra_data) then return end
    return #selected~=0 
     or
      (extra_data and extra_data.bypass_times ) 
        or self:withinTimesLimit(player, Player.HistoryRound, card, "biu_qwen_tsih",to_select)
  end,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    local yes=(math.random(0,1)==1)
    room:sendLog{
    type = "#MoveSeatTo",
    from = effect.from.id,
    to = {effect.to.id},
    arg = yes and "TheLast" or "TheNext" ,
  }
    room:moveSeatToNext(effect.from,effect.to,yes,false)
  end,
})

return cardSkill
