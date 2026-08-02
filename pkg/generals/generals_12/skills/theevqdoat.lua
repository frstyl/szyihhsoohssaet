local theevqdoat = fk.CreateSkill{
  name = "theevqdoat",
}


Fk:loadTranslationTable{
  ["theevqdoat"] = "佻达",
  [":theevqdoat"] = "輪始旹選",--忘已

  ["$theevqdoat1"] = "髣髴兮若轻云之蔽月。",
  ["$theevqdoat2"] = "飘飖兮若流风之回雪。",
}

theevqdoat:addEffect(fk.RoundStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(theevqdoat.name)
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local tos = room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = player.room:getOtherPlayers(player),
      skill_name = theevqdoat.name,
      prompt = "#theevqdoat-choose",
      cancelable = true,
    })
    if #to > 0 then
      event:setCostData(self, {tos = tos})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local tos =event:getCostData(self).tos
    room:setPlayerMark(player,"theevqdoat-target",tos[1].id)
    room:addTableMark(player,"theevqdoat-tos",tos[1].id)
    player:drawCards(1,theevqdoat.name)
    event:getCostData(self).tos[1]:drawCards(1,theevqdoat.name)
  end,
})

theevqdoat:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    if player ~=target then return end
    if  player:getMark("theevqdoat-target")~=0 and player.room:getPlayerById(player:getMark("theevqdoat-target")).dead then
      return true
    end
  end,
  on_trigger = function(self, event, target, player, data)
    local room= player.room
    local to = room:getPlayerById(player:getMark("theevqdoat-target"))
    local judge = {
      who = player,
      reason = jyenqmjet.name,
      pattern = ".|.|.",  --除无色
    }
    room:judge(judge)

    local judge2 ={
      who = to,
      reason = jyenqmjet.name,
      pattern = ".|.|.",  --除无色
    }
    room:judge(judge2)

    if judge.card:compareColorWith(judge2.card) and not player.dead then
          room:recover{
            who = player,
            num = 1,
            recoverBy = player,
            skillName = theevqdoat.name,
          }
    end
  end,
})
theevqdoat:addEffect(fk.FinishJudge, {
  mute = true,
  is_delay_effect = true,
  can_trigger = function(self, event, target, player, data)
    return target == player and not player.dead and data.reason == theevqdoat.name  
    and  player.room:getCardArea(data.card) == Card.Processing
  end,
  on_use = function(self, event, target, player, data)
    player.room:obtainCard(player, data.card, true, fk.ReasonPrey, nil, theevqdoat.name)
  end,
})

theevqdoat:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    if player ~=target then return end
    for _, p in ipairs(player.room.alive_players) do
      if p:getMark("theevqdoat-target")==player.id then
        return true 
      end
    end
  end,
  on_trigger = function(self, event, target, player, data)
    for _, p in ipairs(player.room.alive_players) do
      if p:getMark("theevqdoat-target")==player.id then
        player:drawCards(1,theevqdoat.name)
        p:drawCards(1,theevqdoat.name)
        local result = room:askToJointCards(player, {
          players = {player, p},
          min_num = 1,
          max_num = 1,
          cancelable = false,
          skill_name = theevqdoat.name,
          prompt = "#theevqdoat-show",
          -- will_throw = true,
        })
        player:showCards(result[player])
        p:showCards(result[p])

        if result[player][1] and result[p][1] then
          if Fk:getCardById(result[player][1] ).compareColorWith(Fk:getCardById(result[p][1] )) and not player.dead then
            room:recover{
              who = player,
              num = 1,
              recoverBy = player,
              skillName = theevqdoat.name,
            }
          end
        end

      end
    end
  end,
})

theevqdoat:addEffect(fk.RoundEnd, {
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    return player:getMark("theevqdoat-target")~=0
  end,
  on_trigger = function(self, event, target, player, data)
    local room = player.room

    room:setPlayerMark(player,"theevqdoat-tos",table.map(room.players,Util.IdMapper))
    player:drawCards(1,theevqdoat.name)
    room:getPlayerById(player:getMark("theevqdoat-target")):drawCards(1,theevqdoat.name)
  end,
})
return theevqdoat
