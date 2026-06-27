local kxeqlvoan = fk.CreateSkill {
  name = "kxeqlvoan",

}

Fk:loadTranslationTable{
  ["kxeqlvoan"] = "羈鸞",
  [":kxeqlvoan"] = "鎖定.伱手牌區殺視爲逼上梁山.伱受行刺所致傷旹,必發.傷害值+1",

  ["$kxeqlvoan1"] = "伱若上了梁山就休入我門",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

kxeqlvoan:addEffect("filter", {
  card_filter = function(self, to_select, player)
    return player:hasSkill(kxeqlvoan.name)
      and table.contains(player:getCardIds("h"), to_select.id)
      and to_select.trueName == "ssaet"
  end,
  view_as = function(self, player, to_select)
    local card = Fk:cloneCard("pik_dzziach_liac_ssaen", Card.Heart, to_select.number)
    card.skillName = kxeqlvoan.name
    return card
  end,
})

kxeqlvoan:addEffect(fk.DamageInflicted, {
  can_trigger = function(self, event, target, player, data)
    return  target==player and player:hasSkill(kxeqlvoan.name) 
    and data.card and data.card.trueName=="hzaac_tshjes"
  end,
  on_use = function(self, event, target, player, data)
    S.changeDamage({damageData=data,num=1,skillName=kxeqlvoan.name})
  end,
})

return kxeqlvoan
