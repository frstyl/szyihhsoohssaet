local tszjecqbuat = fk.CreateSkill{
  name = "tszjecqbuat",
}


Fk:loadTranslationTable{
  ["tszjecqbuat"] = "征伐",
  [":tszjecqbuat"] = "末段始旹選擇1其它可拼點角色發動.拼點,若伱贏,視爲伱使用殺,无視距離可指定x目幖,x爲勢力(陣營)數;沒贏,伱抽1,牢+1",

  ["#tszjecqbuat-choose"] = "征伐 選擇拼點目幖",
  ["#tszjecqbuat-win"] = "征伐 選擇殺目幖",
}

local getRebelNumber = function (room)
  local n=0
  if room:isGameMode("role_mode") then  --主忠必有  lord loyalist rebel renegade civilian
    for _, p in ipairs(room.players) do
      if p.role=="rebel" or p.role=="renegade" then 
        n=n+1
      end
    end
    goto result
  end
  ::result::
  if n==0 then n=1 end
  return n
end

tszjecqbuat:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(tszjecqbuat.name) and player.phase == Player.Finish
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
      local targets = table.filter(room:getOtherPlayers(player, false), function (p)
        return player:canUseTo(Fk:cloneCard("ssaet"), p, {bypass_distances = true, bypass_times = true})
      end)
      local tos = room:askToChoosePlayers(player, {
        min_num = 1,
        max_num = S.getRebelNumber(room),
        targets = targets,
        prompt = "#tszjecqbuat-win",
        cancelable=false,
      })
      room:useVirtualCard("ssaet", nil, player, tos, tszjecqbuat.name, true)  --zzin souk
    else
      player:drawCards(1, tszjecqbuat.name)
  	  room:addPlayerMark(player, "@loav",1)
    end
  end,
})



return tszjecqbuat
