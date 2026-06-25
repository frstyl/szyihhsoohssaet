local punsjioch = fk.CreateSkill{
  name = "punsjioch",
}

Fk:loadTranslationTable{
  ["punsjioch"] = "奮勇",
  [":punsjioch"] = "伱受致傷旹,伱獲得傷害值幖記.每轉終旹,若幖記不少于2,伱可發動,伱迻除幖記執行抽等量牌,獲得1額外轉",

  ["@punsjioch"] = "奮勇",

  ["$punsjioch1"] = "待我拏駐伱旹碎屍萬段",

}


punsjioch:addEffect(fk.TurnEnd, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(punsjioch.name) and player:getMark("@punsjioch") >=2
  end,
  on_use = function(self, event, target, player, data)
    local n=player:getMark("@punsjioch")
    player:drawCards(n,punsjioch.name)
    player.room:addPlayerMark(player,"@punsjioch",0)
    player:gainAnExtraTurn(true, punsjioch.name)
  end,
})


punsjioch:addEffect(fk.Damaged, {
  can_refresh = function(self, event, target, player, data)
    return target == player and player:hasSkill(punsjioch.name) 
  end,
  on_refresh  = function(self, event, target, player, data)
    player.room:addPlayerMark(player,"@punsjioch",data.damage)
  end,
})

punsjioch:addEffect(fk.Damage, {
  can_refresh  = function(self, event, target, player, data)
    return target == player and player:hasSkill(punsjioch.name) 
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:addPlayerMark(player,"@punsjioch",data.damage)
  end,
})
return punsjioch
