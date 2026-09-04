local krachbuac = fk.CreateSkill {
  name = "krachbuac",
}

Fk:loadTranslationTable{
  ["krachbuac"] = "警防",
  -- [":krachbuac"] = "伱受傷後x次,伱可選脚色1手牌發動.伱展示之,其視爲閃至其離開手牌區.",--不能弃
  [":krachbuac"] = "伱1脚色受傷後,伱可選1脚色(需伱至二者距離不大于1)發動｡1轉內,其每手牌視爲護｢防患未肰｣(若爲｢殺｣致傷則爲護｢閃｣)",

  -- ["#krachbuac-invoke"] = "警防：選擇任1手牌",

  ["#krachbuac-invoke"] = "警防：選擇目幖",
  ["@@krachbuac-turn"] = "警防",
  -- ["@@krachbuac-hand"] = "警防",

  ["$krachbuac1"] = "事已至此，当思后策。",
  ["$krachbuac2"] = "休养生息，无碍徐图天下。",
}

krachbuac:addEffect(fk.Damaged, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(krachbuac.name) and player:compareDistance(data.to , 1, "<=") 
  end,
  -- trigger_times=  function(self, event, target, player, data)
  --   return data.damage
  -- end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local targets = table.filter(room.alive_players, 
      function(p)
      return player:compareDistance(p , 1, "<=") 
      end)
    local tos = player.room:askToChoosePlayers(player, {
      targets = targets,
      min_num = 1,
      max_num = 1,
      prompt = "#krachbuac-invoke",
      skill_name = krachbuac.name,
      cancelable = true,
    })
    if #tos>0 then
        event:setCostData(self, {tos=tos})
        return true
    end
  end,
  on_use = function(self, event, target, player, data)

    player.room:setPlayerMark(event:getCostData(self).tos[1],"@@krachbuac_ssaet-turn", data.card and data.card.trueName=="ssaet" and 1 or 2)

  end,
})

krachbuac:addEffect("filter", {
  card_filter = function(self, to_select, player)
    return player:getMark("@@krachbuac_ssaet-turn")>0 
  end,
  view_as = function(self, player, to_select)
    local card = Fk:cloneCard(player:getMark("@@krachbuac_ssaet-turn")==1 and  "hand__szjemh" or "hand__buac_hzfan_mujs_nzjen", to_select.suit, to_select.number)
    card.skillName = krachbuac.name
    return card
  end,
})
-- krachbuac:addEffect(fk.Damaged, {
--   anim_type = "support",
--   can_trigger = function(self, event, target, player, data)
--     return player:hasSkill(krachbuac.name) and data.to == player 
--   end,
--   -- trigger_times=  function(self, event, target, player, data)
--   --   return data.damage
--   -- end,
--   on_cost = function(self, event, target, player, data)
--     local room = player.room
--     local targets = table.filter(room.alive_players, 
--       function(p)
--       return not p:isKongcheng() and  p~=player
--       end)
--       local tos, cards =  room:askToChooseCardsAndPlayers(player, {
--         min_card_num = 0,
--         max_card_num = 1,
--         min_num = 0,
--         max_num = 1,
--         targets = targets,
--         prompt = "#krachbuac-invoke",
--         skill_name = krachbuac.name,
--         will_throw = false,
--         pattern=".",
--         cancelable = true,
--       })

--       if #cards>0 then
--         event:setCostData(self, {cards=cards, tos={player}})
--         return true
--       elseif #tos>0 then 
--         local get = room:askToChooseCard(player,{
--           target = tos[1],
--           flag = "he",
--           skill_name = krachbuac.name,
--           })
--         event:setCostData(self, {cards={get}, tos=tos})
--         return true
--       end
--   end,
--   on_use = function(self, event, target, player, data)
--     local cards =event:getCostData(self).cards
--     local to =event:getCostData(self).tos[1]
--     to:showCards(cards)
--     player.room:setCardMark(Fk:getCardById(cards[1]) ,"@@krachbuac-hand",1)
--     Fk:filterCard(cards[1],to)
--   end,
-- })

-- krachbuac:addEffect("filter", {
--   card_filter = function(self, to_select, player)
--     return to_select:getMark("@@krachbuac-hand")>0
--   end,
--   view_as = function(self, player, to_select)
--     local card = Fk:cloneCard("szjemh", to_select.suit, to_select.number)
--     card.skillName = krachbuac.name
--     return card
--   end,
-- })

return krachbuac
