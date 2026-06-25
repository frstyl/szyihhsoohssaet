local hsoeokmuos = fk.CreateSkill {
  name = "hsoeokmuos",
}

Fk:loadTranslationTable{
  ["hsoeokmuos"] = "黑霧",
  [":hsoeokmuos"] = "主動.選擇任意數量手牌發動.將所選牌已任意序置于牌堆頂",

  ["#hsoeokmuos"] = "黑霧 選擇手牌",
  ["#hsoeokmuos-choose"] = "黑霧 排列牌 左側在上",

  ["$hsoeokmuos1"] = "天昏地暗",
}

hsoeokmuos:addEffect("active", {
  anim_type = "control",
  min_card_num = 1,
  target_num = 0,
  prompt = "#hsoeokmuos",
  card_filter = function(self, player, to_select, selected)
    return table.contains(player:getCardIds("h"),to_select)
  end,
  on_use = function(self, room, effect)
    if #effect.cards==1 then
      room:moveCardTo(effect.cards, Card.DrawPile, nil, fk.ReasonPut, hsoeokmuos.name, nil, false, effect.from.id)
      return
    end
    local top = room:askToGuanxing(effect.from, {
      skill_name = hsoeokmuos.name,
      cards = effect.cards,
      -- bottom_limit = {#effect.cards, #effect.cards},
      bottom_limit = {0, 0},
      prompt = "#hsoeokmuos-choose",
      skip=true,
      -- title= hsoeokmuos.name,
      area_names =="#hsoeokmuos-choose",
    }).top
    top = table.reverse(top)
    -- room:moveCards({  --不刷新
    --   ids = top,
    --   toArea = Card.DrawPile,
    --   moveReason = fk.ReasonPut,
    --   skillName = hsoeokmuos.name,
    --   proposer = effect.from,
    --   moveVisible = false,
    -- })
    room:moveCardTo(top, Card.DrawPile, nil, fk.ReasonPut, hsoeokmuos.name, nil, false, effect.from.id)

  end,
})

return hsoeokmuos
