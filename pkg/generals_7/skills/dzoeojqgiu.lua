local dzoeojqgiu = fk.CreateSkill{
  name = "dzoeojqgiu",
  tags = { Skill.Compulsory },
}


Fk:loadTranslationTable{
["dzoeojqgiu"] = "財賕",
[":dzoeojqgiu"] = "伱主段始旹,其它角色同時交予伱任意數量牌｡冣多者令伱視爲對其所選目幖使用殺",

["#dzoeojqgiu-choose"] = "財賕 選擇一角色 視爲對其使用殺",
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

dzoeojqgiu:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(dzoeojqgiu.name) and data.phase==Player.Play
  end,
	on_cost= function(self, event, target, player, data)
      event:setCostData(self, {tos = player.room:getOtherPlayers(player)})
      return true
  end,
	on_use = function(self, event, target, player, data)
    local room=player.room
    local targets = table.filter(room:getOtherPlayers(player, false), function(p)
      return not p:isNude()
    end)
    local result = room:askToJointCards(player, {
      players = targets,
      min_num = 1,
      max_num = 999,
      cancelable = true,
      skill_name = dzoeojqgiu.name,
      prompt = "#dzoeojqgiu-give::" .. player.id,
    })
    local moveInfos = {}
    local from ={}
    local n=0
    for _, p in ipairs(targets) do
      if #result[p]>n then table.insert(from,p) end
      table.insert(moveInfos, {
        ids = result[p],
        from = p,
        to = player,
        toArea = Card.PlayerHand,
        moveReason = fk.ReasonGive,
        proposer = p,
        skillName = dzoeojqgiu.name,
      })
      
    end
    room:moveCards(table.unpack(moveInfos))
    if player.dead or not from[1] or from[1].dead  then return end
    local to = room:askToChoosePlayers(from[1], {
      targets = table.filter(room.alive_players,function(p)
        return player:inMyAttackRange(p)
      end),
      min_num = 1,
      max_num = 1,
      prompt = "#dzoeojqgiu-choose:::"..player.id,
      skill_name = dzoeojqgiu.name,
      cancelable = true,
    })
    if #to~=1 then return end
    room:useVirtualCard("ssaet", nil, player, to, dzoeojqgiu.name, true)
  end,
})

return dzoeojqgiu
