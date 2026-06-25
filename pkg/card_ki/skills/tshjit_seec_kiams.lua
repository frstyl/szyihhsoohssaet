local equipSkill = fk.CreateSkill {
  name = "#tshjit_seec_kiams_skill",
  attached_equip = "tshjit_seec_kiams",
}

equipSkill:addEffect(fk.DamageCaused, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(equipSkill.name) 
    and (not data.chain) 
    and player.room.logic:damageByCardEffect()
    and
      data.card and data.card.trueName == "ssaet" and not data.to:isNude()
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local n=data.damage
    data:preventDamage()
    local to = data.to
    for i = 1, 2*n,1 do
      if player.dead or to.dead or to:isNude() then break end
      local card = room:askToChooseCard(player, { target = to, flag = "he", skill_name = equipSkill.name })
      room:throwCard(card, equipSkill.name, to, player)
    end
  end,
})

return equipSkill
