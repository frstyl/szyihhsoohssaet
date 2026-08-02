local skill = fk.CreateSkill {
  name = "#hqeen_tszji_skill",
  tags = { Skill.Compulsory },
  attached_equip = "hqeen_tszji",
}

skill:addEffect("distance", {
  correct_func = function(self, from, to)
    if to:hasSkill(skill.name) then
      return 1
    end
  end,
})

return skill
