local kaaqszio = fk.CreateSkill {
  name = "kaaqszio",
}

Fk:loadTranslationTable{
  ["kaaqszio"] = "家書",
  [":kaaqszio"] = "主旹,伱選擇1手牌A 1其它角色B 聲名1花色C發動.伱將A交予B,B選擇➀交予伱全部C花手牌(至少1),抽x➁展示全部手牌,弃置与A同花者,流失x體力.(x爲其當次所失牌數)",

  ["#kaaqszio"] = "家書 隨機獲得1此花色坐騎牌",
  ["#kaaqszio-choose"] = "家書 選擇1角色 發動荐馬",

  ["$kaaqszio1"] = "好一匹棗紅馬",
}

kaaqszio:addEffect("active", {
  anim_type = "control",
  prompt = "#kaaqszio",
  -- can_use = function(self, player)
  --   return player:usedSkillTimes(kaaqszio.name, Player.HistoryPhase) == 0
  -- end,
  interaction = function(self)
    return UI.ComboBox {
      choices = {"log_spade", "log_club", "log_heart", "log_diamond"},
    }
  end,
  card_num=1,
  target_num = 1,
  card_filter = function (self, player, to_select, selected)
    return table.contains(player:getCardIds("h"),to_select)
  end,
  target_filter = function (self, player,to_select )
    return to_select~=player
  end,
  on_use = function(self, room, effect)
    -- local suits={"spade", "club", "heart", "diamond"}
    local suit=table.indexOf({"log_spade", "log_club", "log_heart", "log_diamond"}, self.interaction.data)
    local player=effect.from
    -- local pattern =".|.|"..suit
    local to =effect.tos[1]
    room:moveCardTo(effect.cards, Player.Hand, to, fk.ReasonGive, kaaqszio.name, nil, true, player)
    if to.dead then return end
    local cards=table.filter(to:getCardIds("h"),function(id) return Fk:getCardById(id).suit==suit end)

    local all_choices={  "kaaqszio-give" ,"kaaqszio-discard"}
    local choices={}
    if #cards==0 then choices={"kaaqszio-discard"} else choices=all_choices end
    local choice = room:askToChoice(to, {
      choices = choices,
      all_choices=all_choices,
      skill_name = kaaqszio.name,
      prompt = "#kaaqszio-choose",
    })

    -- if #cards==0 then choice="kaaqszio-discard" end

    if choice=="kaaqszio-give" then
      -- if table.contains(to:getCardIds("h"),effect.cards[1]) then  --迻動過?
      --   room:moveCards({
      --     ids = effect.cards,
      --     from = to,
      --     toArea = Card.DrawPile,
      --     moveReason = fk.ReasonPut,
      --     skillName = kaaqszio.name,
      --     drawPilePosition = -1,
      --     moveVisible = true,
      --   })


      --   if to.dead or player.dead then return end
      -- end
      cards=table.filter(to:getCardIds("h"),function(id) return Fk:getCardById(id).suit==suit end)
      --所迻動于操作旹定
      room:moveCardTo(cards, Player.Hand, player, fk.ReasonGive, kaaqszio.name, nil, false, to)
      if to.dead then return end

      local n =0
      local hand =  to:getCardIds("h")
      for _,id in ipairs(cards) do
        if not table.contains(hand,id) then
          n=n+1
        end
      end
      if n==0 then return end
      to:drawCards(n,kaaqszio.name)
    else
      to:showCards(to:getCardIds("h"))
      if to.dead then return end 
      suit=Fk:getCardById(effect.cards[1]).suit
      cards=table.filter(to:getCardIds("h"),function(id) return Fk:getCardById(id).suit==suit end)
      if table.contains(to:getCardIds("h"),effect.cards[1]) then  table.insertIfNeed(cards,effect.cards[1]) end

      room:throwCard(cards,kaaqszio.name, to, to)
      if to.dead then return end 

      -- room:setPlayerMark(to,"@kaaqszio-phase",1)
      -- local n =to:getMark("@kaaqszio_n-phase")
      local n =0
      local hand =  to:getCardIds("h")
      for _,id in ipairs(cards) do
        if not table.contains(hand,id) then
          n=n+1
        end
      end
      if n==0 then return end
      room:loseHp(to,n,kaaqszio.name)

      -- room:setPlayerMark(to,"@kaaqszio-phase",0)
      -- room:setPlayerMark(to,"@kaaqszio_n-phase",0)
    end
  end,
})

-- kaaqszio:addEffect(fk.AfterCardsMove, {
--   can_refresh = function(self, event, target, player, data)
--     if  player:getMark("@kaaqszio-phase")==0  then return end
--       local n=0
--       for _, move in ipairs(data) do
--         if move.moveReason==fk.ReasonDiscard and move.skillName== kaaqszio.name and  move.from ==player  then
--           for _, info in ipairs(move.moveInfo) do
--             if info.fromArea==Card.PlayerHand or  info.fromArea==Card.PlayerEquip then
--               n=n+1
--               player:drawCards(19)
--             end
--           end
--         end
--       end
--       if n>0 then
--         event:setCostData(self,{n=n})
--         return true
--       end
--   end,
--   on_refresh= function(self, event, target, player, data)
--     player.room:setPlayerMark(player,"@kaaqszio_n-phase",event:getCostData(self).n)
--   end,
-- })
return kaaqszio
