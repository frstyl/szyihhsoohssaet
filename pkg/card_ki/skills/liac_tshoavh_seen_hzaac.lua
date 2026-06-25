local skill = fk.CreateSkill {
  name = "liac_tshoavh_seen_hzaac_skill",
}

skill:addEffect("cardskill", {
  prompt = "#liac_tshoavh_seen_hzaac_skill",
  mod_target_filter = Util.TrueFunc,
  can_use = Util.CanUseToSelf,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    if effect.to.dead then return end
    effect.to:drawCards(2, skill.name)
  end,
})

skill:addAI(nil, "__card_skill")
skill:addAI(nil, "default_card_skill")


return skill
