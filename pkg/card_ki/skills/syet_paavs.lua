local skill = fk.CreateSkill {
  name = "#syet_paavs_skill",
  tags = { Skill.Compulsory },
  attached_equip = "syet_paavs",
}

skill:addEffect("distance", {
  correct_func = function(self, from, to)
    if from:hasSkill(skill.name) then
      return -1
    end
  end,
})

return skill
