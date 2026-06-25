local dzjemqszyih = fk.CreateSkill {
  name = "dzjemqszyih",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["dzjemqszyih"] = "濳水",
  [":dzjemqszyih"] = "殺/鬥將/行刺對伱生效前,若使用者攻程不大于其至伱距離,必發,此牌對伱无效",

  ["$dzjemqszyih1"] = "哈哈哈哈哈哈哈哈！",
  ["$dzjemqszyih2"] = "伯符，且看我这一手！",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

dzjemqszyih:addEffect(fk.PreCardEffect, {
  can_trigger = function(self, event, target, player, data)
    return data.to == player and player:hasSkill(dzjemqszyih.name) 
    and  data.to:getAttackRange()<= data.to:distanceTo(player)
    and  table.contains({"ssaet", "hzaac_tshjes","tous_tsiacs"}, data.card.trueName)
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    S.effectNullify(data,player,dzjemqszyih.name)
  end,
})


return dzjemqszyih
