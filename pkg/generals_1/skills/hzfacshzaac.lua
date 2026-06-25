Fk:loadTranslationTable{
  ["hzfacshzaac"] = "橫行",
  [":hzfacshzaac"] = "額定抽牌旹,伱可發動,牌數+x(x爲已死角色)",

  ["$hzfacshzaac1"] = "不認得我",
  ["$hzfacshzaac2"] = "安敢輒入白虎節堂 可知法度否",
}

local hzfacshzaac = fk.CreateSkill{
  name = "hzfacshzaac",
}

hzfacshzaac:addEffect(fk.DrawNCards, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(hzfacshzaac.name)
    and not player:isWounded()
    and #player.room.players- #player.room.alive_players>0
  end,
  on_use = function(self, event, target, player, data)
    data.n = data.n + #player.room.players- #player.room.alive_players
  end,
})


return hzfacshzaac
