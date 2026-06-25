local siuqmuoh = fk.CreateSkill{
  name = "siuqmuoh",
}

Fk:loadTranslationTable{
  ["siuqmuoh"] = "修武",
  [":siuqmuoh"] = "主動任意次,伱選至手1殺或裝僃牌發動.緟鑄之.以此所獲牌當轉不計入額定手牌數",

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
    return c.trueName=="ssaet"  or S.getCardTypeByName(c.name)==3 or   S.getCardSubtypeByName(c.name)==2
    -- table.contains({"ssaet","nziuk","analptic","tsoucs","thoac_qwen","hzouc_paav","cuat_pjech","ssaac_dzzjin_koac"},c.trueName )
    -- (n==1 and c.trueName ~= "szjemh")
  end,
  on_use = function(self, room, effect)
    room:recastCard(effect.cards, effect.from, siuqmuoh.name,"@@siuqmuoh-inhand-turn")
  end,
})

siuqmuoh:addEffect("maxcards", {
  exclude_from = function(self, player, card)
    return card:getMark("@@siuqmuoh-inhand-turn") > 0
  end,
})

return siuqmuoh
