
local _skill = fk.CreateSkill{
  name = "phase_discard_skill",
}
_skill:addEffect('active', {
  card_filter = function(self, player, to_select, selected)



    -- local checkpoint = true
    local card = Fk:getCardById(to_select)
    if not card:hasMark("extra_retain") then
      local n =0
      for _, id in ipairs(selected) do
        if Fk:getCardById(id):hasMark("extra_retain") then n=n+1 end
      end

      if #selected-n >= self.num then
        return false
      end
    end

    -- local status_skills = Fk:currentRoom().status_skills[ProhibitSkill] or Util.DummyTable
    -- for _, skill in ipairs(status_skills) do
    --   if skill:prohibitDiscard(player, card) then
    --     return false
    --   end
    -- end
    --   ---@type MaxCardsSkill[]
    --   status_skills = Fk:currentRoom().status_skills[MaxCardsSkill] or Util.DummyTable
    --   for _, sk in ipairs(status_skills) do
    --     if sk:excludeFrom(player, card) then  --不需用status_skills
    --       return false
    --     end
    --   end

    return table.contains(self.toBeDis,to_select)
  end,
  feasible=function(self,player,selected,selected_cards,card)
    local n =#selected_cards
    for _, id in ipairs(selected_cards) do
      if Fk:getCardById(id):hasMark("extra_retain") then n=n-1 end
    end

    return  n == self.num 
  end,
  -- min_card_num = function(self, player) return self.min_num end,
  -- max_card_num = function(self, player) return self.num end,
})


_skill:addAI(Fk.Ltk.AI.newDiscardStrategy {
  choose_cards = function(self, ai)
    local data = ai.data[4] -- extra_data
    local available_cards = ai:getEnabledCards()

    local num = data.num
    local min_num = ai.data[3] and 0 or data.min_num

    ai:sortCards(available_cards, "keep_value")
    if ai._debug then
      verbose(0, "[默认弃牌AI] 已完成卡牌的排序，排序后的卡牌为%s", table.concat(
        table.map(available_cards, function(id)
          local cd = Fk:getCardById(id)
          local log = cd:toLogString()
          local v = ai:getCardValue(id)
          return ("%s(id=%s, v=%s)"):format(log, id, v)
        end), ","))
    end
    local cards = table.slice(available_cards, 1, min_num + 1)
    local benefit = -ai:getBenefitOfEvents(function(logic)
      logic:moveCardTo(cards, Card.DiscardPile, nil, fk.ReasonDiscard, ai.data[1], nil, false, ai.player)
    end)
    return cards, benefit
  end,
})


return _skill
