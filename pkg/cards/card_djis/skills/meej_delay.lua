local cardSkill = fk.CreateSkill {
  name = "meej_delay",
}

Fk:loadTranslationTable{
["@@meej-turn"] = "迷",
["meej_delay"] = "迷",
}

-- cardSkill:addEffect(fk.Damaged, {
--   -- global = true,
--   late_refresh = true,
--   can_refresh = function(self, event, target, player, data)
--     return  player:getMark("@@meej-turn") > 0
--   end,
--   on_refresh = function(self, event, target, player, data)
--     player.room:setPlayerMark(player,"@@meej-turn",0) 
--     -- player.room:broadcastProperty(player, "hsoon")
--   end,
-- })


-- cardSkill:addEffect("prohibit", {
--   -- global = true,
--   prohibit_use = function(self, player, card)
--     return 
--       player:getMark("@@meej-turn") > 0  and card and 
--       -- (card.trueName =="ssaet" or card.name == "szjemh")
--       table.contains({  "ssaet", "szjemh", "nziuk" }, card.trueName) 
--   end, 
--   prohibit_response = function(self, player, card)
--     return player:getMark("@@meej-turn") > 0  and card and 
--     table.contains({  "ssaet", "szjemh", "nziuk" }, card.trueName) 
--   end,
-- })

cardSkill:addEffect("prohibit", {
  -- global = true,
  prohibit_use = function(self, player, card)
    return 
      player:hasDelayedTrick("meej") 
      and card 
      and not card:isRuleVirtual()
      and 
        table.find(card.subcards or {card.id}, function(id)
          return table.contains(player:getCardIds("h"), id)
        end)
    
  end, 
  prohibit_use = function(self, player, card)
    return 
      player:hasDelayedTrick("meej") 
      and card 
      and not card:isRuleVirtual()
      and 
        table.find(card.subcards or {card.id}, function(id)
          return table.contains(player:getCardIds("h"), id)
        end)
    
  end, 
})

local spec={
  can_trigger = function(self, event, target, player, data)
    return  (data.who or data.from==player)
    and player:hasDelayedTrick("meej")

  end,
  on_trigger = function(self, event, target, player, data)
    for _,cid in  ipairs(player:getCardIds(Player.Judge)) do
      local c=   target:getVirtualEquip(cid) or Fk:getCardById(cid)
      if c.trueName=="meej" then    --1次淸?
        room:moveCards{
        ids = room:getSubcardsByRule( c, { Card.Processing }),
        toArea = Card.DiscardPile,
        moveReason = fk.ReasonPutIntoDiscardPile,
        skill="meej_skill",
      }  
      end
   end
    
  end,
}

cardSkill:addEffect(fk.Damaged, spec)
cardSkill:addEffect(fk.TurnEnd, spec)
return cardSkill
