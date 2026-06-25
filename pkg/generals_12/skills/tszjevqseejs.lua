local tszjevqseejs = fk.CreateSkill{
  name = "tszjevqseejs",
}


Fk:loadTranslationTable{
  ["tszjevqseejs"] = "招𱙝",
  [":tszjevqseejs"] = "伱預段始旹,可選1其它角色A發動.伱判定,判定牌生效後,若其爲{紅/黑},{伱/A}獲得之,若此次流程未有3張連續同色且A未死亾,伱可再次執行｡",--平均7 但可能離譜

  ["#tszjevqseejs-invoke"] = "招𱙝 選擇目幖",

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
    local to = event:getCostData(self).tos[1]
    room:setPlayerMark(player,"tszjevqseejs-phase", to.id)
    local t={}

    while true do
      local judge = {
        who = player,
        reason = tszjevqseejs.name,
        pattern = ".|.|diamond,spade,club,heart",
      }
      room:judge(judge)
      if player.dead or to.dead   then return end 
      table.insert(t,judge.card.color)
      local n = #t
      if n>2 and t[n]==t[n-1] and t[n-1]==t[n-2] then return end
      if not room:askToSkillInvoke(player, { skill_name = tszjevqseejs.name })  then return end
    end
end,
})

tszjevqseejs:addEffect(fk.FinishJudge, {
  mute = true,
  is_delay_effect = true,
  can_trigger = function(self, event, target, player, data)
    if  target == player 
    and data.reason == tszjevqseejs.name
    and player.room:getCardArea(data.card) == Card.Processing 
    then
      if  data.card.color== Card.Red and not player.dead then
        event:setCostData(self,{tos={player}})
        return true 
      elseif   data.card.color== Card.Black then
        local to =player.room:getPlayerById(player:getMark("tszjevqseejs-phase"))
        if to and not to.dead then
          event:setCostData(self,{tos={to}})
          return true 
        end

      end
    end    

  end,
  on_use = function(self, event, target, player, data)
    local to =event:getCostData(self).tos[1]
    player.room:obtainCard(to, data.card, true, fk.ReasonJustMove, nil, tszjevqseejs.name)
  end,
})


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
--       room:moveCardTo(cardsJudged, Card.DiscardPile, nil, fk.ReasonPutIntoDiscardPile, tszjevqseejs.name, nil, true, nil)  --非判定
--     else
--       room:obtainCard(player, cardsJudged, true, fk.ReasonJustMove)
--     end
--   end,
-- })


return tszjevqseejs
