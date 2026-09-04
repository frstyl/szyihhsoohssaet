local gwisliac = fk.CreateSkill {
  name = "gwisliac",
}

Fk:loadTranslationTable{
  ["gwisliac"] = "饋糧",
  [":gwisliac"] = "伱補段終旹,(若伱有手)伱可發動,伱分配不同花色牌至少1張｡以此分配牌于手牌區明置,離開手牌區後持有者抽2",
  -- [":gwisliac"] = "伱額定抽牌後,伱可分配一至多張牌發動,伱抽2倍分配花色牌數,1段內伱不可起動牌与被分配牌花色褈合者",

  ["#gwisliac-invoke"] = "饋糧：分配牌",

  ["@@gwisliac"] = "饋糧",
  -- ["@@gwisliac-turn"] = "饋糧",

  ["$gwisliac1"] = "治军严谨，方得精锐之师。",
  ["$gwisliac2"] = "精兵当严于律己，束身自修。",
}


gwisliac:addEffect(fk.EventPhaseEnd, {
  anim_type="drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player  
    and player:hasSkill(gwisliac.name)
    and not player:isKongcheng()
	and data.phase==Player.Draw
  end,

  on_use = function(self, event, target, player, data)
    local room = player.room
    local cards={}
    local yes, dat = room:askToUseActiveSkill(player, {  
      skill_name = "gwisliac_active",
      -- prompt = "#gwisliac_active",
      cancelable = false,
      skip = true,  --不執行
    })
    if yes then
      cards=dat.cards
    else
      return
    end
    
    local result = room:askToYiji(player, {
      targets = room.alive_players,
      skill_name = gwisliac.name,
      prompt = "#gwisliac-invoke",
      cancelable = false,
      skip = false,
      cards=cards,
      moveMark={"@@opend",1,"@@gwisliac",1},
    })
    if result[player.id] then
      for _, id in ipairs(result[player.id] ) do
        local card = Fk:getCardById(id)
        room:setCardMark(card, "@@opend",1)
        room:setCardMark(card, "@@gwisliac",1)
      end
    end
  end,
})

gwisliac:addEffect(fk.AfterCardsMove, {
  -- is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
      for _, move in ipairs(data) do
        if move.from==player and not ( move.toArea==Card.PlayerCard and move.to==player  ) then
          for _, info in ipairs(move.moveInfo) do
            if   (info.fromArea == Card.PlayerHand) and Fk:getCardById(info.cardId):getMark("@@gwisliac")~=0  then
              return true
            end
          end
        end
      end
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room
      for _, move in ipairs(data) do
        if move.from==player and not ( move.toArea==Card.PlayerCard and move.to==player  ) then
          for _, info in ipairs(move.moveInfo) do
            if   (info.fromArea == Card.PlayerHand) and Fk:getCardById(info.cardId):getMark("@@gwisliac")~=0  then
                local card = Fk:getCardById(info.cardId)
                room:setCardMark(card, "@@opend",0)
                room:setCardMark(card, "@@gwisliac",0)
            end
          end
        end
      end
    player:drawCards(2,gwisliac.name)
  end,
})

-- gwisliac:addEffect(fk.AfterDrawNCards, {
--   mute = true,
--   can_trigger = function(self, event, target, player, data)
--     return target == player  
--     and player:hasSkill(gwisliac.name)
--     and not player:isKongcheng()
--   end,
--   on_cost = function(self, event, target, player, data)
--     local room = player.room
--     local result = room:askToYiji(player, {
--       targets = room.alive_players,
--       skill_name = gwisliac.name,
--       min_num = 1,
--       max_num = 999,
--       prompt = "#gwisliac-invoke",
--       cancelable = true,
--       skip = true,
--     })
--     local tos={}
--     local suits={}
--     for pid, ids in pairs(result) do
--       if #ids > 0 then
--         table.insert(tos,room:getPlayerById(pid))
--         for _, id in pairs(ids) do 
--           table.insertIfNeed(suits,Fk:getCardById(id):getSuitString(true))
--         end
--       end
--     end
--     if #tos>0 then
--       table.removeOne(suits,"log_nosuit")
--       event:setCostData(self, {extra_data = result,tos=tos,suits=suits})
--       return true
--     end
--   end,
--   on_use = function(self, event, target, player, data)
--     local room = player.room
--     local result = event:getCostData(self).extra_data
--     local suits =event:getCostData(self).suits
--     -- room:doYiji(result, player, gwisliac.name)  --visible

--     local moveInfos = {}
--     -- local move_ids = {}
--     local playercards = player:getCardIds("he")
--     for to, cards in pairs(result) do
--         cards = table.filter(cards, function (id) return  table.contains(playercards, id) end)
--         if #cards>0 then
--           table.insert(moveInfos, {
--             ids = cards,
--             moveInfo = table.map(cards, function(id)
--               return {cardId = id, fromArea = room:getCardArea(id), fromSpecialName = player:getPileNameOfId(id)}
--             end),
--             from = player,
--             to = to,
--             toArea = Card.PlayerHand,
--             moveReason = fk.ReasonGive,
--             proposer = proposer,
--             skillName = gwisliac.name,
--             -- moveMark = moveMark,
--             visiblePlayers = table.map(room.players,function(p) return p.id end),
--           })
--         end
--     end
--     room:moveCards(table.unpack(moveInfos))
--     if not player.dead then
--       player:drawCards(2*#suits, gwisliac.name)
--       room:setPlayerMark(player, "@@gwisliac-turn",suits)
--     end
--   end,
-- })

-- gwisliac:addEffect("prohibit", {
--   prohibit_use = function(self, player, card)
--     return player:getMark("@@gwisliac-turn") ~= 0 and card and table.contains(player:getMark("@@gwisliac-turn"), card:getSuitString(true))
--   end,
-- })

return gwisliac
