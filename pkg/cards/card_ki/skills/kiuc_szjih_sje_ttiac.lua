local skill = fk.CreateSkill {
  name = "kiuc_szjih_sje_ttiac_skill",
}

skill:addEffect("cardskill", {
  prompt = "#kiuc_szjih_sje_ttiac_skill",
  can_use = Util.AoeCanUse,
  on_use = function (self, room, cardUseEvent)
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
    local params = { ---@type AskToUseCardParams
      skill_name = 'szjemh',
      pattern = 'szjemh',
      cancelable = true,
      event_data = effect
    }
    for i = 1, loopTimes do

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
