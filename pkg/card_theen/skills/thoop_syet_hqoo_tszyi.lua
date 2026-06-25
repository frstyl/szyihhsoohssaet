local skill = fk.CreateSkill {
  name = "#thoop_syet_hqoo_tszyi_skill",
  tags = { Skill.Compulsory },
  attached_equip = "thoop_syet_hqoo_tszyi",
}

skill:addEffect("distance", {
  correct_func = function(self, from, to)
    if from:hasSkill(skill.name) then
      return -1
    end
  end,
})

return skill
