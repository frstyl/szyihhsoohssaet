local skill = fk.CreateSkill {
  name = "#tszjevs_jjas_ciok_ssxi_tsih_skill",
  tags = { Skill.Compulsory },
  attached_equip = "tszjevs_jjas_ciok_ssxi_tsih",
}

skill:addEffect("distance", {
  correct_func = function(self, from, to)
    if to:hasSkill(skill.name) then
      return 1
    end
  end,
})

return skill
