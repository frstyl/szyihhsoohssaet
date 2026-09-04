
local zjimqhsfa = fk.CreateSkill {
  name = "zjimqhsfa",
}

Fk:loadTranslationTable{
  ["zjimqhsfa"] = "尋花",
  [":zjimqhsfa"] = "其它腳色轉內,其它腳色區域之<font color='red'>♥</font>牌進入處理區或弃牌堆後多次(未迻動),伱可選擇其中1牌發動,伱取得之,1轉內當轉腳色至伱距離-1",

  ["#zjimqhsfa-choose"] = "尋花 取得牌",

  ["@zjimqhsfa-turn"] = "尋花",

  ["$zjimqhsfa1"] = "小人終日挂念娘子 甚是苦也",
}

-- zjimqhsfa:addAcquireEffect(function (self, player)
--     player.room:handleAddLoseSkills(player, "zjimqhsfa&", zjimqhsfa.name, false, true)
-- end)
-- zjimqhsfa:addLoseEffect(function (self, player)
--     player.room:handleAddLoseSkills(player, "-zjimqhsfa&", zjimqhsfa.name, false, true)
-- end)

zjimqhsfa:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(zjimqhsfa.name)
    and player.room:getCurrent()
    and player.room:getCurrent()~=player
    and player.room:getCurrent():isFemale()
  end,
  trigger_times = function(self, event, target, player, data)  --單人單旹次數 未指定player 多次觸發
    return 999
  end,
  -- on_trigger = function(self, event, target, player, data)
  --   local ids = {}
  --   if event:getCostData(self) and  event:getCostData(self).ids then ids = event:getCostData(self).ids 
  --   else
    
  --   end
  --     local check =function(info)
  --       if 
  --       -- table.contains({Card.PlayerHand, Card.PlayerEquip,  Card.PlayerJudge, }, info.fromArea)  --每張都褈複讀寫
  --       -- and
  --        Fk:getCardById(info.cardId).suit == Card.Heart  then
  --         table.insert(ids, info.cardId)
  --       end
  --     end

  --     for _, move in ipairs(data) do --formArea toArea from to
  --       if move.from and move.from ~=player  
  --         and (move.toArea == Card.DiscardPile or move.toArea == Card.Processing )then
  --             for _, info in ipairs(move.moveInfo) do
  --               check(info)
  --             end
  --       end
  --       -- end
  --     end

  --   -- ids = table.filter(ids, function (id)  --simpleClone
  --   --   return table.contains(player.room.discard_pile, id)
  --   -- or table.contains(player.room.Processing, id)
  --   -- end)
  --   ids = player.room.logic:moveCardsHoldingAreaCheck(ids)
  --   if #ids==0 then return end
  --   return true

  -- end,
  on_cost = function(self, event, target, player, data)
    -- local ids =event:getCostData(self).ids
    local ids = {}
    if event:getCostData(self) and  event:getCostData(self).ids then ids = event:getCostData(self).ids 
    else
    
      local check =function(info)
        if 
        -- table.contains({Card.PlayerHand, Card.PlayerEquip,  Card.PlayerJudge, }, info.fromArea)  --每張都褈複讀寫
        -- and
        info.fromArea~=Card.PlayerSpecial
        and
         Fk:getCardById(info.cardId).suit == Card.Heart  then
          table.insert(ids, info.cardId)
        end
      end

      for _, move in ipairs(data) do --formArea toArea from to
        if move.from and move.from ~=player  
          and (move.toArea == Card.DiscardPile or move.toArea == Card.Processing )then
              for _, info in ipairs(move.moveInfo) do
                check(info)
              end
        end
        -- end
      end

    end
    -- ids = table.filter(ids, function (id)  --simpleClone
    --   return table.contains(player.room.discard_pile, id)
    -- or table.contains(player.room.Processing, id)
    -- end)
    ids = player.room.logic:moveCardsHoldingAreaCheck(ids)
    if #ids==0 then return end

    -- local cards, choice = player.room:askToChooseCardsAndChoice(player, {
    --     cards = ids,
    --     min_num = 0,
    --     max_num = 1,
    --     skill_name = zjimqhsfa.name,
    --     prompt = "#zjimqhsfa-choose",
    --     cancel_choices = {"Cancel"}
    --   })
    -- if choice=="Cancel" or #ids==0 then return end
    local cards = player.room:askToChooseCards(player, {
      min=0,
      max=1,
      cancelable=true,
        target = player,
        flag = { card_data = {
          { "zjimqhsfa", ids }
        } },
        skill_name = zjimqhsfa.name,
        prompt = "#zjimqhsfa-choose",
      })
    if #cards>0 then
      event:setCostData(self, {ids=ids,  cards = cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    player.room:obtainCard(player, event:getCostData(self).cards, true, fk.ReasonPrey, player, zjimqhsfa.name)
    player.room:addPlayerMark(player, "@zjimqhsfa-turn",1)

  end,
})

zjimqhsfa:addEffect("distance", {
  correct_func = function(self, from, to)
    if from==Fk:currentRoom():getCurrent() and to:getMark("@zjimqhsfa-turn")~=0 then
      return -to:getMark("@zjimqhsfa-turn")
    end
  end,
})


return zjimqhsfa
