local ssaocqlioc = fk.CreateSkill {
  name = "ssaocqlioc",
  -- tags = { Skill.Compulsory },
}
Fk:loadTranslationTable{
  ["ssaocqlioc"] = "雙龍",
  [":ssaocqlioc"] = "伱起動殺旹,可選擇目幖/額外目幖發動,對其生效次數+1/增加此目幖",
--隱祕
  ["#ssaocqlioc-choose"] = "雙龍 選擇目幖 ",

  ["$ssaocqlioc1"] = "一對白龍爭上下",
  ["$ssaocqlioc2"] = "董一撞在此",
}

ssaocqlioc:addEffect(fk.CardUsing, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(ssaocqlioc.name) 
      and data.card.trueName=="ssaet"

  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local targets = table.filter(data.tos, function(p)
      return not p.dead
    end)
    local ex=data:getExtraTargets({bypass_distances=false})
    table.insertTableIfNeed(targets,ex)
    if #targets == 0 then return end

      local tos = room:askToChoosePlayers(player, {
        targets = targets,
        min_num = 1,
        max_num = 1,
        prompt = "#ssaocqlioc-choose",
        skill_name = ssaocqlioc.name,
        cancelable = true,
      })
      if #tos > 0 then
        event:setCostData(self, {tos = tos,choice=table.contains(ex,tos[1])})
        return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local to = event:getCostData(self).tos[1]
    if event:getCostData(self).choice then
      data:addTarget(to)
    else
      data.additionalEffectToPlayer=data.additionalEffectToPlayer or {}
      data.additionalEffectToPlayer[to]=(data.additionalEffectToPlayer[to] or 0) +1
    end
  end,
})

return ssaocqlioc
