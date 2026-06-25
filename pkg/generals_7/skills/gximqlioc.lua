local gximqlioc = fk.CreateSkill{
  name = "gximqlioc",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
["gximqlioc"] = "擒龍",
[":gximqlioc"] = "恆續鎖定.若伱有空武器欄,伱使用殺无視次數且可額外指定1目幖",--无次數限制?


["$gximqlioc"] = "論拳腳功夫,某是不會輸之",
["$gximqlioc2"] = "昰可是某祖傳之手藝",
}


gximqlioc:addEffect(fk.CardUsing, {
  can_refresh = function(self, event, target, player, data)
    return target == player and player:hasSkill(gximqlioc.name) and
      data.card.trueName == "ssaet" and  player:hasEmptyEquipSlot(Card.SubtypeWeapon)
  end,
  on_refresh = function(self, event, target, player, data)
    player:broadcastSkillInvoke("gximqlioc")
    player.room:doAnimate("InvokeSkill", {
      name = "gximqlioc",
      player = player.id,
      skill_type = gximqlioc.name,
    })
  end,
})



gximqlioc:addEffect("targetmod", {
  extra_target_func = function(self, player, skill, card)
    if player:hasSkill(gximqlioc.name) and card and card.trueName =="ssaet" and  player:hasEmptyEquipSlot(Card.SubtypeWeapon) then
      return 1
    end
  end,
  bypass_times = function(self, player, skill, scope, card)
    return player:hasSkill(gximqlioc.name) and card and card.trueName =="ssaet" and  player:hasEmptyEquipSlot(Card.SubtypeWeapon) 
  end,
})




gximqlioc:addEffect(fk.PreCardUse, {
  can_refresh = function (self, event, target, player, data)
    return target == player and
      player:hasSkill(gximqlioc.name) and card and card.trueName =="ssaet" and  player:hasEmptyEquipSlot(Card.SubtypeWeapon) 
  end,
  on_refresh = function (self, event, target, player, data)
    data.extraUse = true
  end
})

return gximqlioc
