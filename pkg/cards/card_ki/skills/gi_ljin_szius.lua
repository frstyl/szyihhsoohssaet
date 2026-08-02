local skill = fk.CreateSkill {
  name = "#gi_ljin_szius_skill",
  tags = { Skill.Compulsory },
  attached_equip = "gi_ljin_szius",
}

skill:addEffect("distance", {
  correct_func = function(self, from, to)
    if to:hasSkill(skill.name) then
      return 1
    end
  end,
})



return skill
