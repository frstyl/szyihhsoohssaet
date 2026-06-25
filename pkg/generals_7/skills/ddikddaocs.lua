local ddikddaocs = fk.CreateSkill {
  name = "ddikddaocs",
  tags = { Skill.Compulsory },
}
Fk:loadTranslationTable{
  ["ddikddaocs"] = "直撞",
  [":ddikddaocs"] = "鎖定.➀恆續,伱攻程+2.➁若伱攻程內其它存活角色數不大于2,伱使用殺指定目幖後,目幖抵消所需｢閃｣數+1",

  -- ["#ddikddaocs-choose"] = "直撞 選擇額外目幖",

  ["$ddikddaocs1"] = "匹夫受死",
  ["$ddikddaocs2"] = "董一撞在此",
}


ddikddaocs:addEffect(fk.TargetSpecified, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(ddikddaocs.name) and
      table.contains({ "ssaet"}, data.card.trueName)
      and #table.filter(player.room:getOtherPlayers(player), function (p)
        return player:inMyAttackRange(p) 
      end) <3
  end,
  on_trigger = function(self, event, target, player, data)
    data:setResponseTimes(data:getResponseTimes(to)+1, data.to)  --1?
  end,
})

ddikddaocs:addEffect("atkrange", {
  correct_func = function(self, from, to)
    if from:hasSkill(ddikddaocs.name) then
      return 2
    end
  end,
})
ddikddaocs:addEffect("targetmod", {
  extra_target_func = function(self, player, skill, card)
    if card and card.trueName=="ssaet"  
      and  player:hasSkill(ddikddaocs.name)
    then
      return 1
    end
  end,
})

return ddikddaocs
