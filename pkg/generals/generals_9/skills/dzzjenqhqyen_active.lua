local dzzjenqhqyen_active = fk.CreateSkill({
  name = "dzzjenqhqyen_active",
})

dzzjenqhqyen_active:addEffect("active", {  --飛劍選牌
  mute = true,
  min_card_num = 1,
  max_card_num = 2,
  min_target_num = 0,
  max_target_num = 1,
  -- expand_pile = extra_data.extra_ids,
  card_filter = function (self, player, to_select, selected)
    return 
   
       ( #selected == 0 and table.contains(self.expand_pile, to_select)  and Fk:currentRoom():getCardArea(to_select)==Card.DiscardPile  )
    or  
      ( #selected == 1 
      and table.contains(Self:getCardIds("h"), to_select) 
      and (not player:prohibitResponse(Fk:getCardById(to_select)))
    )
    

  end,
  target_filter = function (self, player, to_select, selected, selected_cards)
    return #selected_cards==2 and #selected == 0 
  end,
})


return dzzjenqhqyen_active
