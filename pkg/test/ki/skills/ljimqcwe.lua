local ljimqcwe = fk.CreateSkill {
  name = "ljimqcwe",
}

Fk:loadTranslationTable{
  ["ljimqcwe"] = "臨危",
  [":ljimqcwe"] = "伱轉外,脚色死亾後,伱可發動｡伱中止結算至當前轉,伱執行1額外轉",--其它脚色轉內 /輪始旹/遊戲始旹

  ["#ljimqcwe-invoke"] = "臨危：是否執行額外轉？",
}

ljimqcwe:addEffect(fk.Deathed, {  --Death不弃牌
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(ljimqcwe.name) and target.rest < 1
    and player.phase == Player.NotActive 
    --and player.room.logic:getCurrentEvent():findParent(GameEvent.Turn) ~= nil
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = ljimqcwe.name,
      prompt = "#ljimqcwe-invoke",
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room.logic:breakTurn()
    player:gainAnExtraTurn(false, ljimqcwe.name)
  end,
})



return ljimqcwe
