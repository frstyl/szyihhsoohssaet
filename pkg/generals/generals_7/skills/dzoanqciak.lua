local dzoanqciak = fk.CreateSkill {
  name = "dzoanqciak",
}

Fk:loadTranslationTable{
  ["dzoanqciak"] = "殘虐",
  [":dzoanqciak"] = "每輪限1.當伱攻程內1脚色瀕死結算後(每局每脚色限1次),伱可預打出1牌選擇伱距離1內1其它脚色發動.伱与其2傷.若伱因此技能殺死脚色,伱可流失1再次執行.",  --每脚色1次?每輪1次?刷新?殺死發動?

  ["#dzoanqciak-choose"] = "殘虐 打出1牌 予1脚色2傷",
  ["#dzoanqciak-losehp"] = "殘虐 選擇脚色 伱流失1 与其2傷",

  ["$dzoanqciak1"] = "讓俺再宰一个",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

dzoanqciak:addEffect(fk.AfterDying, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(dzoanqciak.name)  
    and data.extra_data
    and data.extra_data.dzoanqciak
    and table.contains(data.extra_data.dzoanqciak, player.id)
    and not table.contains(player:getTableMark(dzoanqciak.name), target.id)
    and player:usedSkillTimes(dzoanqciak.name, Player.HistoryRound) ==0
  end,
  on_cost = function(self, event, target, player, data)
      local room = player.room
      local to, card =  room:askToChooseCardsAndPlayers(player, {
        min_card_num = 1,
        max_card_num = 1,
        min_num = 1,
        max_num = 1,
        targets = table.filter(room:getOtherPlayers(player,false), function(p)
        return player:compareDistance(p,1,"<=")
      end),
        prompt = "#dzoanqciak-choose",
        skill_name = dzoanqciak.name,
        -- will_throw = true,
        pattern=tostring(Exppattern{ id = table.filter(player:getCardIds("he"),function(id)
          return  not player:prohibitResponse(Fk:getCardById(id))
        end
        ) }),
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
    S.playCard(event:getCostData(self).card,dzoanqciak.name,player)
    local tos = event:getCostData(self).tos
    if  tos[1].dead then return end

    local damageData={
      from = player,
      to = tos[1],
      damage = 2,
      damageType = fk.NormalDamage,
      skillName = dzoanqciak.name,
    }
    room:damage(damageData)

    while true do
      if not tos[1].dead then return end
      local death_event = player.room.logic:getEventsByRule(GameEvent.Death, 1, function (e)
          return  e.data and e.data.who==tos[1] 
          and e.data.killer==player and e.data.damage and e.data.damage.skillName ==dzoanqciak.name
          -- e.data.damage == damageData
      end, 1)
      if #death_event==0 then return end

        tos = room:askToChoosePlayers(player, {
          targets = table.filter(room:getOtherPlayers(player,false), function(p)
            return player:compareDistance(p,1,"<=")
          end),
          min_num = 1,
          max_num = 1,
          prompt = "#dzoanqciak-losehp",
          skill_name = dzoanqciak.name,
          cancelable = true,
        })
        if #tos>0 and not tos[1].dead  then
          room:loseHp(player,1,dzoanqciak.name,player)
          damageEvent = room:damage{
            from = player,
            to = tos[1],
            damage = 2,
            damageType = fk.NormalDamage,
            skillName = dzoanqciak.name,
          }
        else
          return 
        end
    end
  end,
})

dzoanqciak:addEffect(fk.EnterDying, {
  can_refresh = function(self, event, target, player, data)
    return player:hasSkill(dzoanqciak.name,true)  
    and (player:inMyAttackRange(data.who) or target==player ) --😓️
  end,
  on_refresh = function(self, event, target, player, data)
    data.extra_data =data.extra_data or {}
    data.extra_data.dzoanqciak =data.extra_data.dzoanqciak or {}
    table.insert(data.extra_data.dzoanqciak,player.id)
  end,
})
-- dzoanqciak:addEffect(fk.Deathed, {
--   anim_type = "offensive",
--   can_trigger = function(self, event, target, player, data)
--     if  player:hasSkill(dzoanqciak.name) then
--       local e = player.room.logic:getCurrentEvent():findParent(GameEvent.Damage)
--       if e and e.data.skillName == dzoanqciak.name then
--         local skill_event = e:findParent(GameEvent.SkillEffect)
--         return skill_event and skill_event.data.skill.name == dzoanqciak.name and skill_event.data.who == player
--       end
--     end
--   end,
--   on_cost = function(self, event, target, player, data)
--       local room = player.room
--         local to = room:askToChoosePlayers(player, {
--           targets = table.filter(room:getOtherPlayers(player,false), function(p)
--             return player:distanceTo(p) == 1 
--           end),
--           min_num = 1,
--           max_num = 1,
--           prompt = "#dzoanqciak-losehp",
--           skill_name = dzoanqciak.name,
--           cancelable = true,
--         })
--     if #to>0  then
--         event:setCostData(self, { tos=to})
--       return true
--     end
--   end,
--   on_use = function(self, event, target, player, data)
--     local room = player.room
--     room:loseHp(player,1,dzoanqciak.name,player)
--     if not event:getCostData(self).tos[1].dead then
--     room:damage{
--       from = player,
--       to = event:getCostData(self).tos[1],
--       damage = 2,
--       damageType = fk.NormalDamage,
--       skillName = dzoanqciak.name,
--     }
--     end
-- end,
-- })
return dzoanqciak
