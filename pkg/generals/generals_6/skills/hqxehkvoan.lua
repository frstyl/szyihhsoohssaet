local hqxehszjer = fk.CreateSkill{
  name = "hqxehszjer",
}
Fk:loadTranslationTable{
  ["hqxehszjer"] = "倚勢",
  [":hqxehszjer"] = "伱起｢殺｣旹,伱可發動.伱抽x(x爲与伱同勢力存活腳色數)",


  ["$hqxehszjer1"] = "左右莫怕,与我打昰斯",
  ["$hqxehszjer2"] = "伱可知我上頭是何許人物",
}

hqxehszjer:addEffect(fk.CardUsing, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(hqxehszjer.name) 
    and data.card.trueName=="ssaet"
      -- and (data.card.suit==Card.Spade or data.card.suit==Card.Club)
      --table.contains()
  end,
  on_use = function(self, event, target, player, data)
    local kingdom=player.kingdom
    local n=1
    for _,p in ipairs(player.room:getOtherPlayers(player)) do
      if p.kingdom==player.kingdom then
        n=n+1
      end
    end
    player:drawCards(n, hqxehszjer.name)
  end,
})


return hqxehszjer
