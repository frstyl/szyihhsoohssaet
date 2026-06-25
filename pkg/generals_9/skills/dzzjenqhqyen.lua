
local dzzjenqhqyen = fk.CreateSkill {
  name = "dzzjenqhqyen",
}

Fk:loadTranslationTable{
  ["dzzjenqhqyen"] = "嬋娟",
  [":dzzjenqhqyen"] = "<font color='red'>♥</font>牌A因{弃置/判定}進入弃牌堆後(多牌則每牌1次),伱可發動,伱抽1,若A仍在弃牌堆(未迻動)伱可打出1牌將A交与一角色.", --➁伱<font color='red'>♥</font>牌A因弃置進入弃牌堆後,伱可發動.分配之

  ["#dzzjenqhqyen-invoke"] = "嬋娟 是否發動",
  ["#dzzjenqhqyen-choose"] = "嬋娟 分配牌",

  ["$dzzjenqhqyen1"] = "旅人多西望， 客雁難南歬",
  ["$dzzjenqhqyen2"] = "霜露結瑤華， 煙波勞玉指",
}

-- dzzjenqhqyen:addAcquireEffect(function (self, player)
--     player.room:handleAddLoseSkills(player, "dzzjenqhqyen&", dzzjenqhqyen.name, false, true)
-- end)
-- dzzjenqhqyen:addLoseEffect(function (self, player)
--     player.room:handleAddLoseSkills(player, "-dzzjenqhqyen&", dzzjenqhqyen.name, false, true)
-- end)

dzzjenqhqyen:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(dzzjenqhqyen.name)  --不需牌在處理區
  end,
  trigger_times = function(self, event, target, player, data)  --單人單旹次數 未指定player 多次觸發
    if not player:hasSkill(dzzjenqhqyen.name) then return 0 end
      local ids = {}
      local check =function(id)
        if Fk:getCardById(id).suit == Card.Heart  then
          table.insertIfNeed(ids, id)
        end
      end

      for _, move in ipairs(data) do
        if move.toArea == Card.DiscardPile then  --褈鑄 拼點 廢除 亮出 頂裝僃 延旹牌  --{fk.ReasonJudge,fk.ReasonDiscard,fk.ReasonPut, fk.ReasonPutIntoDiscardPile,fk.ReasonJustMove}
          if move.moveReason==fk.ReasonDiscard and move.moveReason==fk.ReasonJudge  then 
            for _, info in ipairs(move.moveInfo) do
              -- if move.from==nil or move.from ~= player  or (info.fromArea ~= Card.PlayerHand and info.fromArea ~= Card.PlayerEquip) then
                check(info.cardId)
              -- end
            end
          -- else
          --   local e= player.room.logic:getCurrentEvent().parent
          --   if not (e and (e.event == GameEvent.UseCard or e.event == GameEvent.RespondCard ) and e.data and e.data.card:isVirtual()~=true ) then
          --     for _, info in ipairs(move.moveInfo) do
          --       check(info.cardId)
          --     end
          --   end

          end
        end
      end


    if  #ids > 0 then
      event:setCostData(self, {ids = ids})
      return #ids
    else
      -- event:setCostData(self, nil)
      return 0
    end

  end,
  on_cost = function(self, event, target, player, data)
   if player.room:askToViewCardsAndChoice(player, {  --askToChooseCardsAndChoice askToCards
        cards = event:getCostData(self).ids,
        choices = { "OK", "Cancel" },
        skill_name = dzzjenqhqyen.name,
        prompt = "#dzzjenqhqyen-invoke"
      }) == "OK" then
        return true
      end
  end,
  on_use = function(self, event, target, player, data)
    local costdata=event:getCostData(self)
    local room=player.room
    player:drawCards(1, dzzjenqhqyen.name)
    if player.dead then return end

    local ids=costdata.ids
    ids = table.filter(ids, function (id)  --simpleClone
      return table.contains(player.room.discard_pile, id)
    end)
    ids = player.room.logic:moveCardsHoldingAreaCheck(ids)
    if #ids==0 then return end

    local yes, dat = room:askToUseActiveSkill(player, { --active 中有discard_pile檢測
      skill_name = "dzzjenqhqyen_active",
      prompt = "#dzzjenqhqyen-choose",
      cancelable = true,
      skip = true,  --不執行
      extra_data = {
        expand_pile = ids
      },
      --  = {ids=ids},
    })
    if not yes or not dat or not dat.cards or not dat.cards[1] then 
      table.remove(costdata.ids, 1)  --1号
      event:setCostData(self, {n=costdata.n, ids=costdata.ids})
    return 
    end
    
    table.remove(costdata.ids, table.indexOf(costdata.ids, dat.cards[1]))
    event:setCostData(self, {n=costdata.n, ids=costdata.ids})


    if  #dat.targets~=1 or #dat.cards~=2
    or room:getCardArea(dat.cards[1])~=Card.DiscardPile 
    -- or room:getPlayerById(dat.tos[1]).dead
    then return end

    room:responseCard({
        card=Fk:getCardById(dat.cards[2]),
        from=player,
        attachedSkillAndUser={muteCard=true},
      })
    if  dat.targets[1].dead then return end
    room:moveCardTo({dat.cards[1]}, Card.PlayerHand, dat.targets[1], fk.ReasonGive, dzzjenqhqyen.name, nil, true, player)

  end,
})

-- dzzjenqhqyen:addEffect(fk.AfterCardsMove, {
--   anim_type = "drawcard",
--   can_trigger = function(self, event, target, player, data)
--     if not player:hasSkill(dzzjenqhqyen.name) then return end

--     local ids={}


--       for _, move in ipairs(data) do
--         if move.from == player 
--           -- and  move.moveReason==fk.ReasonDiscard
--           and move.toArea == Card.DiscardPile
--         then
--           for _, info in ipairs(move.moveInfo) do
--             if (info.fromArea == Card.PlayerHand or info.fromArea == Card.PlayerEquip) then
--               if Fk:getCardById(info.cardId).suit == Card.Heart then
--                 table.insertIfNeed(ids, info.cardId)
--               end
--             end
--           end
--         end
--       end

--       --  if #ids ==0 then return end
--     ids = table.filter(ids, function (id)
--       return table.contains(player.room.discard_pile, id)
--     end)
--     ids = player.room.logic:moveCardsHoldingAreaCheck(ids)
--     if  #ids > 0 then
--       event:setCostData(self, {ids = ids})
--       return true
--     end
--   end,
--   on_cost = function(self, event, target, player, data)
--    if player.room:askToViewCardsAndChoice(player, {  --askToChooseCardsAndChoice askToCards
--         cards = event:getCostData(self).ids,
--         choices = { "OK", "Cancel" },
--         skill_name = skillName,
--         prompt = "#dzzjenqhqyen-choose"
--       }) == "OK" 
--     then
--       return true
--     end
--   end,
--   on_use = function(self, event, target, player, data)  --可以不給?
--     player.room:askToYiji(player,{
--       targets=player.room:getOtherPlayers(player),
--       cards=event:getCostData(self).ids,
--       expand_pile=event:getCostData(self).ids,
--       skip=false,
--     })
--     -- player.room:doYiji(event:getCostData(self).t, player, dzzjenqhqyen.name)
--   end,
-- })

return dzzjenqhqyen
