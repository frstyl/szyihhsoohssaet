local ttxisquanh = fk.CreateSkill {
  name = "ttxisquanh",
}
Fk:loadTranslationTable{
  ["ttxisquanh"] = "致遠",
  [":ttxisquanh"] = "伱受傷後發動.伱抽x(x爲伱攻程)",

  ["#ttxisquanh-invoke"] = "致遠 抽%arg",

  ["$ttxisquanh1"] = "愿逐長風破萬里浪",
}
ttxisquanh:addEffect(fk.Damaged, {
  can_trigger = function(self, event, target, player, data)
    return data.to==player and target:hasSkill(ttxisquanh.name)
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = ttxisquanh.name,
      prompt = "#ttxisquanh-invoke:::".. player:getAttackRange(),
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    player:drawCards(player:getAttackRange(),ttxisquanh.name)
  end,
})

return ttxisquanh
