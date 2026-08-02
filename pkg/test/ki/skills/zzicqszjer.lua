
local zziycqszjer = fk.CreateSkill{
  name = "zziycqszjer",
  tags = { Skill.Compulsory },
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

Fk:loadTranslationTable{
  ["zziycqszjer"] = "椉勢",
  [":zziycqszjer"] = "伱起動卽旹牌A旹必發.若A与上一被起動牌:不互𦃃,伱抽1;互𦃃,伱取得A子牌,此技能失效",
--加彊?
  ["@zziycqszjer"] = "椉勢",

  ["$zziycqszjer1"] = "洞察機先 无有不破",
  ["$zziycqszjer2"] = "意志被摧毀了无",
}

local function gcd(x, y)
	if (y == 0) then
		return x
	else 
		return gcd(y, x%y)
	end
end


zziycqszjer:addEffect(fk.CardUsing, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target==player 
    and  player:hasSkill(zziycqszjer.name) 
    -- and  S.getCardUsageType(data.card.trueName)==1
  end,
  on_use = function(self, event, target, player, data)
      local n = 0  --无爲0
      local m =data.card.number
      local prime = true
      if m==1  then
        prime=true
      elseif m==0 then
        prime=false
      else
      
        local use_events =  player.room.logic.event_recorder[GameEvent.UseCard] --getCurrentEvent ??
        if #use_events==1 then n = 0 
        else
          n=use_events[#use_events-1].data.card.number
        end

        
        if n==1  then  
          prime=true 
        else
          if n==0 or gcd(n,m)~=1 then

            prime=false 
          else
            prime=true 
          end
        end
      end
    
    if prime==false  then
      player:drawCards(1,zziycqszjer.name)
    else
      if player.room:getCardArea(data.card) == Card.Processing then
      player.room:obtainCard(player, data.card, true, fk.ReasonPrey, player, zziycqszjer.name)
      end
      player.room:invalidateSkill(player, zziycqszjer.name, "-turn")
    end
  end,
  can_refresh = function(self, event, target, player, data)
    return player:hasSkill(zziycqszjer.name, true)
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    room:setPlayerMark(player, "@zziycqszjer", data.card.number )
  end,
})


return zziycqszjer
