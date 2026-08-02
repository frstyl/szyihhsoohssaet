local ddiqhzaac_active = fk.CreateSkill({
  name = "ddiqhzaac_active&",
})

Fk:loadTranslationTable{
  ["ddiqhzaac_active&"] = "持衡",
  [":ddiqhzaac_active&"] = "主旹,交与｢持衡｣腳色1牌,轉化起動｢鬥將｣",

  ["#ddiqhzaac_active-use"] = "持衡  鬥將 %desc ",
}

ddiqhzaac_active:addEffect("active", {
  anim_type = "offensive",
  prompt = "#ddiqhzaac_active",
  mute = true,  --誰發動技能?
  card_num = 1,
  target_num = 2,
  max_phase_use_time=1,
  -- can_use = function(self, player)
  --   return player:usedSkillTimes(ddiqhzaac_active.name, Player.HistoryPhase) < 1 
  -- end,
  card_filter = function(self, player, to_select, selected)--就不能默認手牌 expan equip
    return table.contains(player:getCardIds("he"), to_select)
    and #selected==0
  end,
  target_filter = function(self, player, to_select, selected)
    return 

    (
        (#selected==0 
        and to_select:hasSkill("ddiqhzaac") 
        and to_select~=player
      )

      or (selected[1] and to_select~=selected[1])
    )
  end,

  on_use = function(self, room, effect)
    local to =effect.tos[1]
    local from =effect.from
    room:notifySkillInvoked(from, "ddiqhzaac")  --加次數?
    from:broadcastSkillInvoke("ddiqhzaac")
    room:doIndicate(from.id, { to })

    room:moveCardTo({effect.cards}, Player.Hand, to, fk.ReasonGive, "ddiqhzaac", nil, false, from.id)
    if from.dead then return end
    -- local use = room:askToUseVirtualCard(from, {
    --       name = "distance__tous_tsiacs",
    --       skill_name = "ddiqhzaac",
    --       prompt = "#ddiqhzaac-use",
    --       cancelable = true,
    --       extra_data = {
    --         bypass_distances = true,
    --         bypass_times = false,
    --         extraUse = false,
    --         must_targets={effect.tos[2]},
    --       },
    --       skip = false,
    --       card_filter = {
    --         n = 1,
    --         -- cards = { judge.card.id },
    --       },
    --     })
    local target= effect.tos[2]
    local  cards = room:askToCards(from, {
      min_num = 1,
      max_num = 1,
      skill_name = "ddiqhzaac",
      pattern = ".",
      prompt = "#ddiqhzaac-ask::"..target.id,
      cancelable = false,
    })
    -- if not  player:canUseTo(card, tos[1], {bypass_distances = true, bypass_times = true}) then return end
    room:useVirtualCard("distance__tous_tsiacs", {cards}, from, {target}, "ddiqhzaac", false) 

  end,
})
return ddiqhzaac_active
