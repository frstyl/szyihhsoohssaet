
local hquoqhqut = fk.CreateSkill {
  name = "hquoqhqut",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["hquoqhqut"] = "紆鬱",
  [":hquoqhqut"] = "伱末段始旹,必發,若當轉伱曾致傷,伱回1, 否則伱流失1,抽2",
}

hquoqhqut:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(hquoqhqut.name) 
    and player.phase == Player.Finish
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
              local n = #player.room.logic:getActualDamageEvents(1, function (e)
            return e.data.from == player
          end, Player.HistoryTurn)
    if n==0 then
      room:loseHp(player, 1, hquoqhqut.name,player )
      if not player.dead then
        player:drawCards(2, hquoqhqut.name)
      end
    else
      room:recover({
        who = player,
        num = 1,
        recoverBy = player,
        skillName = hquoqhqut.name,
      })
    end
  end,
})

return hquoqhqut
