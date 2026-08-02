local cardSkill = fk.CreateSkill {
  name = "#kiuc_skill",
  attached_equip = "kiuc",
}

-- cardSkill:addEffect("targetmod", {
--   extra_target_func = function(self, player, skill, card)
--     if player:hasSkill(cardSkill.name) and skill.trueName == "ssaet_skill" and card and

--         card.getColorString == Card.Red then

--             return 1
--     end
--   end,
-- })

cardSkill:addEffect(fk.CardUsing, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(cardSkill.name) 
    and data.card.name == "ssaet"  --紅? --sortByAction
    -- and data.card.color == Card.Red
    and #data:getExtraTargets({bypass_distances = false}) > 0
    -- and #data.tos==1
    -- and data:isOnlyTarget(target)  --已死在tos
  end,
  on_cost = function(self, event, target, player, data)
    local tos = player.room:askToChoosePlayers(player, {
      targets = table.filter(data:getExtraTargets({bypass_distances = false}), function(p)
        return player:distanceTo(p) == player:distanceTo(data.tos[1])
      end),
      min_num = 1,
      max_num = 1,
      prompt = "#kiuc-choose:::"..data.card:toLogString(),
      skill_name = cardSkill.name,
      cancelable = true,
    })
    if #tos > 0 then  
      event:setCostData(self,{tos=tos})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    data:addTarget(event:getCostData(self).tos[1])
    player.room:sendLog{
      type = "#AddTargetsBySkill",
      from = player.id,
      to = {event:getCostData(self).tos.id},
      arg = cardSkill.name,
      arg2 = data.card:toLogString(),
    }
  end,
})

return cardSkill
