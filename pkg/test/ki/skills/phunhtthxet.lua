local phunhtthxet = fk.CreateSkill {
  name = "phunhtthxet",
}
Fk:loadTranslationTable{
  ["phunhtthxet"] = "忿勶",
  [":phunhtthxet"] = "伱可起動殺,伱可發動.1段內伱所起動下1殺无視距離防具",

  ["#phunhtthxet"] = "忿勶 令伱所起動下1殺无視距離防具",
  ["@@phunhtthxet-phase"] = "忿勶",
}
-- phunhtthxet:addAcquireEffect(function (self, player)
--     player.room:setPlayerMark(player,"@phunhtthxet",1) 
-- end)

-- phunhtthxet:addLoseEffect (function (self, player)
--     player.room:setPlayerMark(player,"@phunhtthxet",0) 
-- end)

phunhtthxet:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "ssaet",
  prompt = "#phunhtthxet",
  mute_card = true,
  -- handly_pile = true,
  -- card_filter = function(self, player, to_select, selected)
  --   return #selected == 0 and Fk:getCardById(to_select).color == Card.Red
  -- end,
  view_as = function(self, player, cards)
    return nil
  end,
  -- target_filter = function(self, player, to_select, selected, selected_cards, c, extra_data)
  --   return to_select~=player and #selected==0
  -- end,
  feasible = function(self, player, selected, selected_cards, card)
    -- return #selected == 1
    return true
  end,
  on_use = function(self, room, cardUseEvent, _, params)
    local player = cardUseEvent.from
    room:addPlayerMark(player,"@@phunhtthxet-phase",1)
    room:addTableMark(player,"ssaet_ignore_Armor_by_skills",phunhtthxet.name)
    return phunhtthxet.name
  end,
  enabled_at_play = function(self, player) 
    return  player:getMark("@@phunhtthxet-phase")==0
  end,
  enabled_at_response = function(self, player, response) 
    return  not response and  player:getMark("@@phunhtthxet-phase")==0
  end,
})

phunhtthxet:addEffect(fk.CardUsing, {
  can_refresh= function (self, event, target, player, data)
    return target == player  and player:getMark("@@phunhtthxet-phase")>0
      and data.card
      and data.card.trueName=="ssaet" 
 end,
  on_refresh = function (self, event, target, player, data)
    data.extra_data=data.extra_data or {}
    data.extra_data.ignore_Armor_to=table.simpleClone(player.room.players)
    player.room:setPlayerMark(player,"@@phunhtthxet-phase",0)
    player.room:removeTableMark(player,"ssaet_ignore_Armor_by_skills",phunhtthxet.name)
  end,
})

phunhtthxet:addEffect("targetmod", {
  bypass_distances = function(self, player, skill, card, to)
    if player and player:getMark("@@phunhtthxet-phase")>0 and card and card.trueName=="ssaet" then
      return true
    end
  end,
})
return phunhtthxet
