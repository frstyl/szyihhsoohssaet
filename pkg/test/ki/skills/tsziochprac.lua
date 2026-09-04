local tsziochprac = fk.CreateSkill {
  name = "tsziochprac",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["tsziochprac"] = "踵兵",  --踵武
  [":tsziochprac"] = "➀恆續,伱起動｢杀｣无視距离｡➁每段伱起動第{奇/耦}張｢殺｣旹,必發,此牌{不計入次數/致傷旹傷害值+1}",
  -- [":tsziochprac"] = "➀恆續伱起動｢杀｣无距离限制且次数上限+1｡➁每段伱起動第{一/二}｢殺｣旹,必發,此牌{反抵消/致傷旹傷害值+1}",

  ["@tsziochprac-phase"] = "踵兵",  --踵武


}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

tsziochprac:addAcquireEffect(function (self, player)
    local times = #player.room.logic:getEventsOfScope(GameEvent.UseCard, nil, function (e)
        return e.data.from == player and e.data.card.trueName == "ssaet"
      end, Player.HistoryPhase)
    player.room:setPlayerMark(player,"@tsziochprac-phase",times) 
end)

tsziochprac:addLoseEffect (function (self, player)
    player.room:setPlayerMark(player,"@tsziochprac-phase",0) 
end)

tsziochprac:addEffect(fk.CardUsing, {
  anim_type = "offensive",
  can_refresh = function(self, event, target, player, data)   --用牌旹記錄次數
    return target == player 
      and player:hasSkill(tsziochprac.name,true,true) 
      and data.card.trueName == "ssaet"  
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:addPlayerMark(player,"@tsziochprac-phase",1)
    event:setCostData(self, {choice = player:getMark("@tsziochprac-phase")})
    -- data.extraData=data.extraData or {}
    -- data.extraData.tsziochprac==true
  end,
  can_trigger = function(self, event, target, player, data)
    return target == player 
      and player:hasSkill(tsziochprac.name) 
      and data.card.trueName == "ssaet"  
  end,
  on_use = function(self, event, target, player, data)

    local n = event:getCostData(self).choice%2
    if n==1 then
      if not data.extraUse then

        player:addCardUseHistory(data.card.trueName, -1)
        data.extraUse = true
      end
    elseif n == 0 then
      data.extra_data =data.extra_data or {}
      data.extra_data.antiNullify=true
      data.extra_data.antiCancel=true
    end
      -- -- player:drawCards(event.id)
      -- player:drawCards(player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard).id)
        local times = #player.room.logic:getEventsByRule(GameEvent.UseCard, 1, function (e)
        if e.id<player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard).id and e.data.from == player and e.data.card.trueName == "ssaet" then
          for _,p in ipairs(e.data.tos) do
            if e.data.damageDealt==nil or not e.data.damageDealt[p] or e.data.damageDealt[p]<=0 then
              return true
            end
          end
        end
      end, Player.HistoryPhase)
      if times==1 then 
        data.extra_data=data.extra_data or {}
        data.extra_data.tsziochprac=player.id
      end
  end,
})

-- tsziochprac:addEffect(fk.DamageInflicted, {
--   is_delay_effect = true,
--   -- anim_type = "drawcard",
--   can_trigger = function(self, event, target, player, data)
--     if player.seat~=1 then return end 
--     local e=player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true)
--     while true do
--       if e==nil then return end
--       if e.data and e.data.card ==data.card and  e.data.extra_data and e.data.extra_data.tsziochprac then return true end
--       e=e:findParent(GameEvent.UseCard)
--     end
--   end,
--   on_trigger = function(self, event, target, player, data)
--     S.changeDamage({damageData=data, num=1,skillName=tsziochprac.name})
--   end,
-- })

tsziochprac:addEffect(fk.DamageInflicted, {
  is_delay_effect = true,
  -- anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if player.seat~=1 then return end 
    if data.event_data and  data.event_data.extra_data and data.event_data.extra_data.tsziochprac then 
      -- player:drawCards(3)
      return true end
  end,
  on_trigger = function(self, event, target, player, data)
    S.changeDamage({damageData=data, num=1,skillName=tsziochprac.name})
  end,
})

tsziochprac:addEffect("targetmod", {
  residue_func = function(self, player, skill, scope, card)
    return (player:hasSkill(tsziochprac.name) and card.trueName == "ssaet") and 1 or 0
  end,
  bypass_distances = function (self, player, skill, card, to)
    return player:hasSkill(tsziochprac.name) and card.trueName == "ssaet"
  end,
})

return tsziochprac
