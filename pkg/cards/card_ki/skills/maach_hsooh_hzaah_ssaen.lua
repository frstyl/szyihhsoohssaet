local skill = fk.CreateSkill {
  name = "maach_hsooh_hzaah_ssaen_skill",
}

skill:addEffect("cardskill", {
  prompt = "#maach_hsooh_hzaah_ssaen_skill",
  can_use = Util.AoeCanUse,
  on_use = function (self, room, cardUseEvent)
    ---@cast cardUseEvent -SkillUseData
    return Util.AoeCardOnUse(self, cardUseEvent.from, cardUseEvent, false)
  end,
  mod_target_filter = function(self, player, to_select, selected, card, distance_limited)
    return to_select ~= player
  end,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    if effect.to.dead then return end
    local loopTimes = effect:getResponseTimes()
    local respond
    for i = 1, loopTimes do
      local params = { ---@type AskToUseCardParams
        skill_name = 'ssaet',
        pattern = 'ssaet',
        cancelable = true,
        event_data = effect
      }
      respond = room:askToResponse(effect.to, params)
      if respond then
        room:responseCard(respond)
        if effect.to.dead then return end
      else
        room:damage({
          from = effect.from,
          to = effect.to,
          card = effect.card,
          damage = 1,
          damageType = fk.NormalDamage,
          skillName = skill.name,
          event_data= effect,
        })
        return
      end
    end
  end,
})



return skill
