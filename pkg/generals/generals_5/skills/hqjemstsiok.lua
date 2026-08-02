local hqjemstsiok = fk.CreateSkill {
  name = "hqjemstsiok",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{
  ["hqjemstsiok"] = "饜足",
  [":hqjemstsiok"] = "{酒/肉/迷}對伱生效前,(若其未失效)伱可發動,无效之,伱抽1",


  ["#hqjemstsiok-nullify"] = "饜足 是否令 %arg 對伱无效",

  ["$hqjemstsiok1"] = "客官,昰酒可渾",
}

hqjemstsiok:addEffect(fk.PreCardEffect, {
  can_trigger = function(self, event, target, player, data)
    return data.to == player and player:hasSkill(hqjemstsiok.name) 
    and not data.nullified
    and table.contains({"nziuk", "tsiuh", "meej"}, data.card.trueName)
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
      skill_name=hqjemstsiok.name, 
      prompt="#hqjemstsiok-nullify:::"..data.card:toLogString(),
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    -- data.nullified = true
    S.effectNullify(data,player,hqjemstsiok.name)
    player:drawCards(1,hqjemstsiok.name)
  end,
})




return hqjemstsiok
