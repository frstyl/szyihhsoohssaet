local baohSkill = fk.CreateSkill {
  name = "#baoh_skill",
  attached_equip = "baoh",
}

baohSkill:addEffect(fk.AfterCardUseDeclared, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(baohSkill.name) and data.card.name == "ssaet"
  end,
  on_use = function(self, event, target, player, data)
    data:changeCard("fire__ssaet", data.card.suit, data.card.number, baohSkill.name)
  end,
})

baohSkill:addTest(function (room, me)
  local card = room:printCard("baoh")
  local comp2 = room.players[2]
  local vine = room:printCard("vine")
  FkTest.runInRoom(function ()
    room:useCard{
      from = me,
      tos = {me},
      card = card,
    }
    room:useCard{
      from = comp2,
      tos = {comp2},
      card = vine,
    }
    room:useVirtualCard("ssaet", nil, me, comp2)
  end)
  lu.assertEquals(comp2.hp, 4)

  FkTest.setNextReplies(me, {"1"})
  FkTest.runInRoom(function ()
    room:useVirtualCard("ssaet", nil, me, comp2)
  end)
  lu.assertEquals(comp2.hp, 2)

  FkTest.setNextReplies(me, {"1"})
  FkTest.runInRoom(function ()
    room:useVirtualCard("thunder__ssaet", nil, me, comp2)
  end)
  lu.assertEquals(comp2.hp, 1)
end)

return baohSkill
