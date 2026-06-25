local pouktheen = fk.CreateSkill {
  name = "pouktheen",
}

Fk:loadTranslationTable{
  ["pouktheen"] = "卜天",
  [":pouktheen"] = "➀恆續,牌堆頂3牌對伱可見.➁一判定牌生效歬,伱可預打出1牌發動,自牌堆頂3牌或牌堆底1牌中選1与判定牌交換,中止改判旹機",

  ["#pouktheen-invoke"] = "卜天 修改 %dest %arg 判定？",
  ["#pouktheen-choose"] = "卜天 選擇",
  ["@[private]$pouktheen"] = "卜天",

}

local U = require("packages/utility/utility")


pouktheen:addLoseEffect (function (self, player)
  player.room:setPlayerMark(player, "@[private]$pouktheen", 0)
end)

-- pouktheen:addAcquireEffect (function (self, player)
--   local room=player.room
--   room:setBanner("pouktheen", {})
--   room:setBanner("@$pouktheen", {})
-- end)

pouktheen:addEffect(fk.AfterCardsMove, {
  can_refresh = function(self, event, target, player, data)
    if not player:hasSkill(pouktheen.name) then return end
    return true 
    -- local ids={}
    -- for _, move in ipairs(data) do  --其實不需檢測
    --   if  move.toArea == Card.DrawPile  then
    --     return true
    --   else
    --     for _, info in ipairs(move.moveInfo) do
    --       local card=Fk:getCardById(info.cardId)
    --       if info.fromArea == Card.DrawPile then
    --          return true
    --       end
    --     end
    --   end
    -- end
  end,
  on_refresh = function(self, event, target, player, data)
    -- if not player:hasSkill(pouktheen.name) then return end
    local ids={}
    local n = 3
    if  #Fk:currentRoom().draw_pile<=n then --不用getNCards
      ids=table.simpleClone(Fk:currentRoom().draw_pile)
    else
      for i = 1, n, 1 do
        table.insert(ids, Fk:currentRoom().draw_pile[i])
      end
    end
      U.setPrivateMark(player, "$pouktheen", ids)
  end,
})

pouktheen:addEffect("visibility", {  --抽牌過程已爲手牌
  card_visible = function(self, player, card)

    if player:hasSkill(pouktheen.name) and table.contains(player:getTableMark("$pouktheen"), card.id) then
      return true
    end

  end,
  move_visible=function(self, player, info, move)
    if player:hasSkill(pouktheen.name) then
      local n = 3 +1
      if info.fromArea==Card.DrawPile and table.indexOf(move.moveInfo,info)<n --寸目?
      then return true 
      elseif move and move.toArea==Card.DrawPile 
        and #move.moveInfo-table.indexOf(move.moveInfo,info)+1 < n-((move.drawPilePosition or 1)-1)
      then return true 
          
      end

--牌堆底?
    end
    
  end,
})

pouktheen:addEffect(fk.AskForRetrial, {
  anim_type = "control",
  can_trigger = function (self, event, target, player, data)
    return player:hasSkill(pouktheen.name)
    and not player:isNude()
  end,
  on_cost = function (self, event, target, player, data)
    local room=player.room
    local ids = table.filter(player:getHandlyIds(), function (id)
      return not player:prohibitResponse(Fk:getCardById(id))
    end)
    local cards = room:askToCards(player, {
      min_num = 1,
      max_num = 1,
      skill_name = pouktheen.name,
      pattern = tostring(Exppattern{ id = ids}),
      prompt = "#pouktheen-invoke::"..target.id..":"..data.reason,
      cancelable = true,
    })
    if #cards == 1 then
      event:setCostData(self, {tos = {target}, cards = cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:responseCard({
				card=Fk:getCardById(event:getCostData(self).cards[1]),
				from=player,
				attachedSkillAndUser={muteCard=true},
			})
    if player.dead then return end

    local oldId=data.card:isVirtual() and data.card.subcards or { data.card.id }

    local ids={}
    local n = 3 
    if  #Fk:currentRoom().draw_pile<=n then 
      ids=table.simpleClone(Fk:currentRoom().draw_pile)
    else
      for i = 1, n, 1 do
        table.insert(ids, Fk:currentRoom().draw_pile[i])
      end
        table.insert(ids, Fk:currentRoom().draw_pile[#Fk:currentRoom().draw_pile])
    end

    local newCard = room:askToCards(player, {
        min_num = 1,
        max_num = 1,
        include_equip = false,
        skill_name = pouktheen.name,
        pattern = tostring(Exppattern{ id = ids }),
        prompt = "#pouktheen-choose::"..target.id,
        expand_pile = ids,
        cancelable=false,
      })
      -- if card=nil then return end
      local moveInfos={}
      local drawPilePosition = table.indexOf(ids,newCard[1])
      if drawPilePosition ==4 then drawPilePosition =-1 end
      table.insert(moveInfos,{
        ids = newCard,
        from = nil,
        toArea = Card.Processing,
        moveReason =  fk.ReasonExchange ,
        skillName = pouktheen.name,
          proposer = player,
      })
      table.insert(moveInfos,{
        ids = oldId,
        from = nil,
        toArea = Card.DrawPile,
        moveReason = fk.ReasonExchange,
        skillName = pouktheen.name,
        proposer = player,
        drawPilePosition = drawPilePosition,
        moveVisible = true,
      })
    room:moveCards(table.unpack(moveInfos))

      local c=Fk:getCardById(newCard[1])
      room:filterCard(c.id, target, true)
      data.card = c

      room:sendLog{
      type = "#ChangedJudge",
      from = player.id,
      to = { data.who.id },
      arg2 = c:toLogString(),
      arg = pouktheen.name,
      }

      return true --不能改
  end,
})

return pouktheen
