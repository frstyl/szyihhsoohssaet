local leecqpheec = fk.CreateSkill {
  name = "leecqpheec",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["leecqpheec"] = "竛竮",
  [":leecqpheec"] = "伱分發初始手牌前,必發,初始手牌數改爲16,伱當局越過伱{補段/伏段/撤段}.",  --改爲迻除

  ["$leecqpheec1"] = "曲有误，不可不顾。",
}


leecqpheec:addEffect(fk.DrawInitialCards, {
  can_trigger = function (self, event, target, player, data)  --refresh
    return target==player and player:hasSkill(leecqpheec.name,true)
  end,
  on_use = function (self, event, target, player, data)
    player.room:setPlayerMark(player, "leecqpheec", 1)
    data.num = 16
  end,
})

leecqpheec:addEffect(fk.EventPhaseChanging, {
  can_trigger = function (self, event, target, player, data)
    return --target==player and player:hasSkill(leecqpheec.name)
    target==player and player:getMark("leecqpheec")~=0
    and table.contains({Player.Judge, Player.Discard, Player.Draw,}, data.phase)
  end,
  on_trigger = function (self, event, target, player, data)
    data.skipped=true
  end,
})

return leecqpheec
