local piucqcxim_active = fk.CreateSkill({
  name = "piucqcxim_active",
})

piucqcxim_active:addEffect("active", {  --飛劍選牌
  mute = true,
  min_card_num = 1,
  target_num = 0,
  -- expand_pile = extra_data.extra_ids,
  card_filter = function (self, player, to_select, selected)
    if not player:prohibitResponse(Fk:getCardById(to_select)) then
      return true
    end

  end,
  -- target_filter = function (self, player, to_select, selected, selected_cards)
  --   return  #selected == 0 and player:canUseTo(Fk:cloneCard("ssaet"), to_select, {bypass_distances = true, bypass_times = true})
  -- end,
  feasible = function (self, player, selected, selected_cards, card)
    local n =self.num
    for _, id in ipairs(selected_cards) do
      n=n+Fk:getCardById(id).number
    end
    return n % 12 ==0
  end,
  feas
})



return piucqcxim_active
