local zyinqssaavs = fk.CreateSkill{
  name = "zyinqssaavs",
}

Fk:loadTranslationTable{
  ["zyinqssaavs"] = "巡哨",
  [":zyinqssaavs"] = "伱攻程內其它角色使用殺結算終後,若此牌未致傷,伱可發動,伱將此牌交与1除其外一角色",

  ["#zyinqssaavs-invoke"] = "巡哨 將%arg 交与1角色",

  ["$zyinqssaavs1"] = "尒等鼠輩舔貓鼻子膽子倒不小",
  ["$zyinqssaavs2"] = "敵軍已至速報与眾位哥哥",
  ["$zyinqssaavs3"] = "昰巡山還巡出好東西來矣",
}


zyinqssaavs:addEffect(fk.CardUseFinished, {
  can_trigger = function(self, event, target, player, data)
    return target ~= player and player:hasSkill(zyinqssaavs.name) 
    and player:inMyAttackRange(target)
    and  data.card.trueName=="ssaet" 
    and (not data.damageDealt )
    and  player.room:getCardArea(data.card) == Card.Processing
    end,
  on_cost= function(self, event, target, player, data)
    local room=player.room
        local to = room:askToChoosePlayers(player, {
          targets = room:getOtherPlayers(target),
          min_num = 1,
          max_num = 1,
          prompt = "#zyinqssaavs-invoke:::"..data.card:toLogString(),
          skill_name = zyinqssaavs.name,
          cancelable = true,
        })
        if #to > 0 then
          event:setCostData(self,{tos=to})  --tos?
          return true
        end
  end,
  on_use = function(self, event, target, player, data)
    player.room:moveCardTo(data.card,Player.Hand, event:getCostData(self).tos[1], fk.ReasonJustMove, zyinqssaavs.name,  nil, true, player)
  end,
})

return zyinqssaavs
