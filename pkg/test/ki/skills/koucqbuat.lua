local koucqbuat = fk.CreateSkill {
  name = "koucqbuat",
  tags={Skill.NotViewAs},
}
Fk:loadTranslationTable{
  ["koucqbuat"] = "攻伐",
  [":koucqbuat"] = "伱可起動｢殺｣旹,伱可發動,此次起動无限制",

  ["@@koucqbuat"] = "攻伐",

  ["#koucqbuat"] = "攻伐 此次起動｢殺｣无限制",
}


koucqbuat:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "ssaet",
  prompt = "#koucqbuat",
  -- mute_card = true,
  -- handly_pile = true,
  -- card_filter = function(self, player, to_select, selected)
  --   return #selected == 0 and Fk:getCardById(to_select).color == Card.Red
  -- end,
  view_as = function(self, player, cards)
    return nil
  end,

  feasible = function(self, player, selected, selected_cards, card)
    return #selected == 0
  end,
  on_use = function(self, room, cardUseEvent, card, params) 
    local player = cardUseEvent.from
    local tos =cardUseEvent.tos
    room:addPlayerMark(player,"@@koucqbuat",1)
    room:addPlayerMark(player,"ssaet_target_number",99)  --bypass_target_number?
    room:addPlayerMark(player,"ssaet_bypass_times",1)
    room:addPlayerMark(player,"ssaet_bypass_distances",1)
    room:addPlayerMark(player,"ssaet_bypass_prohibited",1)
    return koucqbuat.name
  end,
  enabled_at_play = function(self, player) 
    return 
     not table.contains(player:getTableMark("bannedSkills"),self.name)
  end,
  enabled_at_response = function(self, player, response) 
    return  true
  end,
})

koucqbuat:addEffect(fk.PreCardUse, {
  can_refresh = function (self, event, target, player, data)
    return  data.card.trueName == "ssaet"  --data.from:getMark
    -- and player==data.from
    and data.from:getMark("@@koucqbuat")~=0
  end,
  on_refresh = function (self, event, target, player, data)
    data.extraUse=true
    local room=player.room
    room:setPlayerMark(data.from,"@@koucqbuat",nil)
    room:removePlayerMark(data.from,"ssaet_target_number",99)  --bypass_target_number?
    room:removePlayerMark(data.from,"ssaet_bypass_times",1)
    room:removePlayerMark(data.from,"ssaet_bypass_distances",1)
    room:removePlayerMark(data.from,"ssaet_bypass_prohibited",1)
  end,
})
return koucqbuat
