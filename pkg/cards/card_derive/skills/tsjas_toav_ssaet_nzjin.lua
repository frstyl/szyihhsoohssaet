local cardSkill = fk.CreateSkill {
  name = "tsjas_toav_ssaet_nzjin_skill",
}

Fk:loadTranslationTable{
  ["tsjas_toav_ssaet_nzjin_skill"] = "借刀殺人",
  ["#tsjas_toav_ssaet_nzjin_skill"] = "選擇1其它脚色A与子目幖B,對A起動. A可選1項➀對B起動1殺无視距離次數,➁將此牌轉化爲殺對B起動",

  ["#tsjas_toav_ssaet_nzjin-UseVirtualCard"] = "轉化此牌 %arg 爲殺起動",
  ["#tsjas_toav_ssaet_nzjin-UseCard"] = "起動殺 不計入次數",

  ["#askToChooseSubTargets"] = "爲 %arg 選擇子目幖",

  ["#tsjas_toav_ssaet_nzjin-ssaet"] ="%src 對伱起動 借刀殺人, 伱可對 %src 起動殺",
}
cardSkill:addEffect("cardskill", {
  prompt = "#tsjas_toav_ssaet_nzjin_skill",
  offset_func= Util.FalseFunc,
  mod_target_filter = function(self, player, to_select, selected, card, extra_data)
    return to_select ~= player  --額外目幖不能爲子目幖
  end,
  target_filter = function(self, player, to_select, selected, _, card, extra_data)
    return Util.CardTargetFilter(self, player, to_select, selected, _, card, extra_data)
  end,
  target_num = 1, 
  on_use = function(self, room, cardUseEvent)
    local targets= table.filter(room.alive_players,function(p)
        return  not table.contains(cardUseEvent.tos,p)  --p~=cardUseEvent.from and
      end
      )
    if #targets==0 then return end

    local subTarget=room:askToChoosePlayers(cardUseEvent.from, {
      targets = targets,
      min_num = 1,
      max_num = 1,
      prompt = "#askToChooseSubTargets:::"..cardUseEvent.card:toLogString(),
      skill_name = cardSkill.name,
      cancelable=false,
    })
    cardUseEvent.subTos=cardUseEvent.subTos or {}
    for i, p in ipairs(cardUseEvent.tos) do
      cardUseEvent.subTos[i]=subTarget
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

      -- local extra_data = {
      --   must_targets = table.map(effect.subTargets, Util.IdMapper),
      --   bypass_distances = true,
      --   extraUse=true,
      --   bypass_times = false,
      -- }
      local extraUse
      local use ={}

      if choice=="#tsjas_toav_ssaet_nzjin-UseVirtualCard:::"..effect.card:toLogString() then
        use= room:askToUseVirtualCard(to, {
          name = "ssaet",
          skill_name = cardSkill.name,
          prompt = prompt,
          cancelable = true,
          extra_data = {
            must_targets = table.map(effect.subTargets, Util.IdMapper),
            bypass_distances = false,
            extraUse=false,
            bypass_times = false,
          },
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
          extra_data = {
            must_targets = table.map(effect.subTargets, Util.IdMapper),
            bypass_distances = true,
            extraUse=true,
            bypass_times = false,
          }, 
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
