local muohbaoch = fk.CreateSkill {
  name = "muohbaoch",
}

Fk:loadTranslationTable{
  ["muohbaoch"] = "舞棒",
  [":muohbaoch"] = "武器牌A不經由伱進入弃牌堆後(多牌則每牌1次),伱可發動.伱獲得A",--(多牌止發動1次,選擇其中任意張)  --不屬于伱且不爲使用打出

  ["#muohbaoch-choose"] = "舞棒：選牌",
  ["get_all"] = "全部獲得",
  ["@@muohbaoch-inhand"] = "舞棒",

  ["$muohbaoch1"] = "若位敎頭再來點撥",
}

muohbaoch:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(muohbaoch.name) then return end
      local ids = {}
      local check =function(id)
        if Fk:getCardById(id).sub_type == Card.SubtypeWeapon then
          table.insertIfNeed(ids, id)
        end
      end

      for _, move in ipairs(data) do
        if move.toArea == Card.DiscardPile then
          if  move.moveReason~=fk.ReasonUse and move.moveReason~=fk.ReasonResponse then  --move.moveReason == fk.ReasonDiscard and
            for _, info in ipairs(move.moveInfo) do
              if move.from==nil or move.from ~= player  or (info.fromArea ~= Card.PlayerHand and info.fromArea ~= Card.PlayerEquip) then
                check(info.cardId)
              end
            end
          else  --因使用打出自處理區進入弃牌堆
            local e= player.room.logic:getCurrentEvent().parent
            if not (e and (e.event == GameEvent.UseCard or e.event == GameEvent.RespondCard) and e.data and e.data.from==player) then
              for _, info in ipairs(move.moveInfo) do
                check(info.cardId)
              end
            end

          end
        end
      end

      --   for _, move in ipairs(e.data) do
      --     for _, info in ipairs(move.moveInfo) do
      --       table.removeOne(ret, info.cardId)
      --     end
      --   end
      --   return (#ret == 0)
      -- end, event.id)

      ids = table.filter(ids, function (id)
        return table.contains(player.room.discard_pile, id)
      end)
      ids = player.room.logic:moveCardsHoldingAreaCheck(ids)
      if #ids > 0 then
        event:setCostData(self, {ids = ids})
        return true
      end
    
  end,
  on_trigger = function(self, event, target, player, data)  --止選一次 
    local ids=event:getCostData(self) and event:getCostData(self).ids
    if not ids then return end
    local room=player.room
    local cards, choice = room:askToChooseCardsAndChoice(player, {
      cards = ids,
      min_num = 1,
      max_num = #ids,
      skill_name = muohbaoch.name,
      prompt = "#muohbaoch-choose",
      cancel_choices = {"get_all"}
    })
    if choice=="get_all" then cards= ids end
    if #cards == 0 then return end


    for _, id in ipairs(cards) do
      local get ={id}
      get = table.filter(get, function (id)
        return table.contains(player.room.discard_pile, id)
      end)
      get = player.room.logic:moveCardsHoldingAreaCheck(get)
      if #get > 0 and not player.dead and  player:hasSkill(muohbaoch.name)  then
        event:setCostData(self, {cards=get})
        self:doCost(event, target, player, data)
      end
    end
  end,
  on_cost = function(self, event, target, player, data)
    if event:getCostData(self) then return true end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local cards = table.simpleClone(event:getCostData(self).cards)
    room:moveCardTo(cards, Card.PlayerHand, player, fk.ReasonJustMove, muohbaoch.name, nil, true, player)
  end,
})

return muohbaoch