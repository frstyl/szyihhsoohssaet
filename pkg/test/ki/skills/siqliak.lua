local siqliak = fk.CreateSkill{
  name = "siqliak",
}

Fk:loadTranslationTable{
  ["siqliak"] = "思略",
  [":siqliak"] = "主旹无限次,伱選至手1殺或裝僃牌發動.緟鑄之.以此所獲牌1轉不計入手牌上限",

  ["#siqliak"] = "思略：緟鑄殺",
  ["@@siqliak-inhand-turn"] = "思略",

  ["$siqliak1"] = "還有後招",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

siqliak:addEffect("active", {
  anim_type = "drawcard",
  prompt = "#siqliak",
  min_card_num = 1,
  target_num = 0,
  card_filter = function(self, player, to_select, selected)
    if #selected==0 then return not table.contains(player:getTableMark("siqliak-phase"), S.getCardTypeByName(to_select)) end
    local typ=S.getCardTypeByName(selected[1])

    return   S.getCardTypeByName(to_select)==typ

  end,
  on_use = function(self, room, effect)
    room:addTableMark(effect.from, "siqliak-phase",S.getCardTypeByName(effect.cards[1]))
    room:recastCard(effect.cards, effect.from, siqliak.name,"@@siqliak-inhand-turn")
  end,
})

siqliak:addEffect("maxcards", {
  exclude_from = function(self, player, card)
    return card:getMark("@@siqliak-inhand-turn") > 0
  end,
})

return siqliak
