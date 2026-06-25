local muoqtssioh = fk.CreateSkill{
  name = "muoqtssioh",
    tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
["muoqtssioh"] = "无阻",
[":muoqtssioh"] = "鎖定.➀恆續.伱至其他角色距離-x.伱无視其他角色防具技能.➁每段限x.伱使用卽旹牌旹必發,令此牌反抵消反失效. (x爲伱已損體力值加1)",

-- ["@muoqtssioh-phase"] = "无阻",
-- ["@@muoqtssioh"] = "无阻",

["$muoqtssioh1"] = "誰敢擋我",
["$muoqtssioh2"] = "游擊部 䡴",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

muoqtssioh:addAcquireEffect (function (self, player)  --作爲技能而非效果 不使用ignoreArmor 攷慮技能失效
  player.room:addTableMark(player,"ignoreArmorBySkills",muoqtssioh.name) 
end)
muoqtssioh:addLoseEffect (function (self, player)
  player.room:removeTableMark(player,"ignoreArmorBySkills",muoqtssioh.name) 
end)


-- muoqtssioh:addEffect('invalidity', {
--   global = true,
--   invalidity_func = function(self, player, skill)
--     if not( skill:getSkeleton() 
--           and 
--             skill:getSkeleton().attached_equip 
--             and
--             Fk:cloneCard(skill:getSkeleton().attached_equip).sub_type == Card.SubtypeArmor 
--           )
--     then return end 

--       local from=nil

--       -- if not RoomInstance then goto request end
--       if  RoomInstance and RoomInstance.logic:getCurrentEvent() then

--         local logic = RoomInstance.logic
--         local event = logic:getCurrentEvent()
--         local data=event.data
--         -- if not event then 
--         --   -- return 
--         --   goto request
--         if event.event == GameEvent.UseCard then  --onAim?
--           -- ---@cast data UseCardData
--           -- if not table.contains(data.tos, player) then return false end
--           from = data.from

--          --   goto check
--         elseif event.event == GameEvent.CardEffect then

--             from =data.from
--         elseif event.event == GameEvent.SkillEffect then   --from to  ---skill.trueName
--           -- if not data.skill.cardSkill then
--             from = data.who

--            --   goto check
--         elseif event.event == GameEvent.Damage then
--           -- ---@cast data DamageData
--           -- if data.to ~= player then return false end
--           from = data.from
--          --   goto check
--         elseif event.event == GameEvent.ChangeHp then  --ChangeMaxHp
--           if data.reason=="damage" and data.damageEvent then  --skillName ? card  --回復?
--             from = data.damageEvent.from
--            --   goto check
--           end
--         -- elseif  event.event==GameEvent.Recover then
--         --   from=event.data.recoverBy
--               -- card=data.card
--         elseif  event.event==GameEvent.MoveCards then
--           for _, move in ipairs(event.data) do
--               from = move.proposer 
--               local cardEffectEvent=event:findParent(GameEvent.CardEffect, true) --CardEffect
--              --   goto check
--           end
--         -- elseif event.data and (event.data.from or event.data.who) then
--         --   from = event.data.from or event.data.who
--         --  --   goto check

--         end
--       else
--       -- ::request::
--         if ClientInstance and ClientInstance.current_request_handler   --request不屬于event中
--         and ClientInstance.current_request_handler.player  then
--           from = ClientInstance.current_request_handler.player
--           -- card = ClientInstance.current_request_handler.cards
--         end
--       end

--       -- ::check::  --from to card
--       if from then  
--         return from:hasSkill(muoqtssioh.name)  ----无視任意防具 則不檢測to player 
        
--       end  --not else



--   end,
-- })

muoqtssioh:addEffect(fk.CardUsing, {
  times=function(self,player)
    return (player:getLostHp()+1) - player:usedSkillTimes(muoqtssioh.name, Player.HistoryPhase)
  end,
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(muoqtssioh.name)
    and  S.getCardUsageType(data.card.trueName)==1
    and (player:getLostHp()+1) >player:usedSkillTimes(muoqtssioh.name, Player.HistoryPhase) --player:getMark("@muoqtssioh-phase")
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    data.extra_data=data.extra_data or {}
    data.extra_data.antiNullify=true
    data.extra_data.antiCancel=true
    -- room:addPlayerMark(player, "@muoqtssioh-phase", 1)
  end,
})

muoqtssioh:addEffect("distance", {
  correct_func = function(self, from, to)
    if from:hasSkill(muoqtssioh.name) then
      return -(from:getLostHp()+1)
    end
  end,
})

-- local anti={
--   can_trigger = function (self, event, target, player, data)
--     return data.extra_data and data.extra_data.muoqtssioh
--     -- and data.from==player --問一次
--   end,
--   on_trigger = function (self, event, target, player, data)
--     data.isCancellOut = false
--   end
-- }


-- punsmuoh:addEffect(fk.CardEffectCancelledOut, {  --不算發動技能
--   can_trigger = anti.can_trigger,
--   on_trigger=anti.on_trigger,
-- })


-- punsmuoh:addEffect(S.AftereffectNullify, {
--   can_trigger = anti.can_trigger,
--   on_trigger = function (self, event, target, player, data)
--     data.nullified=false
--     -- data:antiNullify()
--   end,
-- })

-- punsmuoh:addEffect(S.AftereffectNullify, {
--   can_trigger = anti.can_trigger,
--   on_trigger = function (self, event, target, player, data)
--     data.nullified=false
--     -- data:antiNullify()
--   end,
-- })

return muoqtssioh
