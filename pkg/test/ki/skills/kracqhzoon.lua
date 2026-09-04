local kracqhzoon = fk.CreateSkill {
  name = "kracqhzoon",
}

Fk:loadTranslationTable{
["kracqhzoon"] = "驚䰟",
[":kracqhzoon"] = "全場轉限1｡其他脚色A需因響應傷害牌B起動或演練閃旹,伱可對其起動殺發動(有距離次數限制).此殺結算後B對A致傷旹,A視爲體力爲0瀕死,若其瀕死存活,體力調整爲此效果前",

["#kracqhzoon-ask"] = "驚䰟: 對 %src 起動殺",

["#StartKracqhzoon"] = "驚䰟 %from 將嚇死自己",
["#EndKracqhzoon"] = "驚䰟 %from 虛驚一場",
}


local kracqhzoon_spec ={
  on_cost = function(self, event, target, player, data)
    local to=data.eventData.to
    local use = player.room:askToUseCard(player,{ ---@type AskToUseCardParams
        skill_name = kracqhzoon.name,
        pattern = 'ssaet',  --待
        prompt = "#kracqhzoon-ask:" .. to.id,
        cancelable = true,
        extra_data={
          exclusive_targets={to.id},
          extraUse=false,
          bypass_distances = false, 
          bypass_times = false
        },
        -- event_data = effect
      })
    if use then
      event:setCostData(self, {use = use,tos={to}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    -- room:loseHp(player,1,kracqhzoon.name)
    -- if player.dead then return end
    local use=event:getCostData(self).use
    local to =event:getCostData(self).tos[1]
    if to.dead then return end
    player.room:useCard(use)
    -- room:useCard(use)
    -- use.extra_data =use.extra_data or {}
    -- local kracqhzoon=use.extra_data.kracqhzoon or {}
    -- table.insert(kracqhzoon,target.id)
    -- use.extra_data.kracqhzoon=kracqhzoon
    -- player:useCard(event:getCostData(self).use)

    if data.eventData and data.eventData.use then
      data.eventData.extra_data=data.eventData.extra_data or {}
      data.eventData.extra_data.kracqhzoon=player.id  --多个覆蓋 止生效1次
    end

    -- return true
  end,
}

kracqhzoon:addEffect(fk.AskForCardUse, {
  can_trigger = function(self, event, target, player, data)
    return  target ~= player and player:hasSkill(kracqhzoon.name) 
      and player:usedSkillTimes(kracqhzoon.name, Player.HistoryTurn) == 0
      and Exppattern:Parse(data.pattern):matchExp("szjemh") 
      and data.eventData  
      and data.eventData.card and data.eventData.card.is_damage_card
      and data.eventData.to 
      and not data.eventData.to:prohibitUse(Fk:cloneCard("szjemh"))
      and player:canUseTo(Fk:cloneCard("ssaet"), data.eventData.to, {bypass_distances = true, bypass_times = true})
  end,
  on_cost = kracqhzoon_spec.on_cost,
  on_use = kracqhzoon_spec.on_use,
})

kracqhzoon:addEffect(fk.AskForCardResponse, {
  can_trigger = function(self, event, target, player, data)
    return  target ~= player and player:hasSkill(kracqhzoon.name) 
    and player:usedSkillTimes(kracqhzoon.name, Player.HistoryTurn) == 0
      and Exppattern:Parse(data.pattern):matchExp("szjemh") 
      and data.eventData  
      and data.eventData.card and data.eventData.card.is_damage_card
      and data.eventData.to 
      and not data.eventData.to:prohibitResponse(Fk:cloneCard("szjemh"))
      and player:canUseTo(Fk:cloneCard("ssaet"), data.eventData.to, {bypass_distances = true, bypass_times = true})
  end,
  on_cost = kracqhzoon_spec.on_cost,
  on_use = kracqhzoon_spec.on_use,
})


-- kracqhzoon:addEffect(fk.CardEffecting, {
--   can_trigger = function(self, event, target, player, data)
--     return data.to==player and data.to.hp>0 and 
--     data.use and data.use.extra_data and data.use.extra_data.kracqhzoon and table.contains(data.use.extra_data.kracqhzoon,player.id)
--     
--   end,
--   on_trigger = function(self, event, target, player, data)
--     player.room:loseHp(player,player.hp,kracqhzoon.name)
--   end,
-- })

kracqhzoon:addEffect(fk.DamageInflicted, {
  -- can_trigger = function(self, event, target, player, data)
  --   if not (data.to==player  and  data.to.hp>0) then return end
  --     local use_event = player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true)
  --     if use_event then
  --       local use = use_event.data
  --       return    
  --        use.extra_data and use.extra_data.kracqhzoon and table.contains(use.extra_data.kracqhzoon,player.id)
  --     end
  -- end,
  can_trigger = function(self, event, target, player, data)
    return player.seat==1 and data.event_data and data.event_data.extra_data and data.event_data.extra_data.kracqhzoon
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room
    local n = player.hp
    -- player.room:loseHp(player,player.hp,kracqhzoon.name)
    -- player.room:changeHp(player,-player.hp,nil,kracqhzoon.name)
    room:sendLog{
      type = "#StartKracqhzoon",
      from = player.id,
    }
    player.hp=0
    local dyingDataSpec = {
        who = player,
        damage = nil,
        killer = nil,
        hpLost = nil,
      }
    room:enterDying(dyingDataSpec)
    if player:isAlive() then player.hp=n end
    room:sendLog{
      type = "#EndKracqhzoon",
      from = player.id,
    }
  end,
})
return kracqhzoon
