local cardSkill = fk.CreateSkill {
  name = "khouc_filter_skill",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("filter", {
  -- global=true,
  card_filter = function(self, to_select, player, isJudgeEvent)
    return to_select:hasMark("view_as") or to_select:hasMark("concealed")
  end,
  view_as = function(self, player, to_select)
    if to_select:hasMark("concealed") then return Fk:cloneCard("khouc") end
    local mark =to_select:hasMark("view_as")[1]
    if type(mark) == "string" then
      return Fk:cloneCard(mark, to_select.suit, to_select.number)  --与匹配不同序
    elseif type(mark) == "table"  then
      local c= Fk:cloneCard(mark.name or "khouc", mark.suit or Card.NoSuit, mark.number or 0)
      if mark[color] then 
        c.color=mark[color]
      end
      return c
    end
  end,
})

-- Fk:loadTranslationTable{
--   ["view_as"] = "", 
-- }
return cardSkill