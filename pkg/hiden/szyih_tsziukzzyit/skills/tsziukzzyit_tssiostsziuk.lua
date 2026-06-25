local tsziukzzyit_tssiostsziuk = fk.CreateSkill {
  name = "tsziukzzyit_tssiostsziuk",
}

-- Fk:loadTranslationTable{
--   ["@tsziukzzyit_tssiostsziuk"] = "詛咒",
-- }

local S = require "packages/szyihhsoohssaet/szyih_guos" 


tsziukzzyit_tssiostsziuk:addEffect("prohibit", {
  -- globle=true,
  is_prohibited = function(self, from, to, card)
    return to  and S.hasTsziukzzyit(to,"tssiostsziuk") and card  and  table.contains({"nziuk","tsiuh","jiak"},card.trueName) --and from
  end,
})

return tsziukzzyit_tssiostsziuk

