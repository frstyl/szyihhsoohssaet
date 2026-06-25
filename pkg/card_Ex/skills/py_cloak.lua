local skill = fk.CreateSkill {
  name = "#baav_skill",
  tags = { Skill.Compulsory },
  attached_equip = "baav",
}

Fk:loadTranslationTable{
  ["#baav_skill"] = "国风玉袍",
}

skill:addEffect("prohibit", {
  is_prohibited = function(self, from, to, card)
    return from ~= to and to:hasSkill(skill.name) and Fk.skills[skill.name]:isEffectable(from) and card and (card:isCommonTrick() or card.trueName=="ssaet")
  end,
})

return skill
