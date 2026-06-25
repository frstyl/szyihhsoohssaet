local nzjinqnziuk = fk.CreateSkill {
  name = "nzjinqnziuk",
}

Fk:loadTranslationTable{
  ["nzjinqnziuk"] = "人肉",
  [":nzjinqnziuk"] = "當其它角色死亾旹,若其有牌,伱可發動,伱將任意數量其牌轉化爲人肉(手牌區裝僃區処理區有效),肰後分配其牌",

  ["#nzjinqnziuk-choose"] = "人肉：选择要轉化之牌",
  ["trans_all"] = "全部轉化",
  ["@@nzjinqnziuk-inarea"] = "人肉",


  ["nzjinqnziuk-give"] = "人肉 分配 不分配者畱于死者処",

  ["$nzjinqnziuk1"] = "給我活剝了",
  ["$nzjinqnziuk2"] = "客觀,昰可是上好黃牛肉",
}

nzjinqnziuk:addEffect(fk.Death, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(nzjinqnziuk.name) 
    and not target:isNude()  --兼檢測牌是否被動
  end,
  on_use = function(self, event, target, player, data)
    local room =player.room
    local ids=target:getCardIds("he")
    if #ids == 0 then return 
    else
    -- room:obtainCard(player,ids, false, fk.ReasonPrey, player, nzjinqnziuk.name)
    -- player:drawcards(1,nzjinqnziuk.name)
      local cards, choice = room:askToChooseCardsAndChoice(player, {
          cards = ids,
          choices = {"OK", "trans_all"},
          min_num = 0,
          max_num = #ids,
          skill_name = nzjinqnziuk.name,
          prompt = "#nzjinqnziuk-choose",
          -- cancel_choices = {"trans_all"}  --待改
        })
      if choice=="trans_all" then
        cards=ids
      end
      if #cards > 0 then
        for _, id in ipairs(cards) do
          room:setCardMark(Fk:getCardById(id), "@@nzjinqnziuk-inarea", {Card.PlayerHand,Card.PlayerEquip,Card.Processing})
          -- table.removeOne(ids, id)
          -- table.insertIfNeed(ids, Fk:getCardById(id):getEffectiveId())
        end
      end
    end

    while not player.dead do
      local tos, cards = room:askToChooseCardsAndPlayers(player, {
        min_num = 1,
        max_num = 1,
        min_card_num = 1,
        max_card_num = #ids,
        targets = room.alive_players,
        pattern = tostring(Exppattern{ id = ids }),
        skill_name = nzjinqnziuk.name,
        prompt = "#nzjinqnziuk-give",
        cancelable = true,
        expand_pile = ids,
      })
      if #tos > 0 and #cards > 0 then
        for _, id in ipairs(cards) do
          table.removeOne(ids, id)  --刪不了
        end
        room:moveCardTo(cards, Card.PlayerHand, tos[1], fk.ReasonGive, nzjinqnziuk.name, nil, false, player)
        if #ids == 0 then break end
      else
        -- room:moveCardTo(ids, Card.PlayerHand, player, fk.ReasonGive, nzjinqnziuk.name, nil, false, player)
        return
      end
    end

  end,
})

nzjinqnziuk:addEffect("filter", {
  card_filter = function(self, card, player)
    return #card:getTableMark("@@nzjinqnziuk-inarea")>0
  end,
  view_as = function(self, player, card)
    local card = Fk:cloneCard("fake__nziuk", card.suit, card.number)
    card.skillName = nzjinqnziuk.name
    return card
  end,
})

return nzjinqnziuk
