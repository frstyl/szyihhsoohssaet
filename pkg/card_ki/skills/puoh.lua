local skill = fk.CreateSkill {
  name = "#puoh_skill",
  attached_equip = "puoh",
}

skill:addEffect(fk.CardEffectCancelledOut, {
  can_trigger = function(self, event, target, player, data)
    return data.isCancellOut  and player:hasSkill(skill.name) and data.from == player and data.card.trueName == "ssaet" and not data.to.dead
    and data.cardsResponded[#data.cardsResponded].trueName=="szjemh"  --誤
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local cards = {}
    for _, id in ipairs(player:getCardIds("he")) do
      if not player:prohibitDiscard(id) 
        --and not (table.contains(player:getEquipments(Card.SubtypeWeapon), id) and Fk:getCardById(id).name == "puoh") 
        then
        table.insert(cards, id)
      end
    end
    cards = room:askToDiscard(player, {
      min_num = 2,
      max_num = 2,
      include_equip = true,
      skill_name = skill.name,
      cancelable = true,
      pattern = tostring(Exppattern{ id = cards }),
      prompt = "#puoh-invoke::"..data.to.id, skip = true })
    if #cards > 0 then
      event:setCostData(self, {cards = cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    player.room:throwCard(event:getCostData(self).cards, skill.name, player, player)
    data.isCancellOut = false
  end,
})

return skill
