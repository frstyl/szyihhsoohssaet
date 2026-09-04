local equipSkill = fk.CreateSkill {
  name = "#phaavshsfec_phaavs_skill",
  -- attached_equip = "phaavshsfec_phaavs",
  tags={Skill.Compulsory},
}

Fk:loadTranslationTable{
  ["#phaavshsfec_phaavs-invoke"] = "炮 調整模式或攻程",

  ["phaavshsfec_phaavs-precision"] = "精準",
  ["phaavshsfec_phaavs-power"] = "彊攻",
  ["phaavshsfec_phaavs-flexible"] = "雙響",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

-- equipSkill:addEffect(fk.CardUsing, {
--   can_trigger = function(self, event, target, player, data)
--     return target == player and player:hasSkill(equipSkill.name) 
--       and data.card 
--       -- and data.card.trueName == "ssaet" 
--       and  table.contains({"thunder__ssaet","fire__ssaet"},data.card.name )
--   end,
--   on_cost = function(self, event, target, player, data)
--       if data.card.name=="thunder__ssaet" then
--         local tos = player.room:askToChoosePlayers(player, {
--           targets = data:getExtraTargets({bypass_distances = false}),
--           min_num = 1,
--           max_num = 1,
--           prompt = "#phaavs-choose:::"..data.card:toLogString(),
--           skill_name = equipSkill.name,
--           cancelable = true,
--         })
--         if #tos > 0 then  
--           event:setCostData(self,{tos=tos})
--           return true
--         end
--       else
--         return 
--           player.room:askToSkillInvoke(player, {
--             skill_name = equipSkill.name,
--             prompt = "#phaavs-invoke",
--           }) 
--       end
    
--   end,
--   on_use = function(self, event, target, player, data)
--     local room = player.room
--     if data.card.name=="fire__ssaet" then
--       data.additionalDamage = (data.additionalDamage or 0) + 1
--     else

--       data:addTarget(event:getCostData(self).tos[1])

--     end
--   end,
-- })

equipSkill:addEffect(fk.TurnStart, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(equipSkill.name) 
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local mod = {"phaavshsfec_phaavs-precision","phaavshsfec_phaavs-power","phaavshsfec_phaavs-flexible"}
    local all=table.simpleClone(mod)
    for i = 1, 6 do
      table.insert(all, tostring(i))
    end
    local choice = (room:askToChoice(player, { ---@type integer
      choices = all,
      skill_name = equipSkill.name,
      prompt = "#phaavshsfec_phaavs-invoke",
      cancelable=true,
    }))
    if choice=="Cancel" then return end
    local t=table.simpleClone(player:getMark("@phaavshsfec_phaavs"))
    if table.contains(mod,choice) then t[1]=table.indexOf(mod,choice)
    else
      t[2]=tonumber(choice)
    end
    player.room:setPlayerMark(player,"@phaavshsfec_phaavs", t)
  end,
})

equipSkill:addEffect(fk.TargetConfirmed, { --CardUsing?
  can_trigger = function(self, event, target, player, data)
    return data.from == player and player:hasSkill(equipSkill.name)
     and data.card.trueName == "ssaet" 
    -- and  table.contains({"thunder__ssaet","fire__ssaet"},data.card.name) --
    and player:compareDistance(data.to, player:getAttackRange(), "==")
  end,
  on_use = function(self, event, target, player, data)
      -- data.unoffsetable = true  --unoffsetableList抵消 disresponsive
    local mod = player:getMark("@phaavshsfec_phaavs") 
    if mod then mod = mod[1] else mod=1 end
    if mod==1 then
      data.disresponsive = true
      data.extra_data=data.extra_data or {}
      data.extra_data.ignore_Armor_to=table.simpleClone(player.room.players)
    elseif mod==3 then
      data:addTarget(S.getNextOne(data.to))
    elseif mod==2 then
      data.extra_data  =  data.extra_data or {}
      data.extra_data.additionalDamage =(data.extra_data.additionalDamage or 0 )+1
    end
  end,
})

equipSkill:addAcquireEffect(function (self, player)
    player.room:setPlayerMark(player,"@phaavshsfec_phaavs",{1,6}) 
end)

equipSkill:addLoseEffect (function (self, player)
    player.room:setPlayerMark(player,"@phaavshsfec_phaavs",0) 
end)

return equipSkill
