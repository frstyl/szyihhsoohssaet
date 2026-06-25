local tsziukzzyit_mracsttiucs = fk.CreateSkill {
  name = "tsziukzzyit_mracsttiucs",
}

-- Fk:loadTranslationTable{
--   ["@tsziukzzyit_mracsttiucs"] = "命中",
-- }

local S = require "packages/szyihhsoohssaet/szyih_guos" 


tsziukzzyit_mracsttiucs:addEffect(fk.CardUsing, {
  -- globle=true,
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player 
     and
      data.card.trueName == "ssaet" 
      and S.hasTsziukzzyit(player,"mracsttiucs") 
  end,
  on_trigger  = function(self, event, target, player, data)
    -- data.use.prohibitedCardNames = data.use.prohibitedCardNames or {}
    -- table.insertIfNeed(data.use.prohibitedCardNames, "szjemh")
    data.prohibitedCardNames = data.prohibitedCardNames or {}
    table.insertIfNeed(data.prohibitedCardNames, "szjemh")
  end,
})


return tsziukzzyit_mracsttiucs