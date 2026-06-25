local liocqhquj = fk.CreateSkill({
  name = "liocqhquj",
})

Fk:loadTranslationTable{
  ["liocqhquj"] = "龍威",
  [":liocqhquj"] = "伱對一角色傷後,若爲雷傷,伱可發動.伱回1",

  -- ["$liocqhquj1"] = "冥冥之中自有注定",
}

liocqhquj:addEffect(fk.Damage, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(liocqhquj.name)  and data.damageType == fk.ThunderDamage
  end,
  on_use = function(self, event, target, player, data)
    player.room:recover{
      who = player,
      num = n,
      recoverBy = player,
      skillName = liocqhquj.name,
    }

  end,
})

return liocqhquj
