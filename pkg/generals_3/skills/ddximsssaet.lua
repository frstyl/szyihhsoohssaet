local ddximsssaet = fk.CreateSkill {
  name = "ddximsssaet",
  tags = { Skill.Limited },
}

Fk:loadTranslationTable {
  ["ddximsssaet"] = "鴆酒",
  [":ddximsssaet"] = "局限1. 其它角色聲明使用｢酒｣旹,伱可發動｡此酒效果改爲｢鴆｣",

  ["#ddximsssaet-invoke"] = "焚心：投毒%dest",

  ["$ddximsssaet1"] = "都欱矣夫",
}

ddximsssaet:addEffect(fk.AfterCardUseDeclared, {
  can_trigger = function(self, event, target, player, data)
    return target ~= player and player:hasSkill(ddximsssaet.name)
    and player:usedSkillTimes(ddximsssaet.name, Player.HistoryGame) == 0 
    and data.card.trueName == "tsiuh"
  end,
  on_use = function(self, event, target, player, data)
    -- data:changeCard("ddximsssaet", data.card.suit, data.card.number, ddximsssaet.name)
    room:changeMaxHp(target,-target:getLostHp())
  end,
})


return ddximsssaet
