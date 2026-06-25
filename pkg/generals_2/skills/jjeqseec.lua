
local jjeqseec= fk.CreateSkill{
  name = "jjeqseec",
}


Fk:loadTranslationTable{
  ["jjeqseec"] = "迻曐",
  [":jjeqseec"] = "一判定牌A生效歬，你可選擇一名角色裝僃區內一張牌B發動.交換A B(B作爲新判定牌,該角色得A)。",
  ["#jjeqseec-invoke"] = "迻星：選擇一角色一裝備區一牌替換 %dest %arg 判定牌",
  ["#jjeqseec-prey"] = "迻星：選擇 %dest 场上一张装备牌",
}

jjeqseec:addEffect(fk.AskForRetrial,{
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(jjeqseec.name) 
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local targets = table.filter(room.alive_players, 
      function(p)
      return #p:getCardIds("e") > 0 
      end)
    if #targets == 0 then return end
    local to = room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = targets,
      skill_name = jjeqseec.name,
      prompt = "#jjeqseec-invoke::"..target.id..":"..data.reason,
      cancelable = true,
    })[1]
      if not to then return end
      local card = room:askToChooseCard(player,{
        target = to,
        flag = "e",
        skill_name = jjeqseec.name,
        })
      event:setCostData(self, {tos = to, cards = card})
      return true
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local newCard =  event:getCostData(self).cards  --id
    local target = event:getCostData(self).tos -- id
    --1
    if  room:getCardOwner(newCard)~=target then return end
    local oldId = data.card:isVirtual() and data.card.subcards or { data.card.id }

    local moveInfos={}

    table.insert(moveInfos,{  --改判
      ids = {newCard}, --id list
      from = target,
      toArea = Card.Processing,
      moveReason = fk.ReasonExchange,
      skillName = jjeqseec.name,
      proposer = player,
    })

  
    table.insert(moveInfos,{---@type CardsMoveInfo
      ids = oldId,
      to =  target ,
      toArea =  Card.PlayerHand,
      moveReason =  fk.ReasonExchange,
      skillName = jjeqseec.name,
      proposer = player,
    } )

    room:moveCards(table.unpack(moveInfos))
    room:sendLog{
      type = "#ChangedJudge",
      from = player.id,
      to = {data.who.id}, --判定者
      arg2 = Fk:getCardById(newCard):toLogString(),  --改判用牌
      arg = jjeqseec.name
    }
    room:filterCard(newCard, target, true)
    data.card = Fk:getCardById(newCard)  --id



  end,
})

return jjeqseec
