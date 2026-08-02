local skill = fk.CreateSkill {
  name = "#cxin_ssik_gwen_hsfa_skill",
  tags = { Skill.Compulsory },
  attached_equip = "cxin_ssik_gwen_hsfa",
}

skill:addEffect("distance", {
  correct_func = function(self, from, to)
    if from:hasSkill(skill.name) then
      return -1
    end
  end,
})

return skill
