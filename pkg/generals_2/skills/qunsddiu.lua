local qunsddiu = fk.CreateSkill {
  name = "qunsddiu",
}

Fk:loadTranslationTable{
["qunsddiu"] = "運籌",
[":qunsddiu"] = "當伱使用一錦囊牌旹,伱可發動,伱抽1｡",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 


qunsddiu:addEffect(fk.CardUsing, {

  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(qunsddiu.name) and
      S.getCardTypeByName(data.card.name)==2
  end,
  on_use = function(self, event, target, player, data)
    player:drawCards(1, qunsddiu.name)
  end,
})

return qunsddiu
