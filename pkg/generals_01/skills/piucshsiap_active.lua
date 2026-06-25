local piucshsiap_active = fk.CreateSkill {
  name = "piucshsiap_active",
}
Fk:loadTranslationTable{
  -- ["piucshsiap_active"] = "折辱",
}


piucshsiap_active:addEffect("active", {
  mute = true,
  prompt = function(self)
    return "#piucshsiap_active:"..self.from
  end,
  card_num = 2,
  target_num = 0,
  max_phase_use_time=1,
  -- handly_pile = true,  --弃

  card_filter = function(self, player, to_select, selected)
    if  #selected>1 then return  end
    if selected[1]==nil then return table.contains({"ssaet","szjemh"} ,Fk:getCardById(to_select).trueName) end
    local name = Fk:getCardById(to_select).trueName
    local name2 =selected[1] and Fk:getCardById(selected[1]).trueName or ""
    return (name=="ssaet" and name2=="szjemh")
    or (name2=="ssaet" and name=="szjemh")
  end,
  -- target_filter = = function(self, player, to_select, selected)
  --   if #selected ~= 0 then return end
  --   return table.contains(player:getCardIds("h"), to_select)
  --   and  not player:prohibitDiscard(to_select) 
  -- end,
  -- feasible = function (self, player, selected, selected_cards)

  -- end,
  on_use = function(self, room, effect)

  end,
})

return piucshsiap_active
