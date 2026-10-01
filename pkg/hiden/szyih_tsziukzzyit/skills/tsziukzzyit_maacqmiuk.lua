local tsziukzzyit_maacqmiuk = fk.CreateSkill {
  name = "tsziukzzyit_maacqmiuk",
}

-- Fk:loadTranslationTable{
--   ["@tsziukzzyit_maacqmiuk"] = "盲目",
-- }

local S = require "packages/szyihhsoohssaet/szyih_guos" 


tsziukzzyit_maacqmiuk:addEffect("prohibit", {
  -- globle=true,
  is_prohibited = function(self, from, to, card)
    return from  and S.hasTsziukzzyit(from,"maacqmiuk") and to and to~= player and card  and  from:compareDistance(to,1,">")
  end,
})

tsziukzzyit_maacqmiuk:addEffect(fk.PreCardUse, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return player:compareDistance(data.from,1,">")
  end,
  on_trigger = function(self, event, target, player, data)
    data.disresponsiveList=data.disresponsiveList or {}
    table.insertIfNeed(data.disresponsiveList,player)
  end,
})

return tsziukzzyit_maacqmiuk

