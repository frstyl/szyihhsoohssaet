local skill = fk.CreateSkill {
  name = "fake__nziuk_skill",
}

Fk:loadTranslationTable{
  ["fake__nziuk_skill"] = "肉",
  [":fake__nziuk_skill"] = "回1,弃1手牌或流失1體力",

  ["#fake__nziuk-discard"] = "人肉 弃1手牌",
}

skill:addEffect("cardskill", {
  prompt = "#fake__nziuk_skill",
  mod_target_filter = function(self, player, to_select)
    return to_select:isWounded()
  end,
  can_use = Util.CanUseToSelf,
  on_effect = function(self, room, effect)
    local to =effect.to
    if effect.to:isWounded() and not effect.to.dead then
      room:recover{
        who = effect.to,
        num = 1,
        card = effect.card,
        recoverBy = effect.from,
        skillName = skill.name,
        event_data= effect,
      }
    end
    if to:isKongcheng() then
      room:loseHp(to,1,skill.name,effect.from)
    return
    end

    local cards = room:askToDiscard(to, {
        min_num = 1,
        max_num = 1,
        include_equip = false,
        skill_name = skill.name,
        cancelable = true,
        prompt = "#fake__nziuk-discard",
        skip = false,
      })
    if #cards == 0 then
      room:loseHp(to,1,skill.name,effect.from)
    end
  end,
})


return skill
