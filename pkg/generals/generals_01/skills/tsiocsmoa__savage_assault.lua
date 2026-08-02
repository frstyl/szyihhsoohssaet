local skill = fk.CreateSkill {
  name = "tsiocsmoa__maach_hsooh_hzaah_ssaen_skill",
}

Fk:loadTranslationTable{
  ["tsiocsmoa__maach_hsooh_hzaah_ssaen_skill"] = "縱魔__猛虎下山",
  -- [":tsiocsmoa"] = "應動｡伱起動｢殺｣指定目幖旹,伱可發動｡伱抽2,迻除此目幖,起動虛擬｢猛虎下山｣,此牌效果:目幖可打出屬性｢殺｣若打出伱抽1,否則伱予目幖1傷,目幖隨機自弃1牌",
}
skill:addEffect("cardskill", {
  prompt = "#tsiocsmoa__maach_hsooh_hzaah_ssaen_skill",
  can_use = Util.AoeCanUse,
  on_use = function (self, room, cardUseEvent)
    ---@cast cardUseEvent -SkillUseData
    return Util.AoeCardOnUse(self, cardUseEvent.from, cardUseEvent, false)
  end,
  mod_target_filter = function(self, player, to_select, selected, card, distance_limited)
    return to_select ~= player
  end,
  on_effect = function(self, room, effect)
    if effect.to.dead then return end
    local loopTimes = effect:getResponseTimes()
    local respond
    for i = 1, loopTimes do
      local params = { ---@type AskToUseCardParams
        skill_name = 'ssaet',
        pattern = '.|.|.|.|thunder__ssaet,fire__ssaet',
        cancelable = true,
        event_data = effect
      }
      respond = room:askToResponse(effect.to, params)
      if respond then
        room:responseCard(respond)
        if not effect.from.dead then effect.from:drawCards(1,skill.name) end
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
        if effect.to.dead then return end
        room:throwCard(table.random(effect.to:getCardIds("he")), skill.name, effect.to, effect.to)
        return
      end
    end
  end,
})

return skill
