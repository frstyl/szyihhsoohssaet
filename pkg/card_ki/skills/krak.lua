local equipSkill = fk.CreateSkill {
  name = "#krak_skill",
  attached_equip = "krak",
}

equipSkill:addEffect("targetmod", {
  extra_target_func = function(self, player, skill, card)
    if player:hasSkill(equipSkill.name) and card.trueName == "ssaet" and card then
      if player.hp<=1 then 
        return 2
      end

      local cards = card:isVirtual() and card.subcards or {card.id}
      if table.every(player:getCardIds("h"), function(id)
        return table.contains(cards, id)
        end) 
      then
        return 2
      end


    end
  end,
})
equipSkill:addEffect(fk.CardUsing, {
  can_refresh = function(self, event, target, player, data)
    return target == player and player:hasSkill(equipSkill.name) and data.card.trueName == "ssaet" and #data.tos > 1
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    -- room:broadcastPlaySound("./packages/standard_cards/audio/card/krak")
    -- room:setEmotion(player, "./packages/standard_cards/image/anim/krak")
  end,
})

return equipSkill
