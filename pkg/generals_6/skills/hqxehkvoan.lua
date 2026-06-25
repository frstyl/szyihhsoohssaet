local hqxehkvoan = fk.CreateSkill{
  name = "hqxehkvoan",
}
Fk:loadTranslationTable{
  ["hqxehkvoan"] = "倚官",
  [":hqxehkvoan"] = "伱使用黑桃梅花殺旹,伱可發動.伱抽x",

  ["@@hqxehkvoan"] = "倚官",

  ["$hqxehkvoan1"] = "左右莫怕,与我打昰斯",
  ["$hqxehkvoan2"] = "伱可知我上頭是何許人物",
}

hqxehkvoan:addEffect(fk.CardUsing, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(hqxehkvoan.name) and
      data.card.trueName=="ssaet"
      and (data.card.suit==Card.Spade or data.card.suit==Card.Club)
      --table.contains()
  end,
  on_use = function(self, event, target, player, data)
    player:drawCards(2, hqxehkvoan.name)
  end,
})


return hqxehkvoan
