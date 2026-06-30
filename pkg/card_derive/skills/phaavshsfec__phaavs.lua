local equip_Skill = fk.CreateSkill {
  name = "#phaavshsfec__phaavs_skill",
  attached_equip = "phaavs",
  tags={Skill.Compulsory}
}

equip_Skill:addEffect(fk.CardUsing, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(equip_Skill.name) 
      and data.card 
      -- and data.card.trueName == "ssaet" 
      and  table.contains({"thunder__ssaet","fire__ssaet"},data.card.name )
  end,
  on_cost = function(self, event, target, player, data)
      if data.card.name=="thunder__ssaet" then
        local tos = player.room:askToChoosePlayers(player, {
          targets = data:getExtraTargets({bypass_distances = false}),
          min_num = 1,
          max_num = 1,
          prompt = "#phaavs-choose:::"..data.card:toLogString(),
          skill_name = equip_Skill.name,
          cancelable = true,
        })
        if #tos > 0 then  
          event:setCostData(self,{tos=tos})
          return true
        end
      else
        return 
          player.room:askToSkillInvoke(player, {
            skill_name = equip_Skill.name,
            prompt = "#phaavs-invoke",
          }) 
      end
    
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    if data.card.name=="fire__ssaet" then
      data.additionalDamage = (data.additionalDamage or 0) + 1
    else

      data:addTarget(event:getCostData(self).tos[1])

    end
  end,
})

equip_Skill:addEffect(fk.TargetSpecified, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(equip_Skill.name) and data.card.trueName == "ssaet" 
    and player:compareDistance(data.to, player:getAttackRange(), "==") 
  end,
  on_use = function(self, event, target, player, data)
      data.unoffsetable = true  --unoffsetableList抵消 disresponsive
      data.disresponsive = true
      data.extra_data=data.extra_data or {}
      data.extra_data.ignoreArmorTo=table.simpleClone(player.room.players)
  end,
})

return equip_Skill
