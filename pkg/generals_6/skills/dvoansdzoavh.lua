local dvoansdzoavh = fk.CreateSkill {
  name = "dvoansdzoavh",
}

Fk:loadTranslationTable{
  ["dvoansdzoavh"] = "鍛造",
  [":dvoansdzoavh"] = "主旹，伱可弃1手牌併(自伱手牌區裝僃區或兵)選擇1武器牌或防具牌(每牌每段限1次)發動,彊化之",

  ["#dvoansdzoavh"] = "鍛造：選擇 所弃牌 与 裝僃",

  ["@dvoansdzoavh"] = "彊化",

  ["$dvoansdzoavh1"] = "看昰刀,鋒利矣不少",
  ["$dvoansdzoavh2"] = "銅盔不武金甲正好合身",
}

dvoansdzoavh:addEffect("active", {
  anim_type = "support",
  prompt = "#dvoansdzoavh",
  expand_pile="jiucqleens",
  card_num = 2,
  card_filter = function(self, player, to_select, selected)
    return #selected ==  0 and not player:prohibitDiscard(to_select)
    or (#selected ==  1 
      and not table.contains(player:getTableMark("_dvoansdzoavh-phase"), to_select)
      and   table.contains({Card.SubtypeArmor,Card.SubtypeWeapon }, Fk:getCardById(to_select).sub_type )
      )
  end,
  on_use = function(self, room, effect)
    local player = effect.from
    room:throwCard(effect.cards[1], dvoansdzoavh.name, effect.from, effect.from)
    local card = Fk:getCardById(effect.cards[2])
    room:addCardMark(card,"@dvoansdzoavh",1)  --
    room:addTableMark(player,"_dvoansdzoavh-phase",effect.cards[2])  --
    -- local ex_card = room:printCard("ex_" .. card.name, card.suit, card.number)
    -- local area=getArea
    -- room:moveCardTo(card, Card.Void, nil, fk.ReasonJustMove, dvoansdzoavh.name, nil, true, player)
    -- if not player.dead then
    --   room:obtainCard(player, ex_card.id, true)
    -- end
  end,
})

dvoansdzoavh:addEffect(fk.DamageCaused, {
  priority=0.1,
  can_trigger = function(self, event, target, player, data)
    return target==player 
    and data.card
    and data.card.trueName=="ssaet"
    and player:getEquipment(Card.SubtypeWeapon)
    and Fk:getCardById(player:getEquipment(Card.SubtypeWeapon)):getMark("@dvoansdzoavh")>0
  end,
  on_trigger = function(self, event, target, player, data)
    player.room:removeCardMark(Fk:getCardById(player:getEquipment(Card.SubtypeWeapon)),"@dvoansdzoavh",1)  --
    data:changeDamage(1)
  end,
})

dvoansdzoavh:addEffect(fk.DamageCaused, {
  priority=0.1,
  can_trigger = function(self, event, target, player, data)
    return target==player 
    and data.card
    and data.card.trueName=="ssaet"
    and player:getEquipment(Card.SubtypeArmor)
    and Fk:getCardById(player:getEquipment(Card.SubtypeArmor)):getMark("@dvoansdzoavh")>0
  end,
  on_trigger = function(self, event, target, player, data)
    player.room:removeCardMark(Fk:getCardById(player:getEquipment(Card.SubtypeArmor)),"@dvoansdzoavh",1)  --
    data:changeDamage(-1)
  end,
})

return dvoansdzoavh
