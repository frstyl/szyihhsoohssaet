local zjipdvoat = fk.CreateSkill{
  name = "zjipdvoat",
}

Fk:loadTranslationTable{
  ["zjipdvoat"] = "襲奪",
  [":zjipdvoat"] = "牌被展示/亮出/置入/交與後,伱可選其中1牌發動,取得之",  --

  ["#zjipdvoat-choose"] = "襲奪 取得其1",

  ["$zjipdvoat1"] = "板刀麪還是餛飩麪",
  ["$zjipdvoat2"] = "上已昰船可由不得伱矣",
}


zjipdvoat:addEffect(fk.CardShown, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(zjipdvoat.name) 

  end,
  on_cost = function(self, event, target, player, data)
    local hand=player:getCardIds("h")
    local ids=   table.filter(data.cardIds, function (id)
      return not table.contains(hand, id)
    end)
    if #ids==0 then return end
    local cards, choice = player.room:askToChooseCardsAndChoice(player, {
        cards = ids,
        min_num = 1,
        max_num = 1,
        skill_name = zjipdvoat.name,
        prompt = "#zjipdvoat-choose",
        cancel_choices = {"Cancel"}
      })
      if choice=="Cancel" or #cards==0 then return end
      event:setCostData(self, { cards = cards})
      return true
  end,
  on_use = function(self, event, target, player, data)
    player.room:obtainCard(player, event:getCostData(self).cards, true, fk.ReasonPrey, player, zjipdvoat.name)
  end,
})


zjipdvoat:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(zjipdvoat.name) then return end
    return true

  end,
  on_cost = function(self, event, target, player, data)
    local ids ={}
    local room=player.room
      for _, move in ipairs(data) do
        if ( move.moveReason == fk.ReasonPut or move.moveReason == fk.ReasonJustMove or move.moveReason == fk.ReasonGive)
        then
          for _, info in ipairs(move.moveInfo) do
            if room:getCardArea(info.cardId)==move.toArea then
              table.insert(ids,info.cardId)
            end
          end
        end
      end
    ids = player.room.logic:moveCardsHoldingAreaCheck(ids)
    if #ids==0 then return end
      local cards, choice = player.room:askToChooseCardsAndChoice(player, {  --應該看不見
        cards = ids,
        min_num = 1,
        max_num = 1,
        skill_name = zjipdvoat.name,
        prompt = "#zjipdvoat-choose",
        cancel_choices = {"Cancel"}
      })
      if choice=="Cancel" or #cards==0 then return end
      event:setCostData(self, { cards = cards})
      return true
  end,
  on_use = function(self, event, target, player, data)
    player.room:obtainCard(player, event:getCostData(self).cards, true, fk.ReasonPrey, player, zjipdvoat.name)
  end,
})

return zjipdvoat
