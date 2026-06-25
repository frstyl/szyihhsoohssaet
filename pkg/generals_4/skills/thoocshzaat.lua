
local thoocshzaat = fk.CreateSkill {
  name = "thoocshzaat",
}

Fk:loadTranslationTable{
["thoocshzaat"] = "統轄",
[":thoocshzaat"] = "抽牌階段始旹伱可發動,伱亮出牌堆頂6牌,連續3次,伱選擇其中1牌交予1角色,若爲裝僃牌則置入裝僃區且其抽1,剩餘牌元序置于牌堆頂",
["thoocshzaat-choose"] = "統轄",
}


thoocshzaat:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(thoocshzaat.name) and player.phase == Player.Draw and not data.phase_end
  end,
  on_use = function(self, event, target, player, data)
    data.phase_end = true
    local room = player.room
    local cards = room:getNCards(6)
    room:moveCards({  --放回
      ids = cards,
      toArea = Card.Processing,
      moveReason = fk.ReasonPut,
      skillName = thoocshzaat.name,
      proposer = player,
    })
          --
    for _, p in ipairs(room.players) do
      room:fillAG(p, cards)
    end


    for i = 1, 3, 1 do
      if player.dead then
        break
      end


      local to, chosen = room:askToChooseCardsAndPlayers(player, {
        min_num = 0,  --不選角色則爲自己
        max_num = 1,
        min_card_num = 1,
        max_card_num = 1,
        targets = room.alive_players,
        pattern = tostring(Exppattern{ id = cards }),
        skill_name = thoocshzaat.name,
        prompt = "#thoocshzaat-give",
        cancelable = false,
        expand_pile = cards,  --額外牌 遺計所觀看牌
      })

      if  #to==0 then table.insert(to,player) end --不選角色則爲自己
      -- room:takeAG(to, chosen, room.players)
      -- table.insert(AGResult, {to.id, chosen})
      if Fk:getCardById(chosen[1]).type == Card.TypeEquip then
        room:moveCardIntoEquip(to[1], chosen, thoocshzaat.name, true, player)  --player.id?
        to[1]:drawCards(1,thoocshzaat.name)
      else --置入moveCardTo(card, to_place, target, reason, skill_name, special_name, visible, proposer, moveMark, visiblePlayers)
        room:moveCardTo(chosen, Card.PlayerHand, to[1], fk.ReasonGive, thoocshzaat.name, nil, true, player.id)
      end
      table.removeOne(cards, chosen[1])  --list
      room:takeAG(to[1], chosen[1])
    end  --給牌


    for _, p in ipairs(room.players) do
        room:closeAG(p)
    end
    room:moveCards({  --放回
      ids = table.reverse(cards),
      toArea = Card.DrawPile,
      moveReason = fk.ReasonPut,
      skillName = thoocshzaat.name,
      proposer = player,
    })
  end,
})

thoocshzaat:addEffect(fk.TurnEnd,{ 
  mute = true,
  can_refresh = Util.FalseFunc,
  on_refresh = function(self, event, target, player, data)
      for _, p in ipairs(room.players) do
        room:closeAG(p)
      end
  end,
})
return thoocshzaat

