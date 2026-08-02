Fk:loadTranslationTable{
  ["hqoeomsmiu"] = "暗謀",
  [":hqoeomsmiu"] = "應動｡一脚色{占卜牌生效前/賭鬥牌亮出前},伱可選其一手牌發動.伱打出此牌代替元{占卜/賭鬥}牌同旹取得元牌。",

  ["#hqoeomsmiu-judge"] = "是否發動 暗謀，打出%dest一张牌代替 其 %arg 占卜",
  ["#hqoeomsmiu-pindian"] = "是否發動 暗謀 改變賭鬥牌",

  -- ["#ChangedPindian"] = "%from 發動｢%arg｣把 %to 賭鬥牌改爲 %arg2",

  ["$hqoeomsmiu1"] = "伱我如兄弟 我豈會諞伱",
  ["$hqoeomsmiu2"] = "衙內吩咐 吾自當照辦",
}

local hqoeomsmiu = fk.CreateSkill{
  name = "hqoeomsmiu",
}

-- --😓️
hqoeomsmiu:addEffect(fk.PindianCardsDisplaying, {
  hqoeomsmiu = "control",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(hqoeomsmiu.name) 
  end,
  trigger_times = function(self, event, target, player, data)
    return 999
  end,

  on_cost = function(self, event, target, player, data)
    local room = player.room
    local chooded=event:getCostData(self) and event:getCostData(self).chooded  or {}
    local targets =table.simpleClone(data.tos) --😓️
      table.insertIfNeed(targets,data.from)
      targets = table.filter(targets, function(p) return not  table.contains(chooded,p) and not p:isKongcheng() end)
    if #targets==0 then event:setCostData(self,nil) return end

    local tos = room:askToChoosePlayers(player, {
      targets = targets,
      min_num = 1,
      max_num = 1,
      prompt = "#hqoeomsmiu-pindian",
      skill_name = hqoeomsmiu.name,
    })
    if #tos==0 then event:setCostData(self,nil) return end
    local cards = room:askToChooseCards(player, { target = tos[1], flag = "h", skill_name = hqoeomsmiu.name,  min = 1, max = 1, })
    if #cards > 0 then
      table.insert(chooded,tos[1])
      event:setCostData(self, {cards = cards,tos=tos, chooded=chooded })
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local newCard =Fk:getCardById(event:getCostData(self).cards[1])
    local to =event:getCostData(self).tos[1]
    local toCard
    -- data.fromCard = newCard

    local moveInfos={}
    table.insert(moveInfos, {
        ids = { newCard.id },
        from = to,
        toArea = Card.Processing,
        moveReason = fk.ReasonResponse,
        skillName = hqoeomsmiu.name,
        moveVisible = false,
        proposer = player,
      })
    local subCards={}
    if to == data.from then
      toCard=data.fromCard
    else
      toCard=data.results[to].toCard
    end


      local oldCard=room:getSubcardsByRule(toCard,{Card.Processing})
      if #oldCard>0 then
        toCard.number=newCard.number + toCard.number - Fk:getCardById(oldCard[1]).number 
        subCards=oldCard
      else  --虛擬牌賭鬥 不可知元點數
        toCard.number=newCard.number
      end

      toCard.name=newCard.name
      toCard.suit=newCard.suit
      toCard.subcards ={newCard.id}

      
    if #subCards>0 then
      table.insert(moveInfos, {
          ids = subCards,
          from = nil,
          to =  player,
          toArea = Card.PlayerHand,
          moveReason = fk.ReasonPrey,
          skillName = hqoeomsmiu.name,
          moveVisible = false,
      proposer = player,
      })
    end
    room:moveCards(table.unpack(moveInfos))
    -- room:sendLog{
    --   type = "#ChangedPindian",
    --   from = player.id,
    --   to = {to.id}, --占卜者
    --   arg2 = toCard:toLogString(),  --改判用牌 --newCard
    --   arg = hqoeomsmiu.name
    -- }
  end,
})
-- hqoeomsmiu:addEffect(fk.AfterCardsMove, {
--   hqoeomsmiu = "control",
--   priority=-1,--亮牌前
--   can_trigger = function(self, event, target, player, data)
--     if not player:hasSkill(hqoeomsmiu.name) 
--     or player.room.logic:getCurrentEvent().parent.event ~= GameEvent.Pindian 
--     then
--       -- player.room:loseHp(player,1)
--       return 
--     end
--     return true
--   end,
--   -- trigger_times = function(self, event, target, player, data)
--   --   return 999
--   -- end,
--   on_trigger = function(self, event, target, player, data)
--     local room=player.room
--     local e= player.room.logic:getCurrentEvent().parent
--     local dat = e.data

--     local chooded= {}
--     local targets =table.simpleClone(dat.tos)
--       table.insertIfNeed(targets,dat.from)
--       -- targets = table.filter(targets, function(p) return not  table.contains(chooded,p) and not p:isKongcheng() end)
--     if #targets==0 then return end


--     while true do
--     if not player:hasSkill(hqoeomsmiu.name)  then return end
--       local tos = room:askToChoosePlayers(player, {
--         targets = targets,
--         min_num = 1,
--         max_num = 1,
--         prompt = "#hqoeomsmiu-pindian",
--         skill_name = hqoeomsmiu.name,
--       })
--       if #tos==0 then return end
--       table.removeOne(targets,tos[1])
--       -- event:setCostData(self,{tos=tos})
--       -- self.doCost(event, target, player, data)  --e
--             self:doCost(event, player, player, dat)

--     end
--   end,
--   on_cost = function(self, event, target, player, data)
--     -- local tos =event:getCostData(self).tos
--     local tos={target}
--     local cards = player.room:askToChooseCards(player, { target = tos[1], flag = "h", skill_name = hqoeomsmiu.name,  min = 1, max = 1, })
--     if #cards > 0 then
--       event:setCostData(self, {cards = cards,tos=tos})
--       return true
--     end
--   end,
--   -- on_cost = function(self, event, target, player, data)
--   --   local room = player.room
--   --   local chooded=event:getCostData(self) and event:getCostData(self).chooded  or {}
--   --   local targets =data.tos
--   --     table.insertIfNeed(targets,data.from)
--   --     targets = table.filter(targets, function(p) return not  table.contains(chooded,p) and not p:isKongcheng() end)
--   --   if #targets==0 then return end

--   --   local tos = room:askToChoosePlayers(player, {
--   --     targets = targets,
--   --     min_num = 1,
--   --     max_num = 1,
--   --     prompt = "#hqoeomsmiu-pindian",
--   --     skill_name = hqoeomsmiu.name,
--   --   })
--   --   if #tos==0 then event:setCostData(self,nil) return end
--   --   local cards = room:askToChooseCards(player, { target = tos[1], flag = "h", skill_name = hqoeomsmiu.name,  min = 1, max = 1, })
--   --   if #cards > 0 then
--       -- table.insert(chooded,tos[1])
--   --     event:setCostData(self, {cards = cards,tos=tos, chooded=chooded })
--   --     return true
--   --   end
--   -- end,
--   on_use = function(self, event, target, player, data)
--     local room=player.room
--     local newCard =Fk:getCardById(event:getCostData(self).cards[1])
--     local to =event:getCostData(self).tos[1]
--     local moveInfos={}
--     table.insert(moveInfos, {
--         ids = { newCard.id },
--         from = to,
--         toArea = Card.Processing,
--         moveReason = fk.ReasonResponse,
--         skillName = hqoeomsmiu.name,
--         moveVisible = false,
--       proposer = player,
--       })
--     local subCards
--     if to == data.from then

--       local card = newCard:clone(newCard.suit, newCard.number)  --暗
--       card.subcards ={newCard.id}

--       local oldCard=room:getSubcardsByRule(data.fromCard,{Card.Processing})
--       if #oldCard>0 then
--         card.number=card.number + data.fromCard.number - Fk:getCardById(oldCard[1]).number 
--         subCards=oldCard
--       end

--       data.fromCard=card
--     else
--       local card = newCard:clone(newCard.suit, newCard.number)  --暗
--       card.subcards ={newCard.id}

--       local oldCard= room:getSubcardsByRule(data.results[to].toCard,{Card.Processing})
--       if #oldCard>0  then
--       card.number=card.number + data.results[to].toCard.number - Fk:getCardById(oldCard[1]).number 
--          subCards=oldCard
--       end

--       data.results[to].toCard=card
--     end

--     if #subCards>0 then
--       table.insert(moveInfos, {
--           ids = subCards,
--           from = nil,
            -- to =  player ,
--           toArea = Card.PlayerHand,
--           moveReason = fk.ReasonPrey,
--           skillName = hqoeomsmiu.name,
--           moveVisible = false,
--       proposer = player,
--       })
--     end

--     room:moveCards(table.unpack(moveInfos))

--   end,
-- })

