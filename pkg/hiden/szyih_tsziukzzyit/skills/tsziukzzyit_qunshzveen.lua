local tsziukzzyit_hzaechquns = fk.CreateSkill {
  name = "tsziukzzyit_qunshzveen",
}

Fk:loadTranslationTable{
  ["@tsziukzzyit_qunshzveen"] = "暈眩",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 


tsziukzzyit_hzaechquns:addEffect("invalidity", {
  -- global = true,
  invalidity_func = function(self, from, skill)
    return
      S.hasTsziukzzyit(from,"qunshzveen") and skill and skill:isPlayerSkill(from)
  end
})
return tsziukzzyit_hzaechquns
