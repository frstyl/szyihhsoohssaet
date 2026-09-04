local quanhszuos = fk.CreateSkill {
  name = "quanhszuos",
}

Fk:loadTranslationTable{
  ["quanhszuos"] = "遠戍",
  [":quanhszuos"] = "轉始旹,伱可1明置手牌發動｡伱因起動打出失去手牌區明置牌後,伱可發動,伱抽x,x=max(1,伱明置手牌數)",

  ["#quanhszuos-ask"] = "遠戍：明置1牌",

  ["$quanhszuos1"] = "操权弄略，舍小利，而谋大计！",
  ["$quanhszuos2"] = "大丈夫行事，岂较一兵一将之得失？",
}


quanhszuos:addEffect(fk.TurnStart, {
  anim_type = "drawcard",
  can_trigger = function (self, event, target, player, data)
    return player:hasSkill(quanhszuos.name)
  end,
  on_cost = function (self, event, target, player, data)
    local cards = table.filter(player:getCardIds("h"),function(id)
				return not Fk:getCardById(id):hasMark("@@opend")
			end
			)
    if #cards==0 then return end
    local cards=player.room:askToCards(player, {
      min_num = 1,
      max_num = 1,
      skill_name = quanhszuos.name,
			pattern=tostring(Exppattern{ id = cards }),      
      prompt = "#quanhszuos-ask",
      cancelable = true,
    })
    if #cards > 0 then
      event:setCostData(self, {cards = cards})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    room=player.room
    local  card = Fk:getCardById(event:getCostData(self).cards[1]),
    room:addSkill("openCards")
    room:addCardMark(card,"@@open-inhand",1)
  end,
})


quanhszuos:addEffect(fk.BeforeCardsMove, {
  anim_type = "drawcard",
  priority=0.01,
  can_refresh = function (self, event, target, player, data)
    if not  player:hasSkill(quanhszuos.name,true) then return end

    for _, move in ipairs(data) do
      if table.contains({fk.ReasonUse , fk.ReasonResponse} ,  move.moveReason )
        and move.from ==player
        and (move.to~=player or not table.contains({Card.PlayerHand }, move.toArea)) 
      then

        for _, info in ipairs(move.moveInfo) do
          if  (info.fromArea == Card.PlayerHand ) and Fk:getCardById(info.cardId):hasMark("@@opend")  then
            return true
          end
        end
      end
    end

  end,
  on_refresh = function (self, event, target, player, data)
    data.extar_data =data.extar_data or {}
    data.extar_data.quanhszuos=data.extar_data.quanhszuos or {}
    table.insert(data.extar_data.quanhszuos, player.id)
  end,
})

quanhszuos:addEffect(fk.AfterCardsMove, {
  can_trigger = function (self, event, target, player, data)
    return player:hasSkill(quanhszuos.name) 
    and data.extar_data 
    and table.contains(data.extar_data.quanhszuos or {},player.id)
  end,
  on_use = function (self, event, target, player, data)
    room=player.room
    local n = #table.filter(player:getCardIds("h"), function(id)
      return Fk:getCardById(id):hasMark("@@opend")
    end)
    player:drawCards(math.max(1, n), quanhszuos.name)
  end,
})
return quanhszuos
