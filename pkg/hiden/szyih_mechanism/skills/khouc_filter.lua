local cardSkill = fk.CreateSkill {
  name = "khouc_filter_skill",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("filter", {
  -- global=true,
  card_filter = function(self, to_select, player, isJudgeEvent)
    return to_select:getMark("@@khouc_filter_view_as") ~= 0
    -- return #to_select:getTableMark("@@not_equip-inarea") ~= 0 --and Fk:getCardById(to_select).area~=Card.PlayerEquip
  end,
  view_as = function(self, player, to_select)
    local mark =to_select:getMark("@@khouc_filter_view_as")
    if type(mark) == "string" then
      return Fk:cloneCard(mark, to_select.suit, to_select.number)  --与匹配不同序
    elseif type(mark) == "table"  then
      local c= Fk:cloneCard(mark[1], mark[2], mark[3])
      if mark[3] == Card.NoSuit then 
        c.color=mark[4] or Card.NoColor 
      end
      return c
    end
  end,
})

Fk:loadTranslationTable{
  ["@@khouc_filter_view_as"] = "空",  --記錄所印card id 不刷新 可能bug
}
return cardSkill