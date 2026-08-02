local kiamsmrac = fk.CreateSkill {
  name = "kiamsmrac",
  tags={Skill.NotViewAs},
}
Fk:loadTranslationTable{
  ["kiamsmrac"] = "劍鳴",
  [":kiamsmrac"] = "伱可起動演練殺旹,伱可虛擬起動｢殺｣(无視次數限制)發動",

  ["#kiamsmrac"] = "劍鳴 起動殺",
}


kiamsmrac:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "ssaet",
  prompt = "#kiamsmrac",
  -- mute_card = true,
  -- handly_pile = true,
  -- card_filter = function(self, player, to_select, selected)
  --   return #selected == 0 and Fk:getCardById(to_select).color == Card.Red
  -- end,
  view_as = function(self, player, cards)
    return nil
  end,
  target_filter = function(self, player, to_select, selected, selected_cards, c, extra_data)
    local card=Fk:cloneCard("ssaet")
    card.skillName = kiamsmrac.name
    return  card:getSkill(player):targetFilter(player, to_select, selected, _, card, {bypass_distances=false,bypass_times=true}) --不繼承extra_data
  end,
  feasible = function(self, player, selected, selected_cards, card)
    return #selected ~= 0
  end,
  on_use = function(self, room, cardUseEvent, card, params)  --beforeUse前 returun轉化起動信息  --cardUseEvent 實爲SkillUseData ,params handleUseCardParams is_response, card viewAs--beforeUse
    local player = cardUseEvent.from
    local tos =cardUseEvent.tos
    -- local card=Fk:cloneCard("ssaet")
    -- player.room:useCard()
    -- room:askToUseVirtualCard
    room:useVirtualCard("ssaet",nil,player,tos,kiamsmrac.name,true,{bypass_distances=false,bypass_times=true})
    return kiamsmrac.name
  end,
  enabled_at_play = function(self, player) 
    return 
     not table.contains(player:getTableMark("bannedSkills"),self.name)
  end,
  enabled_at_response = function(self, player, response) 
    return  true
  end,
})


return kiamsmrac
