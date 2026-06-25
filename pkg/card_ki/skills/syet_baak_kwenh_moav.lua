local skill = fk.CreateSkill {
  name = "#syet_baak_kwenh_moav_skill",
  tags = { Skill.Compulsory },
  attached_equip = "syet_baak_kwenh_moav",
}

skill:addEffect("distance", {
  correct_func = function(self, from, to)
    if to:hasSkill(skill.name) then
      return 1
    end
  end,
})

return skill
