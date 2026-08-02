local meecqqwer_active = fk.CreateSkill {
  name = "meecqqwer_active",
}



meecqqwer_active:addEffect("active", {
  anim_type = "offensive",
  min_target_num = 1,
  min_card_num = 2,
  prompt = "#meecqqwer_active",
  card_filter = function(self, player, to_select, selected)
    return not player:prohibitResponse(to_select)
  end,
  target_filter = function(self, player, to_select, selected, selected_cards)
    return #selected_cards//2 > #selected
  end,
  feasible = function (self, player, selected, selected_cards)
    local n = #selected_cards
    return (n>1 )
    and  
    (n % 2 == 0 )
    -- and (n//2 == #selected)
    and (n//2 >= #selected)
  end,
  on_use = function(self, room, effect)
    
  end,
})

return meecqqwer_active
