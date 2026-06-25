local equipSkill = fk.CreateSkill {
  name = "#tshiac_skill",
  attached_equip = "tshiac",
  -- tags = { Skill.Compulsory },
}
--傷旹?用牌旹?
equipSkill:addEffect(fk.CardUsing, {
  can_trigger= function (self, event, target, player, data)
    return target == player  and player:hasSkill(equipSkill.name)
      and data.card
      and data.card.trueName=="ssaet" 
 end,
  on_use = function (self, event, target, player, data)
   data.extra_data=data.extra_data or {}
   data.extra_data.tshiac=true
  end
})

equipSkill:addEffect(fk.PreDamage, {
	
  can_refresh = function(self, event, target, player, data)
    -- return target == player and player:hasSkill(equipSkill.name) and data.card and data.card.trueName == "ssaet"
    if target==player and data.card and data.card.trueName == "ssaet" then
      local use_event = player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true)
      if use_event then
        local use = use_event.data
        return use.card ==data.card and use.extra_data and use.extra_data.tshiac
      end
    end
  end,
  on_refresh = function(self, event, target, player, data)
      player.room:loseHp(data.to, data.damage, equipSkill.name) --cardSkill?
      data:preventDamage()  --damage = 0
  end,
})

return equipSkill
