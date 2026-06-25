local skill = fk.CreateSkill {
  name = "fire__ssaet_skill",
}

-- local ssaet_skill = Fk.skills["ssaet_skill"] --[[ @as ActiveSkill ]]

skill:addEffect("cardskill", {
  prompt = function(self, player, selected_cards)
    local card = Fk:cloneCard("fire__ssaet")
    card:addSubcards(selected_cards)
    local max_num = self:getMaxTargetNum(player, card)
    if max_num > 1 then
      local num = #table.filter(Fk:currentRoom().alive_players, function (p)
        return p ~= player and not player:isProhibited(p, card)
      end)
      max_num = math.min(num, max_num)
    end
    return max_num > 1 and "#fire__ssaet_skill_multi:::" .. max_num or "#fire__ssaet_skill"
  end,
  max_phase_use_time = 1,
  target_num = 1,
  can_use = function(self, player, card, extra_data)
    if player:prohibitUse(card) then return end
    return (extra_data and extra_data.bypass_times) 
    -- or player.phase ~= Player.Play   --max_phase_use_time眞是phase 非旹機流程
    or
      table.find(Fk:currentRoom().alive_players, function(p)
        return self:withinTimesLimit(player, Player.HistoryPhase, card, "ssaet", p)
      end)
  end,
  mod_target_filter = function(self, player, to_select, selected, card, extra_data)
    return to_select ~= player and
       ( (extra_data and extra_data.bypass_distances) or self:withinDistanceLimit(player, true, card, to_select))
  end,
  target_filter = function(self, player, to_select, selected, _, card, extra_data)  --對某角色次數距離
    if not Util.CardTargetFilter(self, player, to_select, selected, _, card, extra_data) then return end  --must_targets  include_targets  exclusive_targets
    return self:modTargetFilter(player, to_select, selected, card, extra_data) and
      (
        #selected > 0 
        -- player.phase ~= Player.Play 
        or
        (extra_data and extra_data.bypass_times) or
        self:withinTimesLimit(player, Player.HistoryPhase, card, "ssaet", to_select)
      )
  end,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    room:damage({
      from = effect.from,
      to = effect.to,
      card = effect.card,
      damage = 1,
      damageType = fk.FireDamage,
      skillName = skill.name,
    })
  end,
})

skill:addAI({
  on_effect = function(self, logic, effect)
    logic:damage({
      from = effect.from,
      to = effect.to,
      card = effect.card,
      damage = 1,
      damageType = fk.FireDamage,
      skillName = skill.name,
    })
  end,
}, "__card_skill")

return skill
