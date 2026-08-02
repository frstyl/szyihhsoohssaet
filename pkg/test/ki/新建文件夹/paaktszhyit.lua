
local paaktszhyit = fk.CreateSkill {
  name = "paaktszhyit",
}

Fk:loadTranslationTable{
["paaktszhyit"] = "百出",
[":paaktszhyit"] = "主旹.",
["#paaktszhyit"] = "2同類牌轉化爲殺",

["$paaktszhyit1"] = "來一个,殺一个.來一對,殺一雙",
["$paaktszhyit2"] = "絳霞影裏,卷一道凍地仌霜",
}



paaktszhyit:addEffect("targetmod", {
  -- bypass_times = function(self, player, skill, scope, card)
  --   return card --and scope == Player.HistoryPhase 
  --   and table.contains(card.skillNames, paaktszhyit.name)
  --   -- and Fk:getCardById().type==Card.TypeTrick
  --   and S.getCardTypeByName(Fk:getCardById(card.subcards[1])) == 2
  -- end,
  -- bypass_distances = function(self, player, skill, card)
  --   return card and card.skillNames and table.contains(card.skillNames, paaktszhyit.name)
  -- end,
  extra_target_func = function(self, player, skill, card)
    if card and player:hasSkill(paaktszhyit.name) then
      return 3
    end
  end,
})



return paaktszhyit

