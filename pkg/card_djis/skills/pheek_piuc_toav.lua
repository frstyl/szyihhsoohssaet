local skill = fk.CreateSkill {
  name = "#pheek_piuc_toav_skill",
  tags = { Skill.Compulsory },
  attached_equip = "pheek_piuc_toav",
}

skill:addEffect(fk.DamageCaused, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(skill.name) and
      data.to:isKongcheng() and data.card and data.card.trueName == "ssaet" and data.by_user
  end,
  on_use = function(self, event, target, player, data)
    data:changeDamage(1)
  end,
})

skill:addAI({
  correct_func = function(self, logic, event, target, player, data)
    if self.skill:triggerable(event, target, player, data) then
      data.damage = data.damage + 1
    end
  end,
}, nil, nil, true)

return skill
