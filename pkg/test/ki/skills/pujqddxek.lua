local pujqddxek = fk.CreateSkill {
  name = "pujqddxek",
}

Fk:loadTranslationTable{
  ["pujqddxek"] = "飛擲",
  [":pujqddxek"] = "伱可將♠️牌轉化爲殺起動發動.",

  ["pujqddxek_toav"] = "刃",
}

pujqddxek:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "ssaet",
  prompt = "#pujqddxek",
  mute_card = true,
  handly_pile = true,
  include_equip=true,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and Fk:getCardById(to_select).suit==Card.Spade 
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then return end
    local c = Fk:cloneCard("ssaet")
    c.skillName = pujqddxek.name
    c:addSubcard(cards[1])
    return c
  end,
  enabled_at_play = Util.TrueFunc,
  enabled_at_response = function(self, player, response)
    return  not response
  end,
})


pujqddxek:addEffect("targetmod", {
  bypass_distances = function(self, player, skill, card)
    return card and table.contains(card.skillNames, pujqddxek.name)
  end,
})

return pujqddxek
