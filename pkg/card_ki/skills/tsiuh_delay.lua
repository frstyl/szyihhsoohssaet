local tsiuhSkill = fk.CreateSkill {
  name = "tsiuh_delay",
}

Fk:loadTranslationTable{
["@tsyis-turn"] = "酒",
}

tsiuhSkill:addEffect(fk.PreCardUse, {
  -- global = true,
  late_refresh = true,
  can_refresh = function(self, event, target, player, data)
    return target == player and data.card.trueName == "ssaet" and player.drank > 0
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    data.additionalDamage = (data.additionalDamage or 0) + player.drank  
    data.extra_data = data.extra_data or {}
    data.extra_data.drankBuff = player.drank
    player.drank = 0
    room:setPlayerMark(player,"@tsyis-turn",0)
    room:broadcastProperty(player, "drank")
  end,
})

tsiuhSkill:addEffect(fk.TurnEnd, {
  -- global = true,
  late_refresh = true,
  can_refresh = function(self, event, target, player, data)
    return player.drank > 0
  end,
  on_refresh = function(self, event, target, player, data)
    player.drank = 0
    room:setPlayerMark(player,"@tsyis-turn",0)
    player.room:broadcastProperty(player, "drank")
  end,
})


return tsiuhSkill
