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

return tsziukzzyit_maacqmiuk

