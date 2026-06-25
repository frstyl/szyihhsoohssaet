local lihcaok = fk.CreateSkill {
  name = "lihcaok",
}
Fk:loadTranslationTable{
["lihcaok"] = "理樂",
[":lihcaok"] = "伱判定牌生效後,若其在處理區,伱可發動,伱獲取之",  --同隊不计入距离 均傷

["#lihcaok-choose"] = "理樂 選擇一角色 視爲對其使用殺",
}
lihcaok:addEffect(fk.FinishJudge, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(lihcaok.name) and
      data.card and player.room:getCardArea(data.card) == Card.Processing
  end,
  on_use = function(self, event, target, player, data)
    player.room:obtainCard(player, data.card, true, fk.ReasonPrey, player, lihcaok.name)  --ReasonJustMove
  end,
})


return lihcaok
