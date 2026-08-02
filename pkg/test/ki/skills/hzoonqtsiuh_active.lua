local hzoonqtsiuh_active = fk.CreateSkill {
  name = "hzoonqtsiuh_active",
}
Fk:loadTranslationTable{
  ["hzoonqtsiuh_active"] = "酒",
  [":hzoonqtsiuh_active"] = "伱可起動酒,伱可發動.當段內伱所起動下1酒改變目幖",

  ["#hzoonqtsiuh_active"] = "酒 改變伱所起動下1酒目幖",
  ["@@hzoonqtsiuh_active-phase"] = "酒",
}
-- hzoonqtsiuh_active:addAcquireEffect(function (self, player)
--     player.room:setPlayerMark(player,"@hzoonqtsiuh_active",1) 
-- end)

-- hzoonqtsiuh_active:addLoseEffect (function (self, player)
--     player.room:setPlayerMark(player,"@hzoonqtsiuh_active",0) 
-- end)

hzoonqtsiuh_active:addEffect("viewas", {
  anim_type = "offensive",
  pattern =".|.|.|.|nziuk,tsiuh,meej",
  prompt = "#hzoonqtsiuh_active",
  mute_card = true,
  -- handly_pile = true,
  -- card_filter = function(self, player, to_select, selected)
  --   return #selected == 0 and Fk:getCardById(to_select).color == Card.Red
  -- end,
  view_as = function(self, player, cards)
    return nil
  end,
  target_filter = function(self, player, to_select, selected, selected_cards, c, extra_data)
    return to_select~=player and #selected==0
  end,
  feasible = function(self, player, selected, selected_cards, card)
    return #selected == 1
  end,
  on_use = function(self, room, cardUseEvent, _, params)
    local player = cardUseEvent.from
    cardUseEvent.tos[1]:drawCards(2)
    room:setPlayerMark(player,"@@hzoonqtsiuh_active-phase",cardUseEvent.tos[1].id)
    return hzoonqtsiuh_active.name
  end,
  enabled_at_play = function(self, player) 
    return  player:getMark("@@hzoonqtsiuh_active-phase")==0
  end,
  enabled_at_response = function(self, player, response) 
    return  not response and  player:getMark("@@hzoonqtsiuh_active-phase")==0
  end,
})

hzoonqtsiuh_active:addEffect(fk.PreCardUse, {
  can_refresh= function (self, event, target, player, data)
    return target == player  and player:getMark("@@hzoonqtsiuh_active-phase")~=0
      and data.card
      and data.card.trueName=="nziuk" 
 end,
  on_refresh = function (self, event, target, player, data)
    local to =player.room:getPlayerById(player:getMark("@@hzoonqtsiuh_active-phase"))
    to:drawCards(2)
    data.tos={player, to}
  end,
})

hzoonqtsiuh_active:addEffect("targetmod", {
  fix_target = function(self, player, skill,card,extra_data)
    if player:getMark("@@hzoonqtsiuh_active-phase")~=0 then 
      return card.trueName=="nziuk" and {player.id,player:getMark("@@hzoonqtsiuh_active-phase")}
    end
  end,
})
return hzoonqtsiuh_active
