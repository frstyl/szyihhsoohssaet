local skill = fk.CreateSkill {
  name = "#tsheen_lih_seej_piuc_skill",
  tags = { Skill.Compulsory },
  attached_equip = "tsheen_lih_seej_piuc",
}

skill:addEffect("distance", {
  correct_func = function(self, from, to)
    if to:hasSkill(skill.name) then
      return 1
    end
  end,
})

return skill
