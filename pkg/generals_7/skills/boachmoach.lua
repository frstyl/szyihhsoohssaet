local boachmoach = fk.CreateSkill {
  name = "boachmoach",
  tags = { Skill.Compulsory },
}
Fk:loadTranslationTable{
  ["boachmoach"] = "並蟒",
  [":boachmoach"] = "鎖定.➀恆續,伱攻程+2.➁若伱攻程內其它存活脚色數不大于2,伱使用殺指定目幖後,目幖抵消所需｢閃｣數+1",

  -- ["#boachmoach-choose"] = "並蟒 選擇額外目幖",

  ["$boachmoach1"] = "匹夫受死",
  ["$boachmoach2"] = "董一撞在此",
}


boachmoach:addEffect(fk.TargetSpecified, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(boachmoach.name) and
      table.contains({ "ssaet"}, data.card.trueName)
      and #table.filter(player.room:getOtherPlayers(player), function (p)
        return player:inMyAttackRange(p) 
      end) <3
  end,
  on_trigger = function(self, event, target, player, data)
    data:setResponseTimes(data:getResponseTimes(to)+1, data.to)  --1?
  end,
})

boachmoach:addEffect("atkrange", {
  correct_func = function(self, from, to)
    if from:hasSkill(boachmoach.name) then
      return 2
    end
  end,
})
boachmoach:addEffect("targetmod", {
  extra_target_func = function(self, player, skill, card)
    if card and card.trueName=="ssaet"  
      and  player:hasSkill(boachmoach.name)
    then
      return 1
    end
  end,
})

return boachmoach
