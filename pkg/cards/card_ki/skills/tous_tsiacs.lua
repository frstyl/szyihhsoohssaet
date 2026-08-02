local skill = fk.CreateSkill {
  name = "tous_tsiacs_skill",
}

skill:addEffect("cardskill", {
  prompt = "#tous_tsiacs_skill",
  mod_target_filter = function(self, player, to_select, selected, card, extra_data)
    return to_select ~= player and
       ( (extra_data and extra_data.bypass_distances) or self:withinDistanceLimit(player, true, card, to_select))
  end,
  target_filter = Util.CardTargetFilter,
  target_num = 1,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    local to = effect.to
    local from = effect.from
    local responsers = { to, from }
    local currentTurn = 1
    local currentResponser = to

    while currentResponser:isAlive() do
      local loopTimes = effect:getResponseTimes(currentResponser)

      local respond
      for i = 1, loopTimes do
        local params = { ---@type AskToUseCardParams
          skill_name = 'ssaet',
          pattern = 'ssaet',
          cancelable = true,
          event_data = effect
        }
        if loopTimes > 1 then
          params.prompt = "#AskForResponseMultiCard:::ssaet:"..i..":"..loopTimes
        end
        respond = room:askToResponse(currentResponser, params)
        if respond then
          room:responseCard(respond)
        else
          break
        end
      end

      if not respond then
        break
      end

      currentTurn = currentTurn % 2 + 1
      currentResponser = responsers[currentTurn]
    end

    if currentResponser:isAlive() then
      room:damage({
        from = responsers[currentTurn % 2 + 1],
        to = currentResponser,
        card = effect.card,
        damage = 1,
        damageType = fk.NormalDamage,
        skillName = skill.name,
        event_data= effect,
      })
    end
  end,
})

return skill
