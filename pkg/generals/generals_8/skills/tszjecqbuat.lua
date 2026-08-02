local tszjecqbuat = fk.CreateSkill{
  name = "tszjecqbuat",
}


Fk:loadTranslationTable{
  ["tszjecqbuat"] = "征伐",
  [":tszjecqbuat"] = "伱末段始旹,伱可与1其它脚色賭鬥發動｡若伱贏,伱選1多x腳色對其起動虛擬｢殺｣(x爲身分(勢力)數);沒贏,伱抽3,自守至伱下下(轉終)",  --下个 轉終 not 下轉之終

  ["#tszjecqbuat-choose"] = "征伐 選擇賭鬥目幖",
  ["#tszjecqbuat-win"] = "征伐 選擇殺目幖",
}

local getRoleNumber = function (room)
  local n=0
  -- if room:isGameMode("role_mode") then end
  local t={}
    for _, p in ipairs(room.players) do
      table.insertIfNeed(t,p.role)
    end
  return #t
end

tszjecqbuat:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player 
    and player:hasSkill(tszjecqbuat.name) 
    and player.phase == Player.Finish
    and not player:isKongcheng()
    and
      table.find(player.room.alive_players, function(p)
        return player:canPindian(p)
      end)
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local targets = table.filter(room.alive_players, function(p)
      return player:canPindian(p)
    end)
    local to = room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = targets,
      skill_name = tszjecqbuat.name,
      prompt = "#tszjecqbuat-choose",
      cancelable = true,
    })
    if #to > 0 then
      event:setCostData(self, {tos = to})
      return true
    end
  end,

  on_use = function(self, event, target, player, data)
    local room = player.room
    local to = event:getCostData(self).tos[1]
    local pindian = player:pindian({to}, tszjecqbuat.name)
    if pindian.results[to].winner == player then
      -- local targets = table.filter(room:getOtherPlayers(player, false), function (p)
        -- return player:canUseTo(Fk:cloneCard("ssaet"), p, {bypass_distances = true, bypass_times = true})
      -- end)
      local tos = room:askToChoosePlayers(player, {
        min_num = 1,
        max_num = getRoleNumber(room),
        targets = room:getOtherPlayers(player),
        prompt = "#tszjecqbuat-win",
        cancelable=false,
      })
      room:useVirtualCard("ssaet", nil, player, tos, tszjecqbuat.name, true)  --zzin souk
    else
      player:drawCards(3, tszjecqbuat.name)
      room:addSkill("dzjissziuh")
      room:addPlayerMark(player, "@@dzjissziuh", 2)
      room:addPlayerMark(player, "tszjecqbuat", 2)
    end
  end,
})

tszjecqbuat:addEffect(fk.TurnEnd, {
  can_refresh = function(self, event, target, player, data)
    return target == player and player:getMark("tszjecqbuat")>0 
  end,
  on_refresh= function(self, event, target, player, data)
      room:removePlayerMark(player, "@@dzjissziuh", 1)
      room:removePlayerMark(player, "tszjecqbuat", 1)
  end,
})

return tszjecqbuat
