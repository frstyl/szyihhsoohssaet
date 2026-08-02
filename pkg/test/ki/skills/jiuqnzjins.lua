local jiuqnzjins = fk.CreateSkill {
  name = "jiuqnzjins",
}

Fk:loadTranslationTable{
["jiuqnzjins"] = "游刃",
[":jiuqnzjins"] = "一脚色起動牌旹,若處理區爲伱所起動之牌(子牌),伱可選處理區1牌(轉化前子牌)非伱用者發動,伱取得之",
["#jiuqnzjins-invoke"]="游刃 選擇1牌取得 ",

}


jiuqnzjins:addEffect(fk.CardUsing, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if player:hasSkill(jiuqnzjins.name) and #player.room.processing_area>1 then
      -- if data.from==player then return true end
      local room=player.room
      local e=player.room.logic:getCurrentEvent()
      while true do
        if e==nil then return end

        if  e.data.from==player and #room:getSubcardsByRule(e.data.card, { Card.Processing })>0 then
          return true 
        end
        
        e=e:findParent(GameEvent.UseCard,false)
        
      end

    end
  end,
  on_cost = function(self, event, target, player, data)
    local room=player.room
    local cards= {}
    local e=player.room.logic:getCurrentEvent()
    while e do
      if e.data.from~=player then
        table.insertTable(cards, room:getSubcardsByRule(e.data.card, { Card.Processing }))  --應該還檢測是否迻動過
      end
      e=e:findParent(GameEvent.UseCard,false)
    end
   if #cards==0 then return end
   
    local ids, choice = player.room:askToChooseCardsAndChoice(player, {
      cards = cards,
      min_num = 1,
      max_num = 1,
      skill_name = jiuqnzjins.name,
      prompt = "#jiuqnzjins-invoke",
      cancel_choices = {"Cancel"}
    })
    if choice=="Cancel" or #ids==0 then return end
    event:setCostData(self, { cards = ids})
    return true
  end,
  on_use = function(self, event, target, player, data)
    player.room:obtainCard(player, event:getCostData(self).cards, true, fk.ReasonPrey, player, jiuqnzjins.name)
  end,
})

-- jiuqnzjins:addEffect(fk.AfterCardsMove, {
--   anim_type = "drawcard",
--   can_refresh= function(self, event, target, player, data)
--     return player:hasSkill(jiuqnzjins.name,true)
--   end,
--   on_refresh= function(self, event, target, player, data)
--     if #player.room.processing_area == 0 then     player.room:setPlayerMark(player,"jiuqnzjins-phase",nil) return end
--     local t =player:getTableMark("jiuqnzjins-phase") --不應有牌停留超過phase
--     for _, move in ipairs(data) do
--       if  move.toArea== Card.Processing then
--         if move.proposer==player then
--           for _, info in ipairs(move.moveInfo) do
--             table.insert(t, info.cardId)
--           end
--         elseif   move.moveReason == fk.ReasonResponse or  move.moveReason== fk.ReasonUse then

--           local room=player.room
--           local e =room.logic:getCurrentEvent().parent
--           if not (e and e.data and e.data.card and e.data.from==player) then  return end
--           local realCardIds =room:getSubcardsByRule(e.data.card, { Card.Processing })
--           for _, info in ipairs(move.moveInfo) do
--             if table.contains(realCardIds,info.cardId) then
--               table.insert(t, info.cardId)
--             end
--           end
--         end
--       else
--         for _, info in ipairs(move.moveInfo) do
--           if info.fromArea==Card.Processing then --防處理區牌被它人得又進入處理區--銷毀 ?
--             table.removeOne(t, info.cardId)
--           end
--         end
--       end
--     end
--     player.room:setPlayerMark(player,"jiuqnzjins-phase",#t~=0 and t or nil)
--   end,
--   can_trigger = function(self, event, target, player, data)  --trigger旹判斷處理區牌來源?
--     return player:hasSkill(jiuqnzjins.name)
--     and table.find(player.room.processing_area,function(id)
--     return table.contains(player:getTableMark("jiuqnzjins-phase"),id)
--    end)
--   end,
--   on_cost = function(self, event, target, player, data)
--     local cards= table.filter(player.room.processing_area,function(id)
--     return not table.contains(player:getTableMark("jiuqnzjins-phase"),id)
--    end)
--    if #cards==0 then return end
--       local ids, choice = player.room:askToChooseCardsAndChoice(player, {
--         cards = cards,
--         min_num = 1,
--         max_num = 1,
--         skill_name = jiuqnzjins.name,
--         prompt = "#jiuqnzjins-invoke",
--         cancel_choices = {"Cancel"}
--       })
--       if choice=="Cancel" or #ids==0 then return end
--       event:setCostData(self, { cards = ids})
--       return true
--   end,
--   on_use = function(self, event, target, player, data)
--     player.room:obtainCard(player, event:getCostData(self).cards, true, fk.ReasonPrey, player, jiuqnzjins.name)
--   end,
-- })




return jiuqnzjins
