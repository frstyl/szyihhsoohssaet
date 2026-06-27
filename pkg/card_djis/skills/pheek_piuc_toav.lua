local skill = fk.CreateSkill {
  name = "#pheek_piuc_toav_skill",
  tags = { Skill.Compulsory },
  attached_equip = "pheek_piuc_toav",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

skill:addEffect(fk.DamageCaused, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(skill.name) and
      data.to:isKongcheng() and data.card and data.card.trueName == "ssaet" and data.by_user
  end,
  on_use = function(self, event, target, player, data)
    S.changeDamage({damageData=data,num=1,skillName=skill.name})
  end,
})


return skill
