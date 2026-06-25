local ljerkun = fk.CreateSkill {
  name = "ljerkun",
}

Fk:loadTranslationTable{
  ["ljerkun"] = "勵軍",
  [":ljerkun"] = "伱致傷後,伱可選1角色發動.其護甲+1",  --丈八

  ["#ljerkun-ask"] = "勵軍 選1角色發動.其護甲+1",

  ["$ljerkun1"] = "看伱等已是秊衰命䀆",
  ["$ljerkun2"] = "汝昰斯未聽過我李成聞達之威名无"
}

ljerkun:addEffect(fk.Damage, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(ljerkun.name)
  end,
  on_cost = function(self, event, target, player, data)
    local tos  = player.room:askToChoosePlayers(player, {
      targets = player.room.alive_players,
      min_num = 1,
      max_num = 1,
      prompt = "#ljerkun-ask",
      skill_name = ljerkun.name,
    })
    if #tos > 0 then
      event:setCostData(self, {tos = tos})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    player.room:changeShield(event:getCostData(self).tos[1], 1)
  end,
})

return ljerkun
