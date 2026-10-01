local tszjevqseejs = fk.CreateSkill{
  name = "tszjevqseejs",
}


Fk:loadTranslationTable{
  ["tszjevqseejs"] = "招𱙝",
  [":tszjevqseejs"] = "伱預段始旹,可選1其它脚色A發動.伱占卜,占卜畱于處理區,若未有3張連續同色伱可再執行或令分配之,伱得紅A得黑,已此所得牌1輪內无視額定弃牌",--平均7 但可能離譜

  ["#tszjevqseejs-invoke"] = "招𱙝 選擇目幖",
  ["@@tszjevqseejs-inhand-round"] = "招𱙝",

  ["$tszjevqseejs1"] = "髣髴兮若轻云之蔽月。",
  ["$tszjevqseejs2"] = "飘飖兮若流风之回雪。",
}
tszjevqseejs:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(tszjevqseejs.name) and player.phase == Player.Start
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local to = room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = player.room:getOtherPlayers(player),
      skill_name = tszjevqseejs.name,
      prompt = "#tszjevqseejs-invoke",
      cancelable = true,
    })
    if #to > 0 then
      event:setCostData(self, {tos = to})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    
    room.logic:getCurrentEvent():addCleaner(function()
      room:cleanProcessingArea(nil, tszjevqseejs.name)
    end)

    local to = event:getCostData(self).tos[1]
    room:setPlayerMark(player,"tszjevqseejs-phase", to.id)
    local t={}
    -- local exe 
    while true do
      local judge = {
        who = player,
        reason = tszjevqseejs.name,
        pattern = ".|.|diamond,spade,club,heart",
        skipDrop=true,
      }
      room:judge(judge)
      if player.dead or to.dead   then return end 
      table.insert(t,judge.card)

      local n = #t
      if n>2 and t[n].color==t[n-1].color and t[n-1].color==t[n-2].color then return end
      if not room:askToSkillInvoke(player, { skill_name = tszjevqseejs.name })  then 
        -- exe=true
        break
      end
    end


      local reds={}
      local blacks={}
      for _,card in ipairs(t) do
        if room:getCardArea(card) == Card.Processing then
          if card.color==Card.Red then 
            table.insertTable(reds, Card:getIdList(card))
          elseif card.color==Card.Black then 
            table.insertTable(blacks, Card:getIdList(card))
          end
        end
      end
      if #reds>0 or #blacks>0 then
        local list={}
        list[player.id]=reds
        list[to.id]=blacks
      room:doYiji(list, nil, tszjevqseejs.name, {"@@tszjevqseejs-inhand-round",1 , "exclude-inhand-round",1})
      end

end,
})

-- tszjevqseejs:addEffect(fk.FinishJudge, {
--   mute = true,
--   is_delay_effect = true,
--   can_trigger = function(self, event, target, player, data)
--     if  target == player 
--     and data.reason == tszjevqseejs.name
--     and player.room:getCardArea(data.card) == Card.Processing 
--     then
--       if  data.card.color== Card.Red and not player.dead then
--         event:setCostData(self,{tos={player}})
--         return true 
--       elseif   data.card.color== Card.Black then
--         local to =player.room:getPlayerById(player:getMark("tszjevqseejs-phase"))
--         if to and not to.dead then
--           event:setCostData(self,{tos={to}})
--           return true 
--         end

--       end
--     end    

--   end,
--   on_use = function(self, event, target, player, data)
--     local to =event:getCostData(self).tos[1]
--     player.room:obtainCard(to, data.card, true, fk.ReasonPrey, nil, tszjevqseejs.name)
--   end,
-- })


-- tszjevqseejs:addEffect(fk.EventPhaseStart, {
--   anim_type = "drawcard",
--   can_trigger = function(self, event, target, player, data)
--     return target == player and player:hasSkill(tszjevqseejs.name) and player.phase == Player.Start
--   end,
--   on_cost = function(self, event, target, player, data)
--     local room = player.room
--     local to = room:askToChoosePlayers(player, {
--       min_num = 1,
--       max_num = 1,
--       targets = player.room:getOtherPlayers(player),
--       skill_name = tszjevqseejs.name,
--       prompt = "#tszjevqseejs-choose",
--       cancelable = true,
--     })
--     if #to > 0 then
--       event:setCostData(self, {tos = to})
--       return true
--     end
--   end,
--   on_use = function(self, event, target, player, data)
--     local room = player.room
--     local to =event:getCostData(self).tos[1]
--     local cardsJudged = {}
--     local cardsJudgedBlack = {}
--     local cardsJudgedRed = {}
--     local i=1
--     while true do
--       if not i<=3 then return end
--       local judge = {
--         who = player,
--         reason = tszjevqseejs.name,
--         pattern = ".|.|spade,club,heart,diamond",
--         skipDrop = true,
--       }
--       room:judge(judge)
--       local card = judge.card
--       table.insert(cardsJudged, card.id)
--       if card.color == Card.Black then
--         table.insert(cardsJudgedBlack, card.id)
--       elseif card.color == Card.Red then
--         table.insert(cardsJudgedRed, card.id)
--       end
--       if player.dead then goto clear end --无後續
--       i=i+1
--     end

--     ::clear::
--     cardsJudged = table.filter(cardsJudged, function (id)
--       return room:getCardArea(id) ==  Card.Processing
--     end)
--     cardsJudged = player.room.logic:moveCardsHoldingAreaCheck(cardsJudged)

--     if #cardsJudged==0 then return end
--     if player.dead then 
--       room:moveCardTo(cardsJudged, Card.DiscardPile, nil, fk.ReasonPutIntoDiscardPile, tszjevqseejs.name, nil, true, nil)  --非占卜
--     else
--       room:obtainCard(player, cardsJudged, true, fk.ReasonPrey)
--     end
--   end,
-- })


return tszjevqseejs
