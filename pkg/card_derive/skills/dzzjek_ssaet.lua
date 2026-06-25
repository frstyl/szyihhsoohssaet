
local dzzjek__ssaet = fk.CreateSkill {
  name = "dzzjek__ssaet",
}

dzzjek__ssaet:addEffect("targetmod", {
  global=true,
  bypass_distances =  function(self, player, skill, card, to)
    return  card and card.name=="dzzjek__ssaet" and card.suit==Card.Heart
  end,
  bypass_times = function(self, player, skill, scope, card)
    return  card and card.name=="dzzjek__ssaet"  and card.suit==Card.Spade
  end,
})


dzzjek__ssaet:addEffect(fk.PreCardUse, {  --PreCardUse moveCardTo
  global=true,
  can_refresh = function (self, event, target, player, data)
    return target == player  and data.card
      and data.card.name=="dzzjek__ssaet" 
  end,
  on_refresh = function (self, event, target, player, data)
    if data.card.suit==Card.Spade then
      data.extraUse = true
    elseif data.card.suit==Card.Diamond then
      data.disresponsiveList = table.simpleClone(player.room.players)
    elseif data.card.suit==Card.Club then
      data.extra_data=data.extra_data or {}
      data.extra_data.ignoreArmorTo=table.simpleClone(player.room.players)
    end
  end
})

return dzzjek__ssaet
