Fk:loadTranslationTable{
  ["sziuhbxis"] = "守僃",
  -- [":sziuhbxis"] = "末段始旹伱可發動.弃置全部手牌,抽x+1,且若x>1,伱回1(x爲伱因此所弃牌數)",
  [":sziuhbxis"] = "任一轉終,若伱有滿足項,伱可發動執行之.當轉內,伱{➀所失去牌之合大于等于2,伱抽2➁所減少體力之合大于等于2,伱回2}",

  ["#sziuhbxis-invoke"] = "守僃 選擇任意牌",
 
  ["$sziuhbxis1"] = "我等在此堅守戒僃",
  ["$sziuhbxis2"] = "昰後路早就安排妥當",
}

local sziuhbxis = fk.CreateSkill{
  name = "sziuhbxis",
  -- tags={Skill.Compulsory},
}

sziuhbxis:addEffect(fk.TurnEnd, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not   player:hasSkill(sziuhbxis.name) then return end
    local room=player.room
    local n,m=0,0
      room.logic:getEventsOfScope(GameEvent.ChangeHp, 1, function (e)
        local dat=e.data
          if dat.who == player and dat.num<0 then
            n=n-dat.num
          end
      end, Player.HistoryTurn)

      room.logic:getEventsOfScope(GameEvent.MoveCards, 1, function (e)
      for _, move in ipairs(e.data) do
        if move.from ==player and (move.to~=player or not table.contains({Card.PlayerEquip,Card.PlayerHand }, move.toArea)) then
        for _, info in ipairs(move.moveInfo) do
          if   (info.fromArea == Card.PlayerHand or info.fromArea == Card.PlayerEquip)   then
          n=n+1
          end
        end
        end
      end
      end, Player.HistoryTurn)
      if n>=2 or m>=2 then
        event:setCostData(self, {n = n,m=m})
        return true
      end
  end,
  on_use = function(self, event, target, player, data)
   local room=player.room
   local dat=event:getCostData(self)
   if dat.m >=2 then
    player:drawCards(2,sziuhbxis.name)
   end
   if dat.n>=2 then
    player.room:recover{
      who = player,
      num = 2,
      recoverBy = player,
      skillName = sziuhbxis.name,
    }
  end
  end,
})


return sziuhbxis
