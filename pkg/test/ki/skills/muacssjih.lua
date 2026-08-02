local buoqcwe = fk.CreateSkill {
  name = "buoqcwe",
}

Fk:loadTranslationTable{
  ["buoqcwe"] = "扶危",--扶危
  [":buoqcwe"] = "輪限1｡伱轉外,一脚色瀕死求救後,伱可發動｡伱中止結算至當前轉,伱執行1額外轉",--其它脚色轉內 /輪始旹/遊戲始旹

  ["#buoqcwe-invoke"] = "扶危：是否執行額外轉？",
}

buoqcwe:addEffect(fk.AskForPeachesDone, {  --Death不弃牌
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(buoqcwe.name,true,true) and target.rest < 1
    and player.phase == Player.NotActive 
    and player:usedEffectTimes(buoqcwe.name, Player.HistoryRound) == 0
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = buoqcwe.name,
      prompt = "#buoqcwe-invoke",
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room.logic:breakTurn()
    player:gainAnExtraTurn(false, buoqcwe.name)
  end,
})



return buoqcwe
