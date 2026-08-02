local phoasmuacs = fk.CreateSkill {
  name = "phoasmuacs",
}
Fk:loadTranslationTable{
  ["phoasmuacs"] = "破妄",
  [":phoasmuacs"] = "印牌:起動虛擬｢防患未肰抵消｣｡若伱手牌數不等于體力值伱可打出x手牌或流失x體力發動(x爲伱手牌數體力值之差)",

  ["#phoasmuacs"] = "破妄 視爲起動防患未肰旹",
  ["#phoasmuacs-discard"] = "破妄 打出%arg手牌",

  ["$phoasmuacs1"] = "不破不立破而後立",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

phoasmuacs:addEffect("viewas", {
  anim_type = "defensive",
  pattern = "buac_hzfan_mujs_nzjen",
  prompt = "#phoasmuacs",
  mute_card = true,
  -- handly_pile = true,
  -- card_filter = function(self, player, to_select, selected)
  --   return #selected == 0 and Fk:getCardById(to_select).color == Card.Red
  -- end,
  view_as = function(self, player, cards)
    -- if #cards ~= 1 then return end
    local c = Fk:cloneCard("buac_hzfan_mujs_nzjen")
    c.skillName = phoasmuacs.name
    return c
  end,
  before_use = function(self, player, use)
    local n =player:getHandcardNum()-player.hp
    if n>0 then
       S.askToPlayCard(player, {
        min_num = n,
        max_num = n,
        include_equip = false,
        skill_name = phoasmuacs.name,
        cancelable = false,
        prompt = "#phoasmuacs-discard:::".. n,
        skip = false
      })
    else
      player.room:loseHp(player,-n,phoasmuacs.name,player)
    end
  end,
  -- enabled_at_play =  function(self, player)
  --   return player:getHandcardNum()~=player.hp
  -- end,
  enabled_at_response = function(self, player, response)
    if  (not response and  player:getHandcardNum()~=player.hp )then
      return player:getMark("phoasmuacs_activated") ~= 0
    end

  end,
  enabled_at_nullification = function (self, player, data)  --data 加入holder
    return data and data.to == player and
      player:getHandcardNum()~=player.hp 
      -- and data.card:isInstantTrick() 
  end,
})


phoasmuacs:addEffect(fk.HandleAskForPlayCard, {--死鎖
  can_refresh = function(self, event, target, player, data)
    if data.afterRequest and (data.extra_data or {}).phoasmuacs_effected then
      return player:getMark("phoasmuacs_activated") ~= 0
    end

    return
      player:hasSkill(phoasmuacs.name) 
      and
      data.eventData 
      and
      data.eventData.to ==player

      -- and Exppattern:Parse(data.pattern):match(Fk:cloneCard("buac_hzfan_mujs_nzjen"))
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    if data.afterRequest then
      room:setPlayerMark(player, "phoasmuacs_activated", 0)
    else
      room:setPlayerMark(player, "phoasmuacs_activated", 1)
      -- player:drawCards(10)
      data.extra_data = data.extra_data or {}
      data.extra_data.phoasmuacs_effected = true
    end
  end,
})


return phoasmuacs
