local bvoatddiu = fk.CreateSkill{
  name = "bvoatddiu",
}

Fk:loadTranslationTable{
["bvoatddiu"] = "拔籌",
[":bvoatddiu"] = "當伱致傷後,若爲受傷角色當輪首次受傷,伱可發動.伱抽2",


["$bvoatddiu1"] = "等吾拿矣頭功再作打算",
["$bvoatddiu2"] = "兄弟,吾先行一步",
}



bvoatddiu:addEffect(fk.Damage, {
  can_refresh = function(self, event, target, player, data)
    return target == player  and data.to:getMark("bvoatddiu-round")==0 
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:setPlayerMark(data.to,"bvoatddiu-round",1)
      local damage_events = player.room.logic:getActualDamageEvents(1, function (e)
        return e.data.to == data.to
      end, Player.HistoryRound)
      if #damage_events == 1 and damage_events[1].data == data then
        event:setCostData(self,{bvoatddiu=true})
      end
  end,
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(bvoatddiu.name)  and event:getCostData(self)
  end,
  on_use = function(self, event, target, player, data)
      player:drawCards(2,bvoatddiu.name)
  end,
})


return bvoatddiu
