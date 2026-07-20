local ciamqtszjech = fk.CreateSkill {
  name = "ciamqtszjech",
}

Fk:loadTranslationTable {
  ["ciamqtszjech"] = "嚴整",
  [":ciamqtszjech"] = "恆續,伱攻程+x,存牌數+x(x爲伱裝僃區牌數)",

  ["$ciamqtszjech1"] = "怀兼爱之心，琢世间百器。",
  ["$ciamqtszjech2"] = "机巧用尽，方化腐朽为神奇！",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 


ciamqtszjech:addEffect(fk.EventPhaseEnd, {
  can_trigger = function(self, event, target, player, data)
    return target==player 
    and player:hasSkill("ciamqtszjech") 
    and player.phase == Player.Draw
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local success, dat = room:askToUseActiveSkill(player, {
      skill_name = "ciamqtszjech_active",
      prompt = "#ciamqtszjech-invoke",
      cancelable = true,
      skip=true,
    })
    if success and dat then
      event:setCostData(self, {cards = dat.cards, tos=dat.targets, choice = dat.interaction})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local skill = Fk.skills["ciamqtszjech_active"]
    skill:onUse(player.room, {
      from = player,
      tos = event:getCostData(self).tos,
      cards=event:getCostData(self).cards,
      interaction_data =event:getCostData(self).choice,
    })
  end,
})

ciamqtszjech:addEffect("atkrange", {
  correct_func = function(self, player)
    if player:hasSkill(ciamqtszjech.name) and #player:getCardIds("e") > 0 then
      return  #player:getCardIds("e") 
    end
  end
})

ciamqtszjech:addEffect("maxcards", {
  correct_func = function(self, player)
    if player:hasSkill(ciamqtszjech.name) and #player:getCardIds("e") > 0 then
      return  #player:getCardIds("e") 
    end
  end,
})

return ciamqtszjech
