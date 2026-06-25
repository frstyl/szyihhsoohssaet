local ddaocqkeek = fk.CreateSkill {
  name = "ddaocqkeek",
}

Fk:loadTranslationTable{
["ddaocqkeek"] = "撞擊",
[":ddaocqkeek"] = "主旹,伱可選擇1攻程內其它角色發動.伱予其1傷,予己1傷",

["#ddaocqkeek"]="撞擊 選擇一角色 擊之",--肘
}


ddaocqkeek:addEffect("active", {
  anim_type = "offensive",
  prompt = "#ddaocqkeek",
  card_num = 0,
  target_num = 1,
  -- can_use = Util.TrueFunc,
  card_filter = Util.FalseFunc,
  target_filter =  function(self, player, to_select, selected, selected_cards)
    return player:inMyAttackRange(to_select)
  end,
  max_phase_use_time = 1,
  -- can_use = function(self, player)  --?? 止計自己? active
  --   return player:usedEffectTimes(ddaocqkeek.name, Player.HistoryRound) == 0
  -- end,
  on_use = function(self, room, effect)
    local player = effect.from
    local target  = effect.tos[1]

    room:damage{
        from = player,
        to = target,
        damage = 1,
        damageType=fk.NormalDamage,
        skillName = ddaocqkeek.name,
      }

    room:damage{
      from = player,
      to = player,
      damage = 1,
      damageType=fk.NormalDamage,
      skillName = ddaocqkeek.name,
    }

  end,
})



return ddaocqkeek
