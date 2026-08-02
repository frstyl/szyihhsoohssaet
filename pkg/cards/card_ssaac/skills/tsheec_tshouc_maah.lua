local skill = fk.CreateSkill {
  name = "#tsheec_tshouc_maah_skill",
  tags = { Skill.Compulsory },
  attached_equip = "tsheec_tshouc_maah",
}

skill:addEffect("distance", {
  correct_func = function(self, from, to)
    if from:hasSkill(skill.name) then
      return -2
    end
  end,
})


return skill
