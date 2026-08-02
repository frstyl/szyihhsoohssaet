
local theetgxes = fk.CreateSkill{
  name = "theetgxes",
  tags = { Skill.Compulsory },
}
Fk:loadTranslationTable{
["theetgxes"] = "鐵騎",
[":theetgxes"] = "➀伱至其他脚色距離-x.➁伱手牌上限+x",  --同隊不计入距离 均傷

["#theetgxes-choose"] = "鐵騎 選擇一脚色 視爲對其起動殺",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

theetgxes:addEffect("distance", {
  correct_func = function(self, from, to)
    if from:hasSkill(theetgxes.name) then
      return S.getSquad(from)
    end
  end,
})

theetgxes:addEffect("maxcards", {
  correct_func = function(self, player)
    if player:hasSkill(theetgxes.name) then
      return   S.getSquad(from)
    end
  end
})

return theetgxes
