local equipSkill = fk.CreateSkill {
  name = "#phiocqmoac_toav_skill",
  attached_equip = "phiocqmoac_toav",
  tags = { Skill.Compulsory },
}

equipSkill:addEffect(fk.CardUsing, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(equipSkill.name) and data.card.trueName == "ssaet" 
    and target.hp<=(target.maxHp+1)//2
  end,
  on_use = function(self, event, target, player, data)
      data.disresponsiveList = table.simpleClone(player.room.players)
      -- data.disresponsive = true  --unoffsetableList抵消

  end,
})

return equipSkill
