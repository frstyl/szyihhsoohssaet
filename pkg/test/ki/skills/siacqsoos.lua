
local siacqsoos = fk.CreateSkill{
  name = "siacqsoos",
  tags = { Skill.Compulsory },
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

Fk:loadTranslationTable{
  ["siacqsoos"] = "相𧩯",
  [":siacqsoos"] = "伱起動卽旹牌A旹必發.若A与上一被起動牌:不互𦃃,A額外生效1次;互𦃃,伱取得A子牌,此技能失效",
--加彊?
  ["@siacqsoos"] = "相𧩯",

  ["$siacqsoos1"] = "洞察機先 无有不破",
  ["$siacqsoos2"] = "意志被摧毀了无",
}

local function gcd(x, y)
	if (y == 0) then
		return x
	else 
		return gcd(y, x%y)
	end
end


siacqsoos:addEffect(fk.CardUsing, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    if not (target==player and  player:hasSkill(siacqsoos.name) and  S.getCardUsageType(data.card.trueName)==1) then return  end

      local n = 0  --无爲0
      local m =data.card.number
      if m==1  then   event:setCostData(self, {choice = "no"}) return true end
    
      local use_event = player.room.logic:getEventsByRule(GameEvent.UseCard, 1, function (e)
          return e.id < player.room.logic:getCurrentEvent().id 
      end, 1)

      if #use_event == 1 then
        n = use_event[1].data.card.number
      -- else
      end
      
      if n==1  then   event:setCostData(self, {choice = "no"}) return true end

      if n==0 or gcd(n,m)~=1 then
        event:setCostData(self, {choice = "yes"}) return true 
      else
        event:setCostData(self, {choice = "no"}) return true 
      end

  end,
  on_use = function(self, event, target, player, data)
    if event:getCostData(self).choice=="yes" then
      data.additionalEffect = (data.additionalEffect or 0) + 1
    else
      if player.room:getCardArea(data.card) == Card.Processing then
      player.room:obtainCard(player, data.card, true, fk.ReasonPrey, player, siacqsoos.name)
      end
      player.room:invalidateSkill(player, siacqsoos.name, "-turn")
    end
  end,
  can_refresh = function(self, event, target, player, data)
    return player:hasSkill(siacqsoos.name, true)
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    room:setPlayerMark(player, "@siacqsoos", data.card.number )
  end,
})


return siacqsoos
