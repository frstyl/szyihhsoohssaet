local dzjipkun = fk.CreateSkill{
  name = "dzjipkun",
}

Fk:loadTranslationTable{
  ["dzjipkun"] = "亼軍",
  [":dzjipkun"] = "預段始旹,,伱可發動.伱抽1+x,將1+x手牌置于將牌上,稱爲軍。額定抽牌旹,若伱抽牌數大于0且X>0,伱可發動.抽牌數-1,伱獲得全部軍,此轉所獲軍視爲殺伱使用殺无次數限制(x爲伱軍數量)",--白板

  ["dzjipkun-kun"] = "軍",

  ["$dzjipkun1"] = "資之㴱則取之左逢其源",
}

dzjipkun:addEffect(fk.EventPhaseStart, {
  derived_piles = "dzjipkun-kun",  
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(dzjipkun.name) and player.phase == Player.Start
  end,
  on_use = function(self, event, target, player, data)
    local n=#player:getPile("dzjipkun-kun")+1
    player:drawCards(n, dzjipkun.name)

    if player:isKongcheng() or player.dead then return end
    local cards = player.room:askToCards(player, {
      skill_name = dzjipkun.name,
      include_equip = false,
      min_num = n,
      max_num = n,
      prompt = "#dzjipkun-ask",
      cancelable = false,
    })
    player:addToPile("dzjipkun-kun", cards, true, dzjipkun.name)
    end,
})

dzjipkun:addEffect(fk.DrawNCards, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(dzjipkun.name) and player.phase == Player.Draw
    and  #player:getPile("dzjipkun-kun") > 0
    and data.n>0
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    data.n=data.n-1
    local cards = player:getPile("dzjipkun-kun")
    for _, id in ipairs(cards) do
        player.room:addCardMark(Fk:getCardById(id), "@@dzjipkun-turn",1)
    end
    room:setPlayerMark(player,"@@dzjipkun")
    room:moveCardTo(cards, Card.PlayerHand, player, fk.ReasonJustMove, dzjipkun.name, nil, true, player)
  end,
})


dzjipkun:addEffect("filter", {
  card_filter = function(self, to_select, player)
    return to_select:hasMark("@@dzjipkun-turn")
  end,
  view_as = function(self, player, to_select)
    local card = Fk:cloneCard("ssaet", to_select.suit, to_select.number)
    card.skillName = dzjipkun.name
    return card
  end,
})
dzjipkun:addEffect("targetmod", {
  bypass_times = function(self, player, skill, scope, card)
    return player:getMark("@@dzjipkun")>0 and card and card.trueName =="ssaet"
  end,
})
return dzjipkun
