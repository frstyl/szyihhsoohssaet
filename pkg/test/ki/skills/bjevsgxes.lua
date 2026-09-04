local bjevsgxes = fk.CreateSkill{
  name = "bjevsgxes",
}

Fk:loadTranslationTable{
  ["bjevsgxes"] = "驃騎",
  [":bjevsgxes"] = "伱起動卽旹牌旹,若此牌与伱所起動上1牌有褈合目幖,伱可發動.此牌對其額外生效1次",

  ["#bjevsgxes-invoke"] = "驃騎： 令 %arg 額外生效",

  ["$bjevsgxes1"] = "狄获悬野，秋风扫之！",
  ["$bjevsgxes2"] = "戎狄作乱，岂能坐视！",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

bjevsgxes:addAcquireEffect(function(self, player)
        local use_event = player.room.logic:getEventsByRule(GameEvent.UseCard, 1, function (e)

          return e.data.from == player

      end, 1)
      if #use_event == 1 then
        local use = use_event[1].data
        if use.tos and #use.tos>0 then 
        player.room:setPlayerMark(player, "bjevsgxes", table.map(use.tos,Util.IdMapper))
        end
      end
end)

bjevsgxes:addLoseEffect(function(self, player)
  player.room:setPlayerMark(player, "bjevsgxes", 0)
end)

bjevsgxes:addEffect(fk.CardUsing, {--TargetSpecifying
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    if
      target == player and player:hasSkill(bjevsgxes.name) 
      and data.extra_data and data.extra_data.bjevsgxesCheck
    then
        return true
    end
  end,
  -- on_cost = function(self, event, target, player, data)
  --   if player.room:askToSkillInvoke(player, {
  --     skill_name = bjevsgxes.name,
  --     prompt = "#bjevsgxes-invoke:::"..data.card:toLogString(),
  --     -- prompt = "#bjevsgxes-invoke:"..data.to.id.."::"..data.card:toLogString(),
  --   }) 
  --   then
  --     event:setCostData(self, {tos = {data.to}})
  --     return true
  --   end
  -- end,
  on_use = function(self, event, target, player, data)
    -- data.additionalEffect = (data.additionalEffect or 0) + 1
    local room=player.room
    data.additionalEffectToPlayer = data.additionalEffectToPlayer or {}
    for _, pid in ipairs(data.extra_data.bjevsgxesCheck) do
      local p = room:getPlayerById(pid)
      data.additionalEffectToPlayer[p]=(data.additionalEffectToPlayer[p] or 0) +1
    end
  end,
  
  can_refresh = function(self, event, target, player, data)
    return target == player and player:hasSkill(bjevsgxes.name, true)
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    if  data.tos and #data.tos>0 then 
      if S.getCardUsageType(data.card.trueName)==1  then 
        local bjevsgxesCheck={}
        local tos=table.map(data.tos,Util.IdMapper)
        for _, p in ipairs(player:getTableMark("bjevsgxes")) do
          if table.contains(tos,p) then
            -- data.extra_data = data.extra_data or {}
            -- data.extra_data.bjevsgxesCheck = true
            -- break
            table.insertIfNeed(bjevsgxesCheck,p)
          end
        end
        if #bjevsgxesCheck>0 then 
           data.extra_data = data.extra_data or {}
          data.extra_data.bjevsgxesCheck = bjevsgxesCheck
        end
      end

      player.room:setPlayerMark(player, "bjevsgxes", table.map(data.tos,Util.IdMapper))
    else
      player.room:setPlayerMark(player, "bjevsgxes", 0)
    end
  end,
})

return bjevsgxes
