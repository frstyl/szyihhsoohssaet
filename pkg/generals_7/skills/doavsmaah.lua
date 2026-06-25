local doavsmaah = fk.CreateSkill {
  name = "doavsmaah",
}

Fk:loadTranslationTable{
  ["doavsmaah"] = "盜馬",
  [":doavsmaah"] = "主旹,伱可預弃1牌選其它裝僃區同花坐騎牌發動.伱將其置入除其所屬角色裝僃區",
}

doavsmaah:addEffect("active", {
  anim_type = "control",
  prompt = "#doavsmaah",
  max_phase_use_time=1,
  card_num=1,
  target_num=1,
  card_filter = function(self, player, to_select, selected)
    return   not player:prohibitDiscard(to_select) 
  end,
  target_filter = function(self, player, to_select, selected, selected_cards)
    if #selected_cards==0 then return end
    return   #table.filter(to_select:getCardIds("e"),function(id) --getEquipments
    local c= Fk:getCardById(id)
    return c.sub_type==Card.SubtypeDefensiveRide or c.sub_type==Card.SubtypeOffensiveRide and c:compareSuitWith( Fk:getCardById(selected_cards[1]))
    end) >0
  end,
  on_use = function(self, room, effect)
    room:throwCard(effect.cards,doavsmaah.name,effect.from,effect.from)
    if effect.from.dead then return end
    local player =effect.from
    local target=effect.tos[1]
    local cards=table.filter(target:getCardIds("e"),function(id) 
    local c= Fk:getCardById(id)
    return c.sub_type==Card.SubtypeDefensiveRide or c.sub_type==Card.SubtypeOffensiveRide and c:compareSuitWith( Fk:getCardById(effect.cards[1]))
    end)
    if #cards>1 then
      cards = room:askToChooseCards(player, {
      target = target,
      min = 1,
      max = 1,
      flag = { card_data = {{ "Bottom", cards }} },
      skill_name = doavsmaah.name,
      prompt = "#doavsmaah-choose",
    })
    end
    local targets=table.filter(room:getOtherPlayers(target),function(p)
      return p:canMoveCardIntoEquip(cards[1])
      end)
      if #targets==0 then
        room:moveCardTo(cards, Card.DiscardPile, nil, fk.ReasonPutIntoDiscardPile, doavsmaah.name, nil, true, player)
      end
    local to = room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = targets,
      skill_name = doavsmaah.name,
      prompt = "#doavsmaah-choose",
      cancelable = true,
    })
    if #to==0 then to={player}
    end
    room:moveCardIntoEquip(to[1], cards[1], doavsmaah.name, true, player)

  end,
})


return doavsmaah
