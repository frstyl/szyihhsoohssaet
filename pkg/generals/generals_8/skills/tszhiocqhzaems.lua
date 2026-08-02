local tszhiocqhzaems = fk.CreateSkill {
  name = "tszhiocqhzaems",
}
Fk:loadTranslationTable{
  ["tszhiocqhzaems"] = "䡴陷",
  [":tszhiocqhzaems"] = "印牌:以伱1+x張牌轉起動｢殺｣｡䡴陷｢殺｣攻程+x,需(x!)次抵消.(x>=0)",  --額外x^x閃抵消(x=其子牌數-1)

  ["#tszhiocqhzaems"] = "䡴陷：將x張牌轉化爲殺起動,此殺需x張閃抵消",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

tszhiocqhzaems:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "ssaet",
  prompt = "#tszhiocqhzaems",
  mute_card = true,
  -- handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return true --table.contains(player:getCardIds("h"),to_select)--getHandlyIds
  end,
  view_as = function(self, player, cards)
    if #cards == 0 then return end
    local c = Fk:cloneCard("ssaet")
    c:addSubcards(cards)
    S.mixCard(c)
    c.skillName = tszhiocqhzaems.name
    return c
  end,
  enabled_at_play = Util.TrueFunc,
  enabled_at_response = function(self, player, response)
    return  not response
  end,
})

tszhiocqhzaems:addEffect(fk.TargetSpecified, {
  can_refresh = function(self, event, target, player, data)  --不算發動 seat==1
    return player.seat==1 
    and  table.contains(data.card.skillNames,tszhiocqhzaems.name)
  end,
  on_refresh = function(self, event, target, player, data)
    -- local n=  #data.card.subcards-1
    -- if n== 0 then return end
    -- data:setResponseTimes(data:getResponseTimes(to)+math.floor(n^n), data.to)
    local n=  #data.card.subcards
    local function factorial(num)
      if num<0 then return end
      if num==0 then return 1 end
      return num * factorial(num-1) 
    end
    data:setResponseTimes(factorial(n), data.to)
  end,
  })

-- tszhiocqhzaems:addEffect("targetmod", {
--   bypass_distances = function(self, player, skill_name, card, to)
--     return card and card.skillNames and table.contains(card.skillNames, tszhiocqhzaems.name) and to 
--     -- and player:compareDistance(to,#card.subcards,"<=")
--     and player::distanceTo(to)>=0 and player:getAttackRange() +#card.subcards-1 >= player::distanceTo(to)
--   end,
-- })

tszhiocqhzaems:addEffect("atkrange", {
  correct_func = function(self, from, to)
      if ClientInstance and ClientInstance.current_request_handler   --request不屬于event中
        and ClientInstance.current_request_handler.player  
        and  ClientInstance.current_request_handler.skill_name==tszhiocqhzaems.name
          then
            -- local card = Fk.skills[tszhiocqhzaems.name]:viewAs(player, ClientInstance.current_request_handler.pendings)
            -- return #card.subcards-1
            return #ClientInstance.current_request_handler.pendings-1
        end
  end,
})
return tszhiocqhzaems
