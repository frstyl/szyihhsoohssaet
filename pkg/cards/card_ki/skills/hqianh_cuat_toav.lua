local skill = fk.CreateSkill {
  name = "#hqianh_cuat_toav_skill",
  attached_equip = "hqianh_cuat_toav",
}

skill:addEffect(fk.CardEffectCancelledOut, {
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(skill.name) and data.from == player and data.card.trueName == "ssaet" and not data.to.dead
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local params = { ---@type AskToUseCardParams
      skill_name = "ssaet",
      pattern = "ssaet",
      prompt = "#hqianh_cuat_toav_ssaet:" .. data.to.id,
      cancelable = true,
      extra_data = {
        -- must_targets = {data.to.id},
        -- exclusive_targets = {data.to.id},
        bypass_distances = true,
        bypass_times = true,
      }
    }
    local use = room:askToUseCard(player, params)
    if use then
      use.extraUse = true
      event:setCostData(self,{use = use})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    player.room:useCard(event:getCostData(self).use)
  end,
})

return skill
