local skill = fk.CreateSkill {
  name = "hqeenqmjet__szyih_kouc_skill",
}
Fk:loadTranslationTable{
  ["hqeenqmjet__szyih_kouc_skill"] = "水攻",
  -- ["#szyih_kouc_skill"] = "选择一其他角色，其需選擇1項➀弃全部裝僃(无裝僃不可選),➁伱予其1傷",
  -- ["#szyih_kouc_use"] = "是否對 %src 使用水攻",
  ["#hqeenqmjet__szyih_kouc_skill_discard"] = "伱對 %src 使用水攻 是否弃裝僃",

}
skill:addEffect("cardskill", {
  prompt = "#szyih_kouc_skill",
  target_num = 1,
  can_use = function(self, player, card, extra_data)  --響應
    return extra_data and extra_data.szyih_kouc_response
  end,
  mod_target_filter = function(self, player, to_select, selected, card)
    return to_select ~= player 
  end,
  target_filter = Util.CardTargetFilter,
  -- mod_target_filter = Util.TrueFunc,
  on_effect = function(self, room, effect)
    local from = effect.from
    local to = effect.to
    if #to:getCardIds("e") == 0 or
      not room:askToSkillInvoke(from, {
      skill_name = skill.name,
      prompt = "#hqeenqmjet__szyih_kouc_skill_discard:"..from.id,
      }) then
      room:damage({
        from = from,
        to = to,
        card = effect.card,
        damage = 1,
        damageType = fk.NormalDamage,
        skillName = skill.name,
      })
    else
      to:throwAllCards("e")
    end
  end,
})


return skill

