local maanqlik = fk.CreateSkill {
  name = "maanqlik",
}
Fk:loadTranslationTable{
  ["maanqlik"] = "蠻力",
  [":maanqlik"] = "當伱可使用鬥將旹,若伱裝僃區牌數不小于伱體力值,伱可發殺轉化爲鬥將發動.无視距離且止能被紅色牌響應",

}
maanqlik:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "tous_tsiacs",
  prompt = "#maanqlik",
  mute_card = true,
  handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and Fk:getCardById(to_select).trueName == "ssaet"
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then return end
    local c = Fk:cloneCard("tous_tsiacs")
    c.skillName = maanqlik.name
    c:addSubcard(cards[1])
    return c
  end,
  enabled_at_play = function(self,player)
    return #player:getCardIds("e")>=player.hp
  end,
  enabled_at_response = function(self,player,response)
    return not response and #player:getCardIds("e")>=player.hp
  end,
})

maanqlik:addEffect(fk.HandleAskForPlayCard, {  --眞止問ask AskForCardData extraData eventData
  can_refresh = function(self, event, target, player, data)  --雙向?
    return  data.eventData and  data.eventData.card
        and  table.contains(data.eventData.card.skillNames,maanqlik.name)
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
      --       for _, p in ipairs(Fk:currentRoom().players) do  --7.22入庫 8.23發現整段被註 而此未註
      -- p:drawCards(1, maanqlik.name)
      -- -- ssaacqsih(p)
      --       end
    if not data.afterRequest then
      room:setBanner("maanqlik_color", 1)
    else
      room:setBanner("maanqlik_color", nil)
    end
  end,
})

maanqlik:addEffect("prohibit", {
  prohibit_use = function(self, player, card)
    return Fk:currentRoom():getBanner("maanqlik_color")
    and player and card and card.color~=Card.Red 
  end,
  prohibit_response = function(self, player, card)
    return Fk:currentRoom():getBanner("maanqlik_color")
    and player and card and card.color~=Card.Red 
  end,
})
maanqlik:addEffect("targetmod", {
  bypass_distances = function(self, player, skill, card)
    return card and player and table.contains(card.skillNames,maanqlik.name)
  end,
})
return maanqlik
