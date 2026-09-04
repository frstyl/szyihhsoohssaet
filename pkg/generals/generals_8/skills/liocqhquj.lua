local liocqhquj = fk.CreateSkill({
  name = "liocqhquj",
})

Fk:loadTranslationTable{
  ["liocqhquj"] = "龍威",
  [":liocqhquj"] = "伱對一脚色傷旹,若{爲/不爲}雷傷,伱可發動.{伱令1腳色回傷害值/改爲雷傷}",

  ["#liocqhquj-choose"] = "龍威 令1腳色回 %arg",
  ["#liocqhquj-invoke"] = "焚㶳 伱對 %src 致傷 是否 轉爲雷傷",
  -- ["$liocqhquj1"] = "冥冥之中自有注定",
}

liocqhquj:addEffect(fk.DamageInflicted, {
  can_trigger = function(self, event, target, player, data)
    return data.from == player and player:hasSkill(liocqhquj.name)
  end,
  on_cost = function(self, event, target, player, data)
      if data.damageType == fk.ThunderDamage then
          local tos = player.room:askToChoosePlayers(player, {
          targets = player.room.alive_players,
          min_num = 1,
          max_num = 1,
          prompt = "#liocqhquj-choose:::"..data.damage,
          skill_name = liocqhquj.name,
          cancelable = true,
        })
        if #tos ~= 0 then
          event:setCostData(self, {tos = tos})
          return true
        end
      else
        return
        player.room:askToSkillInvoke(player, {
        skill_name = liocqhquj.name,
        prompt = "#liocqhquj-invoke:"..data.to.id,

      }) 
      end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    if event:getCostData(self) then
      player.room:recover{
        who = event:getCostData(self) .tos[1],
        num = data.damage,
        recoverBy = player,
        skillName = liocqhquj.name,
      }
    else
      data.damageType = fk.ThunderDamage 
    end

  end,
})

return liocqhquj
