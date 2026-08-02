local skill = fk.CreateSkill {
  name = "#thoeop_syet_hqoo_tszyi_skill",
  tags = { Skill.Compulsory },
  attached_equip = "thoeop_syet_hqoo_tszyi",
}

skill:addEffect("distance", {
  correct_func = function(self, from, to)
    if from:hasSkill(skill.name) then
      return -1
    end
  end,
})

return skill
