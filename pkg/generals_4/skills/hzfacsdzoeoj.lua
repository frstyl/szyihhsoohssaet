
local hzfacsdzoeoj = fk.CreateSkill {
  name = "hzfacsdzoeoj",
}

Fk:loadTranslationTable{
  ["hzfacsdzoeoj"] = "橫財",
  [":hzfacsdzoeoj"] = "非伱所有之牌被弃置進入弃牌堆後,伱可選其中至多x牌發動.伱獲取之",--,若弃牌數不小于2

  ["#hzfacsdzoeoj-invoke"] = "橫財 是否發動",
  ["#hzfacsdzoeoj-choose"] = "橫財 選擇所得牌 所弃牌 得牌角色",

  ["$hzfacsdzoeoj1"] = "天上掉餡餅不要白不要",
  ["$hzfacsdzoeoj2"] = "還有人嫌錢多嗚",
}

hzfacsdzoeoj:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(hzfacsdzoeoj.name) then return end
    local ids = {}
      for _, move in ipairs(data) do
        if fk.ReasonDiscard==move.moveReason
          and move.from ~= player 
          -- and move.toArea == Card.DiscardPile
        then
          for _, info in ipairs(move.moveInfo) do
              table.insertIfNeed(ids, info.cardId)
          end
        end
      end
      ids = table.filter(ids, function (id)
        return table.contains(player.room.discard_pile, id)
      end)
      ids = player.room.logic:moveCardsHoldingAreaCheck(ids)
      if #ids > 0 then
        event:setCostData(self, {ids = ids})
        return true
      end
  end,
  on_cost = function(self, event, target, player, data)

      local ids, choice = player.room:askToChooseCardsAndChoice(player, {
        cards = event:getCostData(self).ids,
        min_num = 1,
        max_num = math.max(player:getLostHp(),1),
        skill_name = hzfacsdzoeoj.name,
        prompt = "#hzfacsdzoeoj-choose",
        cancel_choices = {"Cancel"}
      })
      if choice=="Cancel" or #ids==0 then return end
      event:setCostData(self, { ids = ids})
      return true
  end,
  on_use = function(self, event, target, player, data)
    player.room:moveCardTo(event:getCostData(self).ids, Card.PlayerHand, player, fk.ReasonPrey, hzfacsdzoeoj.name, nil, true, player)
  end,
})

return hzfacsdzoeoj
