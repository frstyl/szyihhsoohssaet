local biuqdzsaa = fk.CreateSkill {
  name = "biuqdzsaa",
  tags = { Skill.Compulsory,Skill.Lord},
  dynamic_desc = function(self, player)
    return "biuqdzsaa_inner:" .. player:getMark("biuqdzsaa")+1
  end,
}

Fk:loadTranslationTable{
  ["biuqdzsaa"] = "浮槎",
  [":biuqdzsaa"] = "鎖，其它角色至你距离+1。輪終,若其它角色至伱距離均大于x,伱獲勝(x爲遊戲人數至少爲5)",

  [":biuqdzsaa_inner"] = "鎖，其它角色至你距离+{1}。輪終,若其它角色至伱距離均大于x,伱獲勝(x爲遊戲人數至少爲5)",
}

biuqdzsaa:addEffect("distance", {
  correct_func = function(self, from, to)
    if to:hasSkill(biuqdzsaa.name) then
      return 1 +to:getMark("biuqdzsaa")
    end
  end,
})

biuqdzsaa:addEffect(fk.RoundEnd, {
  anim_type = "big",
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(biuqdzsaa.name)   then return end
    local room=player.room
    local n=#room.players
    if n<5 then n =5 end
    for _, p in ipairs(room:getOtherPlayers(player)) do
      if p:compareDistance(player,n,"<=") then return end
    end
    return true
  end,
  on_use = function (self, event, target, player, data)
    if player.role == "lord" or player.role == "loyalist" then  --若爲xx模式
      player.room:gameOver("lord+loyalist")
    else
      player.room:gameOver(player.role)
    end
  end,
})

return biuqdzsaa
