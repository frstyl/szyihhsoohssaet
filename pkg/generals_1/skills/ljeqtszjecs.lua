local ljeqtszjecs = fk.CreateSkill {
  name = "ljeqtszjecs",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["ljeqtszjecs"] = "離政",
  [":ljeqtszjecs"] = "鎖定.恆續,其他角色至你距離+1,若伱有戲再+1。",
}

ljeqtszjecs:addEffect("distance", {
  correct_func = function(self, from, to)
    if to:hasSkill(ljeqtszjecs.name) then
      if to:getMark("@@hqeensjiu-draw")> 0 then
      return 2
      else return 1
    end
    end
  end,
})

return ljeqtszjecs
