Fk:loadTranslationTable{
  ["toavqprac"] = "刀兵",
  [":toavqprac"] = "伱所起動｢殺｣越過次數限制,傷害傷害值+x(x爲1轉內伱已起動殺未致傷者)",

  ["@toavqprac-turn"] = "刀兵",

  ["$toavqprac1"] = "喝啊！",
  ["$toavqprac2"] = "今，必斩汝马下！",
}

local toavqprac = fk.CreateSkill{
  name = "toavqprac",
  tags = { Skill.Compulsory },
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

toavqprac:addAcquireEffect(function (self, player)
  local room=player.room
      local n =0 
      room.logic:getEventsOfScope(GameEvent.UseCard, 1, function (e)
          local dat=e.data
          if dat.from == player and dat.card.trueName == "ssaet" 
            and (dat.damageDealt==nil ) then --or #dat.damageDealt==0
          n=n+1
          end
      end, Player.HistoryTurn)
    if n >1 then
    player.room:setPlayerMark(player,"@toavqprac-turn",n-1) --含當次
    end
end)

toavqprac:addLoseEffect (function (self, player)
    player.room:setPlayerMark(player,"@toavqprac-turn",0) 
end)

toavqprac:addEffect("targetmod", {
  bypass_times = function(self, player, skill, scope, card)
    return player:hasSkill(toavqprac.name) and card and card.trueName == "ssaet" and scope == Player.HistoryPhase
  end,
})

toavqprac:addEffect(fk.CardUsing, {
  can_refresh = function(self, event, target, player, data)
    return player.seat==1 and data.from :hasSkill(toavqprac.name) and
      data.card.trueName == "ssaet" and data.from :usedCardTimes("ssaet") > 1
  end,
  on_refresh = function(self, event, target, player, data)
	data.additionalDamage=(data.additionalDamage or 0) +data.from :getMark("@toavqprac-turn")
    player:broadcastSkillInvoke(toavqprac.name)
    player.room:notifySkillInvoked(data.from , toavqprac.name, "offensive")
  end,
})

toavqprac:addEffect(fk.CardUseFinished, {
  -- mute = true,
  can_refresh = function(self, event, target, player, data)
    return player == target and player:hasSkill(toavqprac.name,true)
    and data.card.trueName == "ssaet"
    and (data.damageDealt==nil )--or #data.damageDealt==0
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:addPlayerMark(player, "@toavqprac-turn")
  end,
})

-- toavqprac:addEffect(fk.DamageInflicted, {
  -- -- mute = true,
  -- -- is_delay_effect = true,
  -- can_trigger = function(self, event, target, player, data)
    -- return player == target and data.card and data.card.trueName == "ssaet"  
    -- and
    -- player:getMark("@toavqprac-turn") > 0 
    -- and player:hasSkill(toavqprac.name)
  -- end,
  -- on_use = function(self, event, target, player, data)
    -- S.changeDamage({damageData=data, num=player:getMark("@toavqprac-turn"),skillName=toavqprac.name})
    -- -- player.room:setPlayerMark(player, "@toavqprac-turn", 0)
  -- end,
-- })

return toavqprac
