local dzoanqciak = fk.CreateSkill {
  name = "dzoanqciak",
}

Fk:loadTranslationTable{
  ["dzoanqciak"] = "殘虐",
  [":dzoanqciak"] = "每輪限1.當伱攻程內1角色進入瀕死(每角色限1次),伱可預弃1牌選擇伱距離1內1其它角色發動發動.伱与其2傷.若伱因此殺死角色,伱可流失1體力再次發動",  --每角色1次?每輪1次?刷新?殺死發動?

  ["#dzoanqciak-choose"] = "殘虐 弃1牌与1角色2傷",
  ["#dzoanqciak-losehp"] = "殘虐 選擇角色 伱流失1體力 与其2傷",

  ["$dzoanqciak1"] = "讓俺再宰一个",
}


dzoanqciak:addEffect(fk.EnterDying, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(dzoanqciak.name)  and (player:inMyAttackRange(target) or target==player) --😓️
    and not table.contains(player:getTableMark(dzoanqciak.name), target.id)
    and player:usedSkillTimes(dzoanqciak.name, Player.HistoryRound) ==0
  end,

  on_cost = function(self, event, target, player, data)
      local room = player.room
      local include_equip = target~=player
          local to, card =  room:askToChooseCardsAndPlayers(player, {
            min_card_num = 1,
            max_card_num = 1,
            min_num = 1,
            max_num = 1,
            targets = table.filter(room:getOtherPlayers(player,false), function(p)
            return player:distanceTo(p) == 1 
          end),
            prompt = "#dzoanqciak-choose",
            skill_name = dzoanqciak.name,
            will_throw = true,
            cancelable = true,
          })
    if #to>0 and #card>0 then
        event:setCostData(self, { tos=to,card=card })
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:addTableMark(player, dzoanqciak.name, target.id)
    room:throwCard(event:getCostData(self).card, dzoanqciak.name, player, player)
    if not event:getCostData(self).tos[1].dead and not player.dead then
    room:damage{
      from = player,
      to = event:getCostData(self).tos[1],
      damage = 2,
      damageType = fk.NormalDamage,
      skillName = dzoanqciak.name,
    }
    end
end,
})


dzoanqciak:addEffect(fk.Deathed, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    if  player:hasSkill(dzoanqciak.name) then
      local e = player.room.logic:getCurrentEvent():findParent(GameEvent.Damage)
      if e and e.data.skillName == dzoanqciak.name then
        local skill_event = e:findParent(GameEvent.SkillEffect)
        return skill_event and skill_event.data.skill.name == dzoanqciak.name and skill_event.data.who == player
      end
    end
  end,
  on_cost = function(self, event, target, player, data)
      local room = player.room
        local to = room:askToChoosePlayers(player, {
          targets = table.filter(room:getOtherPlayers(player,false), function(p)
            return player:distanceTo(p) == 1 
          end),
          min_num = 1,
          max_num = 1,
          prompt = "#dzoanqciak-losehp",
          skill_name = dzoanqciak.name,
          cancelable = true,
        })
    if #to>0  then
        event:setCostData(self, { tos=to})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    if not event:getCostData(self).tos[1].dead and not player.dead then
    room:damage{
      from = player,
      to = event:getCostData(self).tos[1],
      damage = 2,
      damageType = fk.NormalDamage,
      skillName = dzoanqciak.name,
    }
    end
end,
})
return dzoanqciak
