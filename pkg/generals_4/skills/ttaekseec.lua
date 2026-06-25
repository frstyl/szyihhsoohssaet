local ttaekseec = fk.CreateSkill {
  name = "ttaekseec",
}


Fk:loadTranslationTable{
["ttaekseec"] = "摘星",
[":ttaekseec"] = "當一判斷牌生效歬,若其爲花色爲♦️,伱可選擇1牌發動,此此牌交換判定牌,(此牌作爲新判定牌,伱得元判定牌),伱抽1.",
["#ttaekseec-ask"] = "摘星  以一张牌交換 %dest %arg 判定",
}


ttaekseec:addEffect(fk.AskForRetrial, {
  ttaekseec = "control",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(ttaekseec.name) and data.card.suit==Card.Diamond
    and not player:isNude()
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    -- local ids = table.filter(table.connect(player:getHandlyIds(), player:getCardIds("e")), function (id)
    --   return not player:prohibitResponse(Fk:getCardById(id))
    -- end)
    local cards = room:askToCards(player, {
      min_num = 1,
      max_num = 1,
      skill_name = ttaekseec.name,
      include_equip = true,
      pattern = ".",--tostring(Exppattern{ id = ids })
      prompt = "#ttaekseec-ask::"..target.id..":"..data.reason,
      cancelable = true,
    })
    if #cards > 0 then
      event:setCostData(self, {cards = cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    -- player.room:changeJudge{
    --   card = Fk:getCardById(event:getCostData(self).cards[1]),
    --   player = player,
    --   data = data,
    --   skillName = ttaekseec.name,
    --   response = true,
    --   exchange=true,
    -- }
    local room=player.room
    local moveInfos={}
    local newId =event:getCostData(self).cards[1]
    table.insert(moveInfos,{  --改判
      ids = {newId}, --id list
      from = player,
      toArea = Card.Processing,
      moveReason = fk.ReasonExchange,
      skillName = ttaekseec.name,
      proposer = player,
    })

  
    table.insert(moveInfos,{---@type CardsMoveInfo
      ids = data.card:isVirtual() and data.card.subcards or { data.card.id },
      to =  player ,
      toArea =  Card.PlayerHand,
      moveReason =  fk.ReasonExchange,
      skillName = ttaekseec.name,
      proposer = player,
    } )

    room:moveCards(table.unpack(moveInfos))

    room:sendLog{
      type = "#ChangedJudge",
      from = player.id,
      to = {data.who.id}, --判定者
      arg2 = Fk:getCardById(newId):toLogString(),  --改判用牌
      arg = ttaekseec.name
    }
    room:filterCard(newId, target, true)
    data.card = Fk:getCardById(newId)  --id


    if player.dead then return end
    player:drawCards(1,ttaekseec.name)
  end,
})


return ttaekseec
