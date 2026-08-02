local muoqhzoeon = fk.CreateSkill {
  name = "muoqhzoeon",
  tags={Skill.Compulsory}
}

Fk:loadTranslationTable{
  ["muoqhzoeon"] = "无痕",
  [":muoqhzoeon"] = "伱起動牌不觸發計數自次數限制",

  ["$muoqhzoeon1"] = "破阵杀敌，愿献犬马之劳！",
  ["$muoqhzoeon2"] = "虎啸既响，无痕当附！",
}
local S = require "packages/szyihhsoohssaet/szyih_guos"

muoqhzoeon:addEffect(fk.PreCardUse, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(muoqhzoeon.name) 
  end,
  on_use = function(self, event, target, player, data)
    data.extraUse=true
  end,
})

return muoqhzoeon
