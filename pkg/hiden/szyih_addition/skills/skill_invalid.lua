local skill_invalid = fk.CreateSkill {
  name = "skill_invalid",
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{
  ["@@skill_invalid"] = "技能失效",

}

skill_invalid:addEffect("invalidity", {
  invalidity_func = function(self, from, skill)
    return  
      skill:isPlayerSkill(from) and
      from:hasMark("@@skill_invalid")
  end
})
return skill_invalid