hqoeomsmiu:addEffect(fk.AskForRetrial, {
  hqoeomsmiu = "control",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(hqoeomsmiu.name) and not data.who:isKongcheng()
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local cards = room:askToChooseCards(player, { target = data.who, flag = "h", skill_name = hqoeomsmiu.name,  min = 0, max = 1,prompt=="#hqoeomsmiu-judge::"..target.id..":"..data.reason })
    if #cards > 0 then
      event:setCostData(self, {cards = cards,tos={data.who}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local from=event:getCostData(self).tos[1]
    local moveInfos={}
    local newId =event:getCostData(self).cards[1]
    table.insert(moveInfos,{  --改判
      ids = {newId}, --id list
      from = from,
      toArea = Card.Processing,
      moveReason = fk.ReasonResponse,
      skillName = hqoeomsmiu.name,
      proposer = player,
    })

  
    table.insert(moveInfos,{---@type CardsMoveInfo
      ids = room:getSubcardsByRule(data.card, {Card.Processing}),
      to =  player ,
      toArea =  Card.PlayerHand,
      moveReason =  fk.ReasonPrey,
      skillName = hqoeomsmiu.name,
      proposer = player,
    } )

    room:moveCards(table.unpack(moveInfos))

    room:sendLog{
      type = "#ChangedJudge",
      from = player.id,
      to = {data.who.id}, --占卜者
      arg2 = Fk:getCardById(newId):toLogString(),  --改判用牌
      arg = hqoeomsmiu.name
    }
    room:filterCard(newId, target, true)
    data.card = Fk:getCardById(newId)  --id

  end,
})

return hqoeomsmiu
