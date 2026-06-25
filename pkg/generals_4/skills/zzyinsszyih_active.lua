local zzyinsszyih_active = fk.CreateSkill({
  name = "zzyinsszyih_active",
})

zzyinsszyih_active:addEffect("active", {  --飛劍選牌
  mute = true,
  min_card_num = 1,  --不能緟選  --指牌1在手中
  max_card_num=2,
  target_num = 0,  --任意?
  -- expand_pile = extra_data.extra_ids,
  card_filter = function (self, player, to_select, selected)
    return 
       ( #selected == 0 and table.contains(self.expand_pile, to_select)   )
    or  ( 
      #selected == 1 
    and not player:prohibitResponse(Fk:getCardById(to_select)) 
    -- and not Fk:getCardById(to_select):compareSuitWith(Fk:getCardById(selected[1]))
    and (
      Fk:getCardById(to_select).color==Card.NoColor 
      or  Fk:getCardById(to_select).color==Fk:getCardById(selected[1]).color
  )
  )
  end,
  feasible = function (self, player, selected, selected_cards, card)
    if selected_cards[1] and table.contains(player:getCardIds("h"), selected_cards[1]) then return
      not player:prohibitResponse(Fk:getCardById(selected_cards[1]))
    else
      return #selected_cards==2
    end
  end,
})


return zzyinsszyih_active
