local leecqpheec = fk.CreateSkill {
  name = "leecqpheec",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["leecqpheec"] = "竛竮",
  [":leecqpheec"] = "法則.伱初始手牌數爲16.廢除(始終越過)伱{補段 伏段 弃段}.",

  ["$leecqpheec1"] = "曲有误，不可不顾。",
  ["$leecqpheec2"] = "兀音曳绕梁，愿君去芜存菁。",
}


leecqpheec:addEffect(fk.DrawInitialCards, {
  can_refresh = function (self, event, target, player, data)
    return target==player and player:hasSkill(leecqpheec.name,true,true)
  end,
  on_refresh = function (self, event, target, player, data)
    player.room:setPlayerMark(player, "leecqpheec", 1)
    data.num = 16
  end,
})

leecqpheec:addEffect(fk.EventPhaseChanging, {
  can_refresh = function (self, event, target, player, data)
    return --target==player and player:hasSkill(leecqpheec.name)
    target==player and player:getMark("leecqpheec")~=0
    and table.contains({Player.Judge, Player.Discard, Player.Draw,}, data.phase)
  end,
  on_refresh = function (self, event, target, player, data)
    data.skipped=true
  end,
})

return leecqpheec
