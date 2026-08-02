local skill = fk.CreateSkill {
  name = "hqjin_deek_qwe_tsji_skill",
}

skill:addEffect("cardskill", {
  prompt = "#hqjin_deek_qwe_tsji_skill",
  distance_limit = 1,
  mod_target_filter = function(self, player, to_select, selected, card, extra_data)
    return to_select ~= player and
      not (to_select:isAllNude() or
        (not (extra_data and extra_data.bypass_distances) and not self:withinDistanceLimit(player, false, card, to_select)))
  end,
  target_filter = Util.CardTargetFilter,
  target_num = 1,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    if effect.from.dead or effect.to.dead or effect.to:isAllNude() then return end
    local cid = room:askToChooseCard(effect.from, { target = effect.to, flag = "hej", skill_name = skill.name })
    room:obtainCard(effect.from, cid, false, fk.ReasonPrey, effect.from, skill.name)
  end,
})


return skill
