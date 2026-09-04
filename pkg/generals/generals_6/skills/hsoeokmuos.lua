local pjertheen = fk.CreateSkill {
  name = "pjertheen",
}

Fk:loadTranslationTable{
  ["pjertheen"] = "蔽天",
  [":pjertheen"] = "主旹.選擇0至多手牌發動.將所選牌自選序置于牌堆頂",

  ["#pjertheen"] = "蔽天 選擇手牌",
  ["#pjertheen-choose"] = "蔽天 排列牌 左側在上",

  ["$pjertheen1"] = "天昏地暗",
}

pjertheen:addEffect("active", {
  anim_type = "control",
  min_card_num = 1,
  target_num = 0,
  prompt = "#pjertheen",
  card_filter = function(self, player, to_select, selected)
    return table.contains(player:getCardIds("h"),to_select)
  end,
  on_use = function(self, room, effect)
    if #effect.cards==1 then
      room:moveCardTo(effect.cards, Card.DrawPile, nil, fk.ReasonPut, pjertheen.name, nil, false, effect.from.id)
      return
    end
    local top = room:askToGuanxing(effect.from, {
      skill_name = pjertheen.name,
      cards = effect.cards,
      -- bottom_limit = {#effect.cards, #effect.cards},
      bottom_limit = {0, 0},
      prompt = "#pjertheen-choose",
      skip=true,
      -- title= pjertheen.name,
      area_names =="#pjertheen-choose",
    }).top
    top = table.reverse(top)
    -- room:moveCards({  --不刷新
    --   ids = top,
    --   toArea = Card.DrawPile,
    --   moveReason = fk.ReasonPut,
    --   skillName = pjertheen.name,
    --   proposer = effect.from,
    --   moveVisible = false,
    -- })
    room:moveCardTo(top, Card.DrawPile, nil, fk.ReasonPut, pjertheen.name, nil, false, effect.from.id)

  end,
})

return pjertheen
