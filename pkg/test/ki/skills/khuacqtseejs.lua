local khuacqtseejs = fk.CreateSkill {
  name = "khuacqtseejs",
}
Fk:loadTranslationTable{
  ["khuacqtseejs"] = "匡濟",
  [":khuacqtseejs"] = "恆續.伱桃目幖改爲任一脚色..",

  ["#khuacqtseejs"] = "匡濟 令伱所起動下1殺无視距離防具",
  ["@khuacqtseejs-phase"] = "匡濟",
}
-- khuacqtseejs:addAcquireEffect(function (self, player)
--     player.room:setPlayerMark(player,"@khuacqtseejs",1) 
-- end)

-- khuacqtseejs:addLoseEffect (function (self, player)
--     player.room:setPlayerMark(player,"@khuacqtseejs",0) 
-- end)

khuacqtseejs:addEffect("viewas", {
  anim_type = "support",
  pattern = ".",
  prompt = "#khuacqtseejs",
  mute_card = true,
  -- handly_pile = true,
  -- card_filter = function(self, player, to_select, selected)
  --   return #selected == 0 and Fk:getCardById(to_select).color == Card.Red
  -- end,
  view_as = function(self, player, cards)
    local c = Fk:cloneCard("hzfens")
    c.skillName = khuacqtseejs.name
    return c
  end,
  before_use = function (self, player, use)
    local room = player.room
    player.room:setPlayerMark(player,"@khuacqtseejs-phase",use.tos[1].id)
    player:drawCards(3)
    return khuacqtseejs.name
  end,
  enabled_at_play = function(self, player) 
    return  player:getMark("@khuacqtseejs-phase")==0
  end,
  enabled_at_response = function(self, player, response) 
    return  not response and  player:getMark("@khuacqtseejs-phase")==0
  end,
})

-- khuacqtseejs:addEffect(fk.CardUsing, {
--   can_refresh= function (self, event, target, player, data)
--     return target == player  and player:getMark("@khuacqtseejs-phase")~=0
--  end,
--   on_refresh = function (self, event, target, player, data)
--     player.room:setPlayerMark(player,"@khuacqtseejs-phase",0)
--   end,
-- })

khuacqtseejs:addEffect("targetmod", {
  bypass_distances = function(self, player, skill, card)
    return card and player and player:getMark("@khuacqtseejs-phase")>0
    and card.skill and card.skill.distance_limit 
    --and player:hasSkill(pujqjjem.name) and table.contains(cards, card.trueName)
  end,
  fix_target_func =function(self,player,skill,card,extra_data)
    return table.map(Fk:currentRoom().alive_players,Util.IdMapper)
    -- if not extra_data then 
      -- if player and player:getMark("@khuacqtseejs-phase")~=0 and card   then return
      --   --  player:getTableMark("@khuacqtseejs-phase") 
      --   {player:getMark("@khuacqtseejs-phase")}
      --   --  table.map({player:getMark("@khuacqtseejs-phase")}, Util.IdMapper)
      --   end
    -- end
  end,
})
return khuacqtseejs
