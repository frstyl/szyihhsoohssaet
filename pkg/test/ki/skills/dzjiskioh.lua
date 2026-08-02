local dzjiskioh = fk.CreateSkill{
  name = "dzjiskioh",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["dzjiskioh"] = "自舉",
  [":dzjiskioh"] = "游戲始旹/,伱執行主段",
  ["$dzjiskioh"] = "今疑兵之计，已搓敌兵心胆，其安敢侵近！",
}

dzjiskioh:addEffect(fk.GameStart, {--RoundStart
  priority=999,
  anim_type = "negative",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(dzjiskioh.name) 
  end,
  on_use = function(self, event, target, player, data)
    player:gainAnExtraPhase(Player.Play, dzjiskioh.name, false)
  end,
})

return dzjiskioh
