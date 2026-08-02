local kijqphioc = fk.CreateSkill {
  name = "kijqphioc",
}
Fk:loadTranslationTable{
  ["kijqphioc"] = "譏鋒",
  [":kijqphioc"] = "伱可起動閃抵消｢殺｣旹,伱可預弃｢殺｣起動者A 1牌,視爲伱于元旹機起動虛擬閃發動,若弃牌不爲♠️,中止此技能",

  ["#kijqphioc"] = "譏鋒 %src 對伱起動殺,是否發動",
}
-- kijqphioc:addAcquireEffect(function (self, player)
--     player.room:setPlayerMark(player,"@kijqphioc",1) 
-- end)

-- kijqphioc:addLoseEffect (function (self, player)
--     player.room:setPlayerMark(player,"@kijqphioc",0) 
-- end)

kijqphioc:addEffect("viewas", {  --董卓
  anim_type = "defensive",
  pattern = "szjemh",
  prompt = function(self,player)
    return "#kijqphioc:"..player:getMark("kijqphioc_activated-phase")
  end,
  mute_card = true,
  handly_pile = false,
  -- card_filter = function(self, player, to_select, selected)
  --   return #selected == 0 and Fk:getCardById(to_select).color == Card.Red
  -- end,
  view_as = function(self, player, cards)
    -- if #cards ~= 1 then return end
    local c = Fk:cloneCard("szjemh")
    c.skillName = kijqphioc.name
    -- c:addSubcard(cards[1])
    return c
  end,
  before_use = function(self, player, use)
    local room=player.room
    local to=player:getMark("kijqphioc_activated-phase")
    to=room:getPlayerById(to)
    local cid = room:askToChooseCard(player, { target = to, flag = "he", skill_name = kijqphioc.name })
    room:throwCard({cid}, kijqphioc.name, to, player)
    room:setPlayerMark(player, "kijqphioc_activated-phase", 0)
    if Fk:getCardById(cid).suit~=Card.Spade then return  kijqphioc.name  end
  end,
  enabled_at_play =  function(self, player) 
    return  player:getMark("kijqphioc_activated-phase")~=0
  end,
  enabled_at_response = function(self, player, response) 
    return  not response  and player:getMark("kijqphioc_activated-phase")~=0
  end,
})

kijqphioc:addEffect(fk.HandleAskForPlayCard, {--死鎖
  can_refresh = function(self, event, target, player, data)
    if data.afterRequest or (data.extra_data and data.extra_data.kijqphioc_effected )then
      return --player:getMark("kijqphioc_activated-phase") ~= 0
    end

    return
      player:hasSkill(kijqphioc.name) 
      and
      data.eventData 
      and data.eventData.card and data.eventData.card.trueName=="ssaet"
      and data.eventData.to==player
      and 
      data.eventData.from 
      and not data.eventData.from:isKongcheng()
      -- and Exppattern:Parse(data.pattern):match(Fk:cloneCard("nullification"))
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    -- if data.afterRequest then
    --   room:setPlayerMark(player, "kijqphioc_activated-phase", 0)
    -- else
      room:setPlayerMark(player, "kijqphioc_activated-phase", data.eventData.from.id)
      -- player:drawCards(10)
      data.extra_data = data.extra_data or {}
      data.extra_data.kijqphioc_effected = true
    -- end
  end,
})

return kijqphioc
