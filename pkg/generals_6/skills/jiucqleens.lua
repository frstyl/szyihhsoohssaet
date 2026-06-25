local jiucqleens = fk.CreateSkill {
  name = "jiucqleens",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable {
  ["jiucqleens"] = "融鍊",
  [":jiucqleens"] = "➀武器防防具防進入弃牌堆後,必發.伱將之置于伱武將牌上,稱爲兵.➁伱受傷後,至多傷害值次,若伱有兵,必發.伱廢置1兵,伱抽2➂主旹,伱可選1兵与1角色(需有對應裝僃欄)發動,將此牌置入其對應裝僃欄",

  ["#jiucqleens-invoke"] = "融鍊 選擇兵",
  ["jiucqleens_prac"] = "兵",

  ["$jiucqleens1"] = "如此丟了豈不可惜",
  ["$jiucqleens2"] = "廢鋼亦有好用処",
}

jiucqleens:addEffect("active", {
  derived_piles = "jiucqleens_prac",
  anim_type = "support",
  card_num = 1,
  target_num = 1,
  prompt = "#jiucqleens-invoke",
  expand_pile="jiucqleens",
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and table.contains(player:getPile("jiucqleens_prac"), to_select)
  end,
  target_filter = function(self, player, to_select, selected, selected_cards)
    return #selected == 0 
    and #selected_cards == 1
     and  to_select:canMoveCardIntoEquip(selected_cards[1], true)
  end,
  on_use = function(self, room, effect)
    local player = effect.from
    local target = effect.tos[1]
    room:moveCardIntoEquip(target, effect.cards[1], jiucqleens.name, false, player)
  end,
})

jiucqleens:addEffect(fk.AfterCardsMove, {
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(jiucqleens.name) then return end
    local ids={}
    for _, move in ipairs(data) do
      if    move.toArea == Card.DiscardPile  then
        for _, info in ipairs(move.moveInfo) do
          if info.fromArea==Player.Hand or  info.fromArea==Player.Equip then 
            local card=Fk:getCardById(info.cardId)
            if card.type == Card.TypeEquip and (card.sub_type == Card.SubtypeArmor or card.sub_type ==Card.SubtypeWeapon  )  then
              table.insert(ids,info.cardId)
            end
          end
        end
      end
    end
    ids = table.filter(ids, function (id)
      return table.contains(player.room.discard_pile, id)
    end)
    ids = player.room.logic:moveCardsHoldingAreaCheck(ids)
    if #ids > 0 then
      event:setCostData(self, {cards = ids})
      return true
    end
  end,
  -- on_cost= function(self, event, target, player, data)
  --   local room = player.room
  --   local ids = table.simpleClone(event:getCostData(self).cards)
  --   if #ids > 1 then
  --     local cards, choice = room:askToChooseCardsAndChoice(player, {
  --       cards = ids,
  --       min_num = 1,
  --       max_num = #ids,
  --       skill_name = jiucqleens.name,
  --       prompt = "#jiucqleens-choose",
  --       cancel_choices = {"get_all","Cancel"}
  --     })
  --     if choice=="Cancel" then return end
  --     if choice=="get_all" then cards=ids end
  --     if #cards > 0 then
  --       event:setCostData(self, {cards = cards})
  --       return true 
  --     end
  --   end
  -- end,
  on_use = function(self, event, target, player, data)
    player:addToPile("jiucqleens", event:getCostData(self).cards, true, jiucqleens.name)
  end,
})


jiucqleens:addEffect(fk.Damaged, {
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(jiucqleens.name) and #player:getPile("jiucqleens_prac")>0
  end,
  trigger_times= function(self, event, target, player, data)
    return data.damage
  end,
  -- on_cost= function(self, event, target, player, data)
  --   local room = player.room
  --   local cards = room:askToCards(player, {
  --     skill_name = jiucqleens.name,
  --     min_num = 1,
  --     max_num = 1,
  --     pattern = ".|.|.|jiucqleens",
  --     prompt = "#jiucqleens-invoke",
  --     expand_pile = "jiucqleens",
  --   })
  --   if #cards > 0 then
  --     event:setCostData(self, {tos = {target}, cards = cards})
  --     return true
  --   end
  -- end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local cards = room:askToCards(player, {
      skill_name = jiucqleens.name,
      min_num = 1,
      max_num = 1,
      pattern = ".|.|.|jiucqleens",
      prompt = "#jiucqleens-invoke",
      expand_pile = "jiucqleens",
      cancelable=false,
    })
    room:moveCardTo(cards, Card.DiscardPile, nil, fk.ReasonPutIntoDiscardPile, jiucqleens.name, nil, true, player)
    player:drawCards(2,jiucqleens.name)
  end,
})
return jiucqleens
