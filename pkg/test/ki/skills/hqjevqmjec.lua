local tszjevqmjec = fk.CreateSkill {
  name = "tszjevqmjec",
}

Fk:loadTranslationTable{
  ["tszjevqmjec"] = "昭名",
  [":tszjevqmjec"] = "伱聲明起動目幖旹,若x>y,伱可發動,伱抽x(x爲此次目幖數,y爲一轉內上次發動之目幖數,无則爲0)",


  ["$tszjevqmjec1"] = "破阵杀敌，愿献犬马之劳！",
  ["$tszjevqmjec2"] = "虎啸既响，厭迮当附！",
}
local S = require "packages/szyihhsoohssaet/szyih_guos"


tszjevqmjec:addEffect(fk.AfterCardTargetDeclared, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(tszjevqmjec.name) 
    and  #data.tos > player:getMark("tszjevqmjec-turn")
  end,
  on_use = function(self, event, target, player, data)
    local n =#data.tos
    player.room:setPlayerMark(player,"tszjevqmjec-turn",n)
    player:drawCards(n, tszjevqmjec.name)
  end,

})

return tszjevqmjec
