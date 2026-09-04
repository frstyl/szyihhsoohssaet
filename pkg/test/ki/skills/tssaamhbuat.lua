local tssaamhbuat = fk.CreateSkill({
  name = "tssaamhbuat",
})

Fk:loadTranslationTable{
  ["tssaamhbuat"] = "斬伐",
  [":tssaamhbuat"] = "伱指定｢殺｣目幖A後伱可發動.伱選擇伱与A合計至多x牌,伱与目幖各褈鑄被選擇牌,其每有1褈鑄牌花色含于伱褈鑄,此起動對其傷害基數+1｡x爲A體力上限)",
  -- [":tssaamhbuat"] = "伱起動｢殺｣旹伱可發動.伱預測牌堆頂x牌花色,亮出牌堆頂x牌,每預測成功此次傷害基數+1.將所亮出牌置入弃牌堆(x爲伱體力上限)",

  -- ["@tssaamhbuatRecord"] = "斬伐",
  -- ["#tssaamhbuat_filter"] = "斬伐",
  -- ["#tssaamhbuat-choose"] = "斬伐 預測 緟第 %arg 牌花色",
  ["#tssaamhbuat-choose:"] = "斬伐 選擇 %arg 牌",

  ["$tssaamhbuat1"] = "矢贯坚石，劲冠三军！",
  ["$tssaamhbuat2"] = "吾虽年迈，箭矢犹锋！",
}

tssaamhbuat:addEffect(fk.TargetConfirmed, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return
      data.from == player 
      and
      player:hasSkill(tssaamhbuat.name) 
      and  data.card.trueName == "ssaet"
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    if player.dead then return end
    local to=data.to
    local player_hands = player:getCardIds("he")
    local to_hands = to:getCardIds("he")
      -- local cards = room:askToChooseCards( player, {  --魄襲
      --   target = target,
      --   min = 1,
      --   max = to.maxHp,
      --   -- flag = "he",
      --   flag = { card_data = {
      --     { player.general, player_hands },{to.general, to_hands}
      -- } },  --可見
      --   skill_name = tssaamhbuat.name,
      --   prompt = "#tssaamhbuat-choose:::"..to.maxHp,
      -- })
      local visible_data={}
      for _, id in ipairs(to_hands) do
        if not player:cardVisible(id) then
          visible_data[tostring(id)] = false --string??
        end
      end
    local cards = room:askToPoxi(player, {
      poxi_type = "AskForCardsChosen",
      data = {
          { player.general, player_hands },
          {to.general, to_hands},
      },
      extra_data = {
        min = 1,  
        max = to.maxHp,
        skillName = tssaamhbuat.name,
        prompt = "#tssaamhbuat-choose:::"..to.maxHp,
        visible_data=visible_data
      },
      cancelable = false,
    })
    local cards1 = table.filter(cards, function(id) return table.contains(player_hands, id) end)
    local cards2 = table.filter(cards, function(id) return table.contains(to_hands, id) end)

    if #cards1>0 and #cards2>0 then
      local n =0
      local suits ={}
      for _, id in ipairs (cards1) do
        local suit =Fk:getCardById(id).suit
        if suit~=Card.NoSuit then table.insertIfNeed(suits,suit) end
      end    
      for _, id in ipairs (cards2) do
        if table.contains(suits, Fk:getCardById(id).suit) then n=n+1 end
      end
      data.additionalDamage=(data.additionalDamage or 0 )+n
    end
    if not player.dead and #cards1>0 then
      room:recastCard(cards1, player, tssaamhbuat.name)
    end
    if not to.dead and #cards2>0  then
    room:recastCard(cards2, to, tssaamhbuat.name)
    end
  end,
})

-- tssaamhbuat:addEffect(fk.CardUsing, {
--   anim_type = "offensive",
--   can_trigger = function(self, event, target, player, data)
--     return
--       target == player and
--       player:hasSkill(tssaamhbuat.name) and
--       data.card.trueName == "ssaet"
--   end,
--   on_use = function(self, event, target, player, data)
--     ---@type string
--     local skillName = tssaamhbuat.name
--     local room = player.room

--     local suits={ "log_spade", "log_club", "log_heart", "log_diamond" }
--     local choices = {}
--     local n = player.maxHp
--     for i=1,n,1 do

--     local choice = room:askToChoice(player, { choices = suits, skill_name = skillName ,prompt = "#tssaamhbuat-choose:::"..i,})
--       table.insert(choices,choice)
--     end


--       local cards = room:getNCards(n)
--       room:moveCardTo(cards, Card.Processing, nil, fk.ReasonPut, skillName, nil, true, player.id)
--       data.additionalDamage = data.additionalDamage or 0
--       for i, id in ipairs(cards) do
--         if  Fk:getCardById(id):getSuitString(true) == choices[i] then
--           room:setCardEmotion(id, "judgegood")
--           data.additionalDamage = data.additionalDamage + 1
--         else
--           room:setCardEmotion(id, "judgebad")
--         end
--         room:delay(200)
--       end
--       room:moveCardTo(cards, Card.DiscardPile, nil, fk.ReasonPutIntoDiscardPile, skillName)

--   end,
-- })

-- -- ssaocqlioc:addEffect(fk.TargetConfirmed, {
-- --   anim_type = "offensive",
-- --   can_trigger = function(self, event, target, player, data)
-- --     return data.from  == player and player:hasSkill(ssaocqlioc.name) and
-- --       table.contains({ "ssaet"}, data.card.trueName)
-- --       and #table.filter(player.room:getOtherPlayers(player), function (p)
-- --         return player:inMyAttackRange(p) 
-- --       end) <3
-- --   end,
-- --   on_use = function(self, event, target, player, data)
-- --     data:setResponseTimes(data:getResponseTimes(to)+1, data.to)  --1?
-- --   end,
-- -- })

return tssaamhbuat
