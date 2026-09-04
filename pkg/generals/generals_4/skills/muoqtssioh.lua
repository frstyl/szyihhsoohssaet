local muoqtssioh = fk.CreateSkill{
  name = "muoqtssioh",
    tags = { Skill.Compulsory,Skill.Composite },
}

Fk:loadTranslationTable{
["muoqtssioh"] = "无阻",
[":muoqtssioh"] = "➀恆續.伱至其它脚色距離-x.伱无視其它脚色防具技能.➁每段限x.伱起動卽旹牌旹必發,令此牌反抵消反失效. (x爲伱已損體力值加1)",

-- ["@muoqtssioh-phase"] = "无阻",
-- ["@@muoqtssioh"] = "无阻",

["$muoqtssioh1"] = "誰敢擋我",
["$muoqtssioh2"] = "游擊部 䡴",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

muoqtssioh:addEffect("targetmod", {
  bypass_times = function(self, player, skill, scope, card, to)
    if scope==999 then
    return  player:hasSkill(muoqtssioh.name)
    end
  end,
})

muoqtssioh:addAcquireEffect (function (self, player)  --作爲技能而非效果 不起動ignoreArmor 攷慮技能失效
  player.room:addTableMark(player,"ignore_Armor_by_skills",muoqtssioh.name) 
end)
muoqtssioh:addLoseEffect (function (self, player)
  player.room:removeTableMark(player,"ignore_Armor_by_skills",muoqtssioh.name) 
end)


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
