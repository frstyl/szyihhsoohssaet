local siuqmuoh = fk.CreateSkill{
  name = "siuqmuoh",
}

Fk:loadTranslationTable{
  ["siuqmuoh"] = "修武",
  [":siuqmuoh"] = "主旹无限次,伱選至1至多牌(｢殺｣或裝僃牌或物資牌)發動.緟鑄之｡以此所獲牌1轉无視存牌數",

  ["#siuqmuoh"] = "修武：緟鑄殺",
  ["@@siuqmuoh-inhand-turn"] = "修武",

  ["$siuqmuoh1"] = "還有後招",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

siuqmuoh:addEffect("active", {
  anim_type = "drawcard",
  prompt = "#siuqmuoh",
  min_card_num = 1,
  target_num = 0,
  card_filter = function(self, player, to_select, selected)
    local c=Fk:getCardById(to_select)
    -- return c.trueName == "ssaet" or c.type==Card.TypeEquip
    return c.trueName=="ssaet" or c.type==Card.TypeEquip or  S.getCardSubtypeByName(c.trueName)==2
    -- table.contains({"ssaet","nziuk","analptic","tsoucs","thoac_qwen","hzouc_paav","cuat_pjech","ssaac_dzzjin_koac"},c.trueName )
    -- (n==1 and c.trueName ~= "szjemh")
  end,
  on_use = function(self, room, effect)
    -- room:addSkill("exclude")
    room:recastCard(effect.cards, effect.from, siuqmuoh.name,{"@@siuqmuoh-inhand-turn",1 , "exclude-inhand-turn",1})
  end,
})



return siuqmuoh
