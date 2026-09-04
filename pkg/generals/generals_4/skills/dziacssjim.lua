local dziacssjim = fk.CreateSkill{
  name = "dziacssjim",
}

Fk:loadTranslationTable{
  ["dziacssjim"] = "匠心",
  [":dziacssjim"] = "一占卜牌生效後,若其爲行動或物資牌,伱可發動,伱抽1,獲得1匠心值.伱可迻去1匠心值額外發動1次仿製2",


  ["$dziacssjim1"] = "鎚𣪲之閒,匠心獨釀,別具一格",
  ["$dziacssjim2"] = "精華在筆耑,咫尺匠心難",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 


dziacssjim:addEffect(fk.FinishJudge, {
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(dziacssjim.name) and S.getCardTypeByName(data.card.trueName)==2
  end,
  on_use = function(self, event, target, player, data)
    player:drawCards(1,dziacssjim.name)
    player.room:addPlayerMark(player,"dziacssjim",1)
  end,
})



return dziacssjim
