local cardSkill = fk.CreateSkill {
  name = "tsjas_toav_ssaet_nzjin_skill",
}

Fk:loadTranslationTable{
  ["tsjas_toav_ssaet_nzjin_skill"] = "借刀殺人",
  ["#tsjas_toav_ssaet_nzjin_skill"] = "選擇1其它角色A与A殺合理目幖B,對A使用. A可選1項➀對B使用1殺不計入次數,➁將此牌轉化爲殺對B使用",

  ["#tsjas_toav_ssaet_nzjin-UseVirtualCard"] = "轉化此牌 %arg 爲殺使用",
  ["#tsjas_toav_ssaet_nzjin-UseCard"] = "使用殺 不計入次數",

  ["#tsjas_toav_ssaet_nzjin-ssaet"] ="%src 對伱使用 借刀殺人, 伱可對 %src 使用殺",
}
cardSkill:addEffect("cardskill", {
  prompt = "#tsjas_toav_ssaet_nzjin_skill",
  offset_func= Util.FalseFunc,
  mod_target_filter = function(self, player, to_select, selected, card, extra_data)
    if #selected == 0 then  --多目幖?
      return to_select ~= player 
      -- return true
    elseif #selected == 1 then
      return selected[1]:canUseTo(Fk:cloneCard("ssaet"), to_select, {bypass_distances = false, bypass_times = true})

    end
  end,
  target_filter = function(self, player, to_select, selected, _, card, extra_data)
    if #selected >= 2 then
      return false
    elseif #selected == 0 then
      return Util.CardTargetFilter(self, player, to_select, selected, _, card, extra_data)
    else
      return selected[1]:inMyAttackRange(to_select)
    end
  end,
  target_num = 2, 
  on_use = function(self, room, cardUseEvent)
    local tos = table.simpleClone(cardUseEvent.tos)
    cardUseEvent:removeAllTargets()
    for i = 1, #tos, 2 do
      cardUseEvent:addTarget(tos[i], { tos[i + 1] })
    end
  end,
  on_effect = function(self, room, effect)
    local from = effect.from
    local to = effect.to
    if to.dead then return end

    local prompt = "#tsjas_toav_ssaet_nzjin-ssaet:".. effect.from.id .. "::" .. effect.subTargets[1].id
    if #effect.subTargets > 1 then
      prompt = nil
    end
    local choices={}

    local cards = room:getSubcardsByRule(effect.card, { Card.Processing })

    if #cards ~=#room:getSubcardsByRule(effect.card )then  --此至選擇无新旹機
        choices={"#tsjas_toav_ssaet_nzjin-UseCard","Cancel"}
    else
      choices={"#tsjas_toav_ssaet_nzjin-UseVirtualCard:::"..effect.card:toLogString(),"#tsjas_toav_ssaet_nzjin-UseCard","Cancel",}
    end
    while true do  --誤觸反悔
      local choice = room:askToChoice(to, {
        choices = choices,
        skill_name = cardSkill.name,
        prompt = promp,
      })
      if choice=="Cancel" then return end

      local extra_data = {
        must_targets = table.map(effect.subTargets, Util.IdMapper),
        -- bypass_times = true,
        -- extraUse=true,
        bypass_times = false,
        extraUse=false,
      }
      local extraUse=false
      local use ={}

      if choice=="#tsjas_toav_ssaet_nzjin-UseVirtualCard:::"..effect.card:toLogString() then
        use= room:askToUseVirtualCard(to, {
          name = "ssaet",
          skill_name = cardSkill.name,
          prompt = prompt,
          cancelable = true,
          extra_data = extra_data,
          event_data = effect,
          expand_pile = cards,
          subcards =  cards,
          skip = true,
        })

      else
        use = room:askToUseCard(to, { 
          skill_name = "ssaet", 
          pattern = "ssaet", 
          prompt = prompt, 
          cancelable = true, 
          extra_data = extra_data, 
          event_data = effect,
          skip=true, 
        })
        extraUse=true
      end

      if use then
        if extraUse then use.extraUse = true end
        room:useCard(use)
        return
      end

    end

  end,
})

return cardSkill
