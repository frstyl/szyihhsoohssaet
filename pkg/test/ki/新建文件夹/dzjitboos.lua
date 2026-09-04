local dzjitboos = fk.CreateSkill {
  name = "dzjitboos",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["dzjitboos"] = "疾步",
  [":dzjitboos"] = "恆續,其它脚色至你距離+1,伱至其它脚色距離-1。",
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
