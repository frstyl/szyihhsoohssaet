local dvoatmracs = fk.CreateSkill {
  name = "dvoatmracs",
}

Fk:loadTranslationTable{
["dvoatmracs"] = "奪命",
[":dvoatmracs"] = "當其它角色于其轉內回復體力後,伱選擇2黑色牌發動,伱將所選牌幖記交予該角色,予其1傷.奪命牌于當歬轉內:明置且不可被使用打出棄置",
["#dvoatmracs-give"]="奪命 將2手牌交予  %src ",
["@@dvoatmracs-turn"] = "奪命",
}

dvoatmracs:addEffect(fk.HpRecover, {
  anim_type = "offensive",
  -- trigger_times = function(self, event, target, player, data)
  --   return data.num
  -- end,
  can_trigger = function(self, event, target, player, data)
    return target ~= player and player:hasSkill(dvoatmracs.name) and player.room.current == target
    and player:getHandcardNum()>=2 
  end,
  on_cost = function(self, event, target, player, data)
    local dvoatmracs_card=player.room:askToCards(player,{
      skill_name = dvoatmracs.name,
      include_equip = true,
      min_num = 2,
      max_num = 2,
      pattern =".|.|spade,club",
      prompt = "#dvoatmracs-give:"..target.id,
      cancelable = true,
    })
    if #dvoatmracs_card==2 then
      event:setCostData(self, {cards = dvoatmracs_card})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local  cards=event:getCostData(self).cards 
    local target=data.who
    if #cards ~=2 then return end
    if target.dead then return end
    local room=player.room


    -- room:setCardMark(Fk:getCardById(cards.cardId), "@@dvoatmracs-turn", 1)
    room:moveCardTo(cards, Card.PlayerHand, target, fk.ReasonGive, dvoatmracs.name, nil, true, player, "@@dvoatmracs-turn")
    room:damage({ --新旹機
        from = player,
        to = target,
        card = nil,
        damage = 1,
        damageType = fk.NormalDamage,
        skillName = dvoatmracs.name,
        })
  end,
})

-- dvoatmracs:addEffect(fk.TurnEnd, {
-- --   anim_type = "negative",
-- --   is_delay_effect = true,
--   can_refresh = function(self, event, target, player, data)  --refresh? trigger?
--     return Fk:currentRoom().current == target 
--   end,
--   on_refresh = function (self, event, target, player, data)
--     local room = player.room
--     for _, id in ipairs(player:getCardIds("h")) do
--       room:setCardMark(Fk:getCardById(id), "@@dvoatmracs-turn", 0)
--     end
--   end,
-- })

dvoatmracs:addEffect("prohibit", {
  prohibit_use = function(self, player, card)
    local cards = card:isVirtual() and card.subcards or {card.id}
    return table.find(cards, function(id)
      return Fk:getCardById(id):getMark("@@dvoatmracs-turn") > 0
    end)
  end,
  prohibit_response = function(self, player, card)
    local cards = card:isVirtual() and card.subcards or {card.id}
    return table.find(cards, function(id)
      return Fk:getCardById(id):getMark("@@dvoatmracs-turn") > 0
    end)
  end,
  prohibit_discard = function(self, player, card)
    return card:getMark("@@dvoatmracs-turn") > 0
  end,
})

dvoatmracs:addEffect("visibility", {
  card_visible = function(self, player, card)
    if  Fk:currentRoom():getCardArea(card) == Card.PlayerHand and card:getMark("@@dvoatmracs-turn") > 0 then
      return true
    end
  end
})

return dvoatmracs
