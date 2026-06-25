local cardSkill = fk.CreateSkill {
  name = "thoac_qwen_skill",
}

Fk:loadTranslationTable{
  ["#MoveSeatTo"] = "%from 迻至 %to %arg",
  ["TheLast"] = "上家",
  ["TheNext"] = "下家",
}
cardSkill:addEffect("cardskill", {
  prompt = "#thoac_qwen_skill",
  max_round_use_time=1,
  can_use = function(self, player, card, extra_data)  --无視次數?
    if player:prohibitUse(card) then return end
    return (extra_data and extra_data.bypass_times) 
    or
        self:withinTimesLimit(player, Player.HistoryRound, card, "thoac_qwen", to_select)
  end,
  target_num = 1,
  mod_target_filter = function(self, player, to_select)
    return to_select~=player
  end,
  target_filter = Util.CardTargetFilter,
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
