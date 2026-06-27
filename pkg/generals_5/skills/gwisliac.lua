local gwisliac = fk.CreateSkill {
  name = "gwisliac",
}

Fk:loadTranslationTable{
  ["gwisliac"] = "饋糧",
  [":gwisliac"] = "伱額定抽牌後,伱可分配一至多張牌發動,伱抽2倍分配花色牌數,當段內伱不可使用牌与被分配牌花色褈合者",

  ["#gwisliac-invoke"] = "饋糧：分配牌",

  ["@gwisliac-turn"] = "饋糧",

  ["$gwisliac1"] = "治军严谨，方得精锐之师。",
  ["$gwisliac2"] = "精兵当严于律己，束身自修。",
}

gwisliac:addEffect(fk.AfterDrawNCards, {
  is_delay_effect = true,
  mute = true,
  can_trigger = function(self, event, target, player, data)
    return target == player  
    and player:hasSkill(gwisliac.name)
    and not player:isKongcheng()
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local result = room:askToYiji(player, {
      targets = room.alive_players,
      skill_name = gwisliac.name,
      min_num = 1,
      max_num = 999,
      prompt = "#gwisliac-invoke",
      cancelable = true,
      skip = true,
    })
    local tos={}
    local suits={}
    for pid, ids in pairs(result) do
      if #ids > 0 then
        table.insert(tos,room:getPlayerById(pid))
        for _, id in pairs(ids) do 
          table.insertIfNeed(suits,Fk:getCardById(id):getSuitString(true))
        end
      end
    end
    if #tos>0 then
      table.removeOne(suits,"log_nosuit")
      event:setCostData(self, {extra_data = result,tos=tos,suits=suits})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local result = event:getCostData(self).extra_data
    local suits =event:getCostData(self).suits
    -- room:doYiji(result, player, gwisliac.name)  --visible

    local moveInfos = {}
    -- local move_ids = {}
    local playercards = player:getCardIds("he")
    for to, cards in pairs(result) do
        cards = table.filter(cards, function (id) return  table.contains(playercards, id) end)
        if #cards>0 then
          table.insert(moveInfos, {
            ids = cards,
            moveInfo = table.map(cards, function(id)
              return {cardId = id, fromArea = room:getCardArea(id), fromSpecialName = player:getPileNameOfId(id)}
            end),
            from = player,
            to = to,
            toArea = Card.PlayerHand,
            moveReason = fk.ReasonGive,
            proposer = proposer,
            skillName = gwisliac.name,
            -- moveMark = moveMark,
            visiblePlayers = table.map(room.players,function(p) return p.id end),
          })
        end
    end
    room:moveCards(table.unpack(moveInfos))
    if not player.dead then
      player:drawCards(2*#suits, gwisliac.name)
      room:setPlayerMark(player, "@gwisliac-turn",suits)
    end
  end,
})

gwisliac:addEffect("prohibit", {
  prohibit_use = function(self, player, card)
    return player:getMark("@gwisliac-turn") ~= 0 and card and table.contains(player:getMark("@gwisliac-turn"), card:getSuitString(true))
  end,
})

return gwisliac
