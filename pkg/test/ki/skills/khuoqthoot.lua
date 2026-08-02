local khuoqthoot = fk.CreateSkill({
  name = "khuoqthoot",
})

Fk:loadTranslationTable{
  ["khuoqthoot"] = "驅𠫓",--驕矜
  [":khuoqthoot"] = "伱起動演練牌旹,伱可發動｡伱抽2,中止當轉｡",


  ["$khuoqthoot1"] = "矢贯坚石，劲冠三军！", 
  ["$khuoqthoot2"] = "吾虽年迈，箭矢犹锋！",
}




local spec={
  anim_type = "drawcards",
  can_trigger = function(self, event, target, player, data)
    return
      target==player
    and  player:hasSkill(khuoqthoot.name) 
  end,

  on_use = function(self, event, target, player, data)
    player:drawCards(2,khuoqthoot.name)
    player.room:endTurn()
  end,
}

khuoqthoot:addEffect(fk.CardUsing, spec)
khuoqthoot:addEffect(fk.CardResponding, spec)

return khuoqthoot
