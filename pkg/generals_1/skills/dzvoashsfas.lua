local dzvoahhsfas = fk.CreateSkill {
  name = "dzvoahhsfas",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["dzvoahhsfas"] = "坐化",
  [":dzvoahhsfas"] = "鎖定.其它角色殺死伱不執行獎懲。",

  ["$dzvoahhsfas1"] = "錢塘江上潮信來今日方知我是我",
}


dzvoahhsfas:addEffect(fk.BuryVictim, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(dzvoahhsfas.name, false, true)
  end,
  on_use = function(self, event, target, player, data)
    data.extra_data = data.extra_data or {}
    data.extra_data.skip_reward_punish = true
  end,
})



return dzvoahhsfas
