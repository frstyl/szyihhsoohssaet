local dzziacqszics = fk.CreateSkill{
  name = "dzziacqszics",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["dzziacqszics"] = "常勝",
  [":dzziacqszics"] = "賭鬥旹伱黑桃牌視爲k點",

  ["#dzziacqszics-choice"] = "常勝：伱可改變賭鬥牌點數",
}

dzziacqszics:addEffect(fk.PindianCardsDisplayed, {
  mute = true,
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(dzziacqszics.name) 
    and (
      (data.from == player and data.fromCard.suit==Card.Spade)  --zzin keec 
    or (table.contains(data.tos, player) and data.results[player].suit==Card.Spade )
  )
  end,
  on_trigger = function(self, event, target, player, data)
    player.room:changePindianNumber(data, player, 13, dzziacqszics.name)
  end,
})

return dzziacqszics
