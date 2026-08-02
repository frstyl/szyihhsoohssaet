local piktssaes = fk.CreateSkill {
  name = "piktssaes",
}

Fk:loadTranslationTable{
  ["piktssaes"] = "逼債",
  [":piktssaes"] = "伱主段始旹,伱可選1項發動｡當段內伱｢殺｣{➀次數➁目幖}上限+1",  --限1次

  ["#piktssaes-choose"] = "逼債 選擇",
}


piktssaes:addEffect(fk.EventPhaseStart, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(piktssaes.name) 
      and player.phase==Player.Play
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local choice=room:askToChoice(player,{
      cancelable=true,
      skill_name=self.name,
      choices={"ssaet_target","@ssaet_times"},
    })
      if choice~="Cancel" then
        event:setCostData(self, {choice=choice})
        return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local mark= event:getCostData(self).choice
    room:addPlayerMark(player,mark,1)
    room.logic:getCurrentEvent():findParent(GameEvent.Phase, true):addCleaner(function()
      room:removePlayerMark(player,mark,1)
    end)
  end,
})


return piktssaes
