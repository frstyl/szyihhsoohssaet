local dzjitboos = fk.CreateSkill {
  name = "dzjitboos",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["dzjitboos"] = "疾步",
  [":dzjitboos"] = "鎖定.恆續,其他角色至你距離+1,伱至其他角色距離-1。",
}

dzjitboos:addEffect("distance", {
  correct_func = function(self, from, to)
    if to:hasSkill(dzjitboos.name) then
      return 1
    end
    if from:hasSkill(dzjitboos.name) then
      return -1
    end
  end,
})

return dzjitboos
