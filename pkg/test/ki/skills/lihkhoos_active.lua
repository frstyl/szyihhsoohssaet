local lihkhoos_active = fk.CreateSkill {
  name = "lihkhoos_active&",
}

Fk:loadTranslationTable{
  ["lihkhoos_active&"] = "理庫",
  [":lihkhoos_active&"] = "選牌",

  ["#lihkhoos_active"] = "理庫：選牌",
}



lihkhoos_active:addEffect("viewas", {
  pattern = ".|.|.|.|.|.",
  prompt = "#lihkhoos_active",
  interaction = function(self, player)
    local all_names = Fk:getAllCardNames("bt")
    local names = player:getViewAsCardNames(lihkhoos_active.name, all_names)
    if #names == 0 then return end
    return UI.CardNameBox { choices = names, all_choices = all_names }
  end,
  handly_pile = false,
  card_filter = function(self, player, to_select, selected)

    return false
  end,
  view_as = function (self, player, cards)
    return nil
  end,
  feasible = function(self, player, selected, selected_cards, card)
     return self.interaction.data
  end,
  on_use = function(self, room, cardUseEvent, card, params) 
    local player=cardUseEvent.from
    
    local ids =table.filter(Fk:currentRoom().draw_pile,function(id) return Fk:getCardById(id).trueName== self.interaction.data  end)
    if #ids==0 then return end
    local id = room:askToChooseCards(player, {
      target = player,
      flag = { card_data = { { "draw_pile", ids } } },
      skill_name =lihkhoos_active.name,
      min=1,
      max=1,
      cancelable=false,
    })
    if id[1] then
      room:setPlayerMark(player,"lihkhoos-phase",id[1])
    else
      room:setPlayerMark(player,"lihkhoos_active-phase",1)
    end
    return lihkhoos_active.name --禁燒條
  end,
  -- before_use = function (self, player, use)
  -- end,
  enabled_at_play = function(self, player) 
    return player:getMark("lihkhoos_active-phase")== 0
  end,
    -- enabled_at_response = function(self, player, response)
  --   return not response and not player:isNude()
  -- end,
  -- enabled_at_nullification = function(self, player, data)
  --   if not self:enabledAtResponse(player, false) then return end

  --   local all_names =  table.filter(Fk:getAllCardNames("b"), function(name)
  --     return S.isCommonTrick(name)
  --   end)

  --   return true
  -- end,
})


lihkhoos_active:addEffect(fk.HandleAskForPlayCard, {  --眞止問ask AskForCardData extraData eventData
  can_refresh = function(self, event, target, player, data)  --雙向?
    return  player:getMark("lihkhoos-phase")~=0
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:setPlayerMark(player,"lihkhoos-phase",nil)
  end,
})

return lihkhoos_active
