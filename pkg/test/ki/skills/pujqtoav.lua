local pujqtoav = fk.CreateSkill {
  name = "pujqtoav",
}

Fk:loadTranslationTable{
  ["pujqtoav"] = "飛刀",
  [":pujqtoav"] = "➀始段始旹,伱可選至少1方片牌或武器牌發動.伱將之置于伱將牌上稱爲刃.➁印牌:以伱1刃轉化起動｢殺｣,此殺殺无視距離且若其子牌爲裝僃牌,无視防具.",

  ["pujqtoav_toav"] = "刃",
}

pujqtoav:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "ssaet",
  prompt = "#pujqtoav",
  mute_card = true,
  -- handly_pile = true,
  expand_pile="pujqtoav_nzjins",
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and table.contains(player:getPile("pujqtoav_nzjins"), to_select)
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then return end
    local c = Fk:cloneCard("ssaet")
    c.skillName = pujqtoav.name
    c:addSubcard(cards[1])
    return c
  end,
  enabled_at_play = Util.TrueFunc,
  enabled_at_response = function(self, player, response)
    return  not response
  end,
})


pujqtoav:addEffect("targetmod", {
  bypass_distances = function(self, player, skill, card)
    return card and table.contains(card.skillNames, pujqtoav.name)
  end,
})

pujqtoav:addEffect(fk.PreCardUse, {
  can_refresh = function (self, event, target, player, data)
    return target == player 
      and data.card
      and table.contains(data.card.skillNames, pujqtoav.name)
      and data.card.subcards[1]
      and Fk:getCardById(data.card.subcards[1]).sub_type==Card.SubtypeWeapon
 end,
  on_refresh = function (self, event, target, player, data)
    player.room:addCardMark(data.card, "@@ignore_Armor",1)
    player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true):addCleaner(function()
        player.room:removeCardMark(data.card, "@@ignore_Armor",1)
    end)
  end
})


pujqtoav:addEffect(fk.EventPhaseStart, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return  target==player and player:hasSkill(pujqtoav.name)
    and player.phase==Player.Start
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
      local cards = room:askToCards(player, {
        min_num = 1,
        max_num = 999,
        include_equip = true,
        pattern = ".|.|diamond;.|.|.|.|.|weapon",
        prompt = "#pujqtoav-choose",
        skill_name = pujqtoav.name,
        cancelable = true,
      })
    if #cards > 0 then
      event:setCostData(self, {cards = cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    player:addToPile("pujqtoav_nzjins", event:getCostData(self).cards, true, pujqtoav.name)
  end,
})

return pujqtoav
