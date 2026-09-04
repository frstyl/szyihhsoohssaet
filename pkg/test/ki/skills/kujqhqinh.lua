local kujqhqinh = fk.CreateSkill {
  name = "kujqhqinh",
  tags = { Skill.Compulsory},--,Skill.Lord
}

Fk:loadTranslationTable{
  ["kujqhqinh"] = "歸𠃊",  --星列
  [":kujqhqinh"] = "其它脚色死亾旹,伱獲勝",
}

local spec={
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(kujqhqinh.name, true) and #player.room.alive_players==2 and not player.dead
  end,
    on_use = function (self, event, target, player, data)
    if player.role == "lord" or player.role == "loyalist" then  --若爲xx模式
      player.room:gameOver("lord+loyalist")
    else
      player.room:gameOver(player.role)
    end
  end,
}
kujqhqinh:addEffect(fk.GameStart, {
  anim_type = "big",
  can_trigger=spec.can_trigger,
  on_use=spec.on_use,
})

kujqhqinh:addEffect(fk.Death, {
  anim_type = "big",
  -- can_trigger = function(self, event, target, player, data)
  --   return player:hasSkill(kujqhqinh.name, true) and #player.room.alive_players==2 and not player.dead
  -- end,
  can_trigger=spec.can_trigger,
  on_use=spec.on_use,
})

return kujqhqinh
