local cardSkill = fk.CreateSkill {
  name = "buak_koavh_qwe_nzjin_skill",
}


cardSkill:addEffect("cardskill", {
  prompt = "#buak_koavh_qwe_nzjin_skill",
  mod_target_filter = function(self, player, to_select, selected, card)
    return to_select ~= player 
    and       ((extra_data and extra_data.bypass_distances) or  self:withinDistanceLimit(player, true, card, to_select) )
  end,
  target_filter = Util.CardTargetFilter,
  target_num = 1,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    local to = effect.to
    local from = effect.from

    local buak_koavh_qwe_nzjin_chosen = (effect.extra_data or {}).buak_koavh_qwe_nzjin_chosen or "buak_koavh_qwe_nzjin_skill-fake"

    local respond = room:askToResponse(effect.to, {
      skill_name = cardSkill.name,
      pattern = "ssaet",
      prompt = "#buak_koavh_qwe_nzjin_skill-response:" .. from.id,
      cancelable = true,
      event_data = effect,
    })
    if respond then
      room:responseCard(respond)
      if buak_koavh_qwe_nzjin_chosen=="buak_koavh_qwe_nzjin_skill-fake" then
        -- local ids=Card:getIdList(respond.card)
        -- ids = table.filter(ids, function (id)
        --   return table.contains(room.discard_pile, id)
        -- end)
        local ids = room:getSubcardsByRule(respond.card, { Card.DiscardPile })
        -- ids = room.logic:moveCardsHoldingAreaCheck(ids)
        if #ids>0 then
            room:moveCardTo(ids, Player.Hand, from, fk.ReasonJustMove, cardSkill.name, nil, false, from.id)
        end
      end
    else
      if buak_koavh_qwe_nzjin_chosen=="buak_koavh_qwe_nzjin_skill-real"  then
        local card = Fk:cloneCard("ssaet")  --虛牌鎖无色?
        card.skillName = cardSkill.name
        local cards = room:getSubcardsByRule(effect.card, { Card.Processing })
        if #cards>0 then
        card:addSubcards(cards)
        end
        room:useCard({
        from = from,
        tos = {to},
        card = card,
        disresponsiveList = table.simpleClone(room.players),
        extraUse=true,
        })
      end
    end

  end,
})

cardSkill:addEffect(fk.PreCardUse, {
  global = true,
  priority = 9, -- 聲明後使用
  mute = true,
  can_trigger = function(self, event, target, player, data)
    return target == player and data.card.trueName == "buak_koavh_qwe_nzjin"
  end,
  on_trigger = function(self, event, target, player, data)
    local choice = player.room:askToChoice(player, {
      choices = {  "buak_koavh_qwe_nzjin_skill-fake" ,"buak_koavh_qwe_nzjin_skill-real"}, -- 正兵，奇兵
      skill_name = cardSkill.name,
      prompt = "#buak_koavh_qwe_nzjin_skill-choose",
    })
    data.extra_data = data.extra_data or {}
    data.extra_data.buak_koavh_qwe_nzjin_chosen = choice
  end,
})

return cardSkill
