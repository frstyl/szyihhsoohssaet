
local kwehssih = fk.CreateSkill {
  name = "kwehssih",
}

Fk:loadTranslationTable{
["kwehssih"] = "詭使",
[":kwehssih"] = "伱起動牌前伱可發動｡此牌目幖改爲伱攻程內全部腳色(除目幖上限需合理)",
--區分伱已此法所起動 与 此牌?
["#kwehssih"] = "2同類牌轉化爲殺",

["$kwehssih1"] = "來一个,殺一个.來一對,殺一雙",
["$kwehssih2"] = "絳霞影裏,卷一道凍地仌霜",
}




kwehssih:addEffect(fk.PreCardUse, {
  can_trigger = function (self, event, target, player, data)
    return target == player and player:hasSkill(kwehssih.name)
  end,
  on_use = function (self, event, target, player, data)
    data.extra_data=data.extra_data or {}
    data.extra_data.kwehssih={from=player.id,tos=table.map(data.tos,Util.IdMapper)}
    local tos = data:getExtraTargets({bypass_distances = false})
    tos = table.filter(tos,function(p)return player:inMyAttackRange(p) end)
    table.insertTable(data.tos,tos)
    player.room:sortByAction(data.tos)
  end,
})

kwehssih:addEffect(fk.CardEffecting, {
  can_refresh = function (self, event, target, player, data)
    return player==data.to --??起動者
    and data.extra_data and data.extra_data.kwehssih
    and not table.contains(data.extra_data.kwehssih.tos, data.to.id)
  end,
  on_refresh = function (self, event, target, player, data)
    data.nullified=true
  end,
})



return kwehssih

