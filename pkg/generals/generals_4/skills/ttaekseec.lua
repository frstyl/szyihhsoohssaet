local ttaekseec = fk.CreateSkill {
  name = "ttaekseec",
}


Fk:loadTranslationTable{
["ttaekseec"] = "摘星",
[":ttaekseec"] = "應動｡當一判斷牌生效歬,若其爲花色爲♦️,伱可預打出1手牌發動,此牌作爲新占卜牌同旹伱取得元占卜牌,伱抽1.",
["#ttaekseec-ask"] = "摘星  以一张牌交換 %dest %arg 占卜",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

ttaekseec:addEffect(fk.AskForRetrial, {
  ttaekseec = "control",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(ttaekseec.name) and data.card.suit==Card.Diamond
    and not player:isNude()
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
		local cards = S.askToPlayCard(player, {
		  min_num = 1,
		  max_num = 1,
		  include_equip = false,
		  skill_name = ttaekseec.name,
		  cancelable = true,
      pattern = ".",
      prompt = "#ttaekseec-ask::"..target.id..":"..data.reason,
		  skip = true,
		})
    if #cards ~= 0 then
      event:setCostData(self, {cards = cards,tos={target}})
      return true
    end
  end,
  
  on_use = function(self, event, target, player, data)
    local room=player.room
    local moveInfos={}
    local newId =event:getCostData(self).cards[1]
    table.insert(moveInfos,{  --改判
      ids = {newId}, --id list
      from = player,
      toArea = Card.Processing,
      moveReason = fk.ReasonResponse,
      skillName = ttaekseec.name,
      proposer = player,
    })

  
    table.insert(moveInfos,{---@type CardsMoveInfo
      ids = room:getSubcardsByRule(data.card,{Card.Processing}),
      to =  player ,
      toArea =  Card.PlayerHand,
      moveReason =  fk.ReasonPrey,
      skillName = ttaekseec.name,
      proposer = player,
    } )

    room:moveCards(table.unpack(moveInfos))

    room:sendLog{
      type = "#ChangedJudge",
      from = player.id,
      to = {data.who.id}, --占卜者
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
