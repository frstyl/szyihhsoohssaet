local skill = fk.CreateSkill {
  name = "hzaac_tshjes_skill",
}

Fk:loadTranslationTable{ 
  ["#hzaac_tshjes_skill"] = "行刺" ,
}
skill:addEffect("cardskill", {

  prompt = "#hzaac_tshjes_skill",  --多目幖?
  target_num = 1,
  -- can_use = Util.FalseFunc,
  can_use = function(self, player, card, extra_data)
    if player:prohibitUse(card) then return end
    return (extra_data and extra_data.koarbiuk_rule)
  end,
  mod_target_filter = function(self, player, to_select, selected, card, extra_data)
    return to_select ~= player 
  end,
  target_filter = Util.CardTargetFilter,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    local loopTimes = effect:getResponseTimes()+1 --默認爲2 需要?
    local respond

    local szjemhTimes=0
    while szjemhTimes<loopTimes do
      if  effect.to.dead then return end 
      local params = { ---@type AskToUseCardParams
        skill_name = 'szjemh',
        pattern = 'szjemh',
        cancelable = true,
        event_data = effect,
        prompt="#hzaac_tshjes_response:" .. effect.from.id .. "::" .. szjemhTimes+1 .. ":" .. loopTimes,
      }
      respond = room:askToResponse(effect.to, params)
        if respond then
          room:responseCard(respond)
          szjemhTimes=szjemhTimes+1  --2閃翻面
        else
          if  effect.to.dead then return end
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
    if szjemhTimes>=2 and (not effect.from.dead) then  --??
	      effect.from.room:addPlayerMark(effect.from, "@loav",1)
    end
  end,
})


return skill

