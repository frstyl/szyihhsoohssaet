local liuksyer = fk.CreateSkill {
  name = "liuksyer",
}
Fk:loadTranslationTable{
  ["liuksyer"] = "六繐",
  [":liuksyer"] = "伱成爲殺目幖旹發動.伱判定,若无點數或點數不大于6,將伱自目幖迻除",
}
liuksyer:addEffect(fk.TargetConfirming, {
  can_trigger = function(self, event, target, player, data)
    return data.to == player and player:hasSkill(liuksyer.name) and
    data.card.trueName == "ssaet" 
  end,
  on_use = function (self, event, target, player, data)
    local judgeData = {
      who = player,
      reason = liuksyer.name,
      pattern = ".|0~6|.",
    }
    player.room:judge(judgeData)

    if judgeData:matchPattern() then
    data:cancelTarget(target)

    end
  end
})

return liuksyer
