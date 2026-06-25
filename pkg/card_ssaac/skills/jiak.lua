local jiak = fk.CreateSkill {
  name = "jiak_skill",
}

Fk:loadTranslationTable{
  ["#jiak_skill"] = "藥 令1已損角色回1",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

jiak:addEffect("cardskill", {
  prompt = "#jiak_skill",
  target_num = 1,
  mod_target_filter = function(self, player, to_select, selected, card)
    return    to_select:isWounded()
  end,
  target_filter = Util.CardTargetFilter,
  on_effect = function(self, room, effect)
      room:recover{
        who = effect.to,
        num = 1,
        card = effect.card,
        recoverBy = effect.from,
        skillName = jiak.name,
      }
      S.removeTsziukzzyit(effect.to)
  end,
})


return jiak
