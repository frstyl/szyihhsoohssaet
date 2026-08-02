local dzjipkun = fk.CreateSkill{
  name = "dzjipkun",
  derived_piles = "dzjipkun-kun",  
}

Fk:loadTranslationTable{
  ["dzjipkun"] = "亼軍",
  [":dzjipkun"] = "伱預段始旹/伱受傷後,,伱可發動.伱抽2,將1手牌置于將牌上,稱爲軍。伱額定抽牌旹,伱可減1抽牌數發動,伱取得全部軍,1轉內:所獲軍視爲殺,伱起動殺越過次數限制",--白板--无腦改爲受傷發

  ["dzjipkun-kun"] = "軍",

  ["$dzjipkun1"] = "資之㴱則取之左逢其源",
}

local spec={  
  on_use = function(self, event, target, player, data)
    -- local n=#player:getPile("dzjipkun-kun")+1
    player:drawCards(2, dzjipkun.name)

    if player:isKongcheng() or player.dead then return end
    local cards = player.room:askToCards(player, {
      skill_name = dzjipkun.name,
      include_equip = false,
      min_num = 1,
      max_num = 1,
      prompt = "#dzjipkun-ask",
      cancelable = false,
    })
    player:addToPile("dzjipkun-kun", cards, true, dzjipkun.name)
  end
}
dzjipkun:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(dzjipkun.name) and player.phase == Player.Start
  end,
  on_use = spec.on_use
})

dzjipkun:addEffect(fk.Damage, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return data.to == player and player:hasSkill(dzjipkun.name)
  end,
  on_use = spec.on_use
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
    room:moveCardTo(cards, Card.PlayerHand, player, fk.ReasonPrey, dzjipkun.name, nil, true, player)
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
