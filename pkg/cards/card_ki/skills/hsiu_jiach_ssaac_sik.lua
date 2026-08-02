local skill = fk.CreateSkill {
  name = "hsiu_jiach_ssaac_sik_skill",
}

skill:addEffect("cardskill", {
  prompt = "#hsiu_jiach_ssaac_sik_skill",
  can_use = Util.GlobalCanUse,
  on_use = function (self, room, cardUseEvent)
    return Util.AoeCardOnUse(self, cardUseEvent.from, cardUseEvent, true)
  end,
  offset_func= Util.FalseFunc,
  mod_target_filter = Util.TrueFunc,
  about_to_effect = function(self, room, effect)
    if not effect.to:isWounded() then
      return true
    end
  end,
  on_effect = function(self, room, effect)
    if effect.to:isWounded() and not effect.to.dead then
      room:recover({
        who = effect.to,
        num = 1,
        recoverBy = effect.from,
        card = effect.card,
        skillName = self.name,
        event_data= effect,
      })
    end
  end,
})

skill:addAI(nil, "__card_skill")
skill:addAI(nil, "default_card_skill")


return skill
