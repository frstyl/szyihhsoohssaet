local skill = fk.CreateSkill {
  name = "#tszhjek_thoos_skill",
  tags = { Skill.Compulsory },
  attached_equip = "tszhjek_thoos",
}

skill:addEffect("distance", {
  correct_func = function(self, from, to)
    if from:hasSkill(skill.name) then
      return -1
    end
  end,
})

skill:addTest(function (room, me)
  local comp3 = room.players[3]
  local card = room:printCard("tszhjek_thoos")
  FkTest.runInRoom(function ()
    room:useCard{from = me, tos = {me}, card = card}
  end)
  lu.assertEquals(me:distanceTo(comp3), 1)
end)

return skill
