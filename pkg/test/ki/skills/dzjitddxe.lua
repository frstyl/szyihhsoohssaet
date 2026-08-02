local dzjitddxe = fk.CreateSkill {
  name = "dzjitddxe",
}

Fk:loadTranslationTable{
  ["dzjitddxe"] = "疾馳",
  [":dzjitddxe"] = "輪始,令1脚色死",--其它脚色轉內 /輪始旹/遊戲始旹

  ["#dzjitddxe-invoke"] = "疾馳：是否立即跳至你的回合？",
}

dzjitddxe:addEffect(fk.RoundStart, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(dzjitddxe.name)
  end,
  on_cost= function(self, event, target, player, data)
    local tos = player.room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = player.room.alive_players,  --
      skill_name = dzjitddxe.name,
      prompt = "#dzjitddxe-choose",
      cancelable = true,
    })
    if #tos > 0 then
      event:setCostData(self, {tos = tos})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    player.room:killPlayer{
      who = event:getCostData(self).tos[1],
      killer = player,
    }
  end,
})



return dzjitddxe
