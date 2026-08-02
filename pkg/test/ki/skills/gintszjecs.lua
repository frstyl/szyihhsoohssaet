local gintszjecs = fk.CreateSkill {
  name = "gintszjecs",
  tags = { Skill.Compulsory },
}
Fk:loadTranslationTable{
  ["gintszjecs"] = "勤政",
  [":gintszjecs"] = "伱起動打出牌旹,必發,伱將牌堆頂1牌置于伱將牌上｡伱可于元牌旹機將2/3/4勤政轉化爲{殺閃/肉酒/鬥糧}起動",

  ["gintszjecs_tszjecs"] = "勤政",

}

-- gintszjecs:addAcquireEffect(function (self, player)
--     player.room:setPlayerMark(player,"@gintszjecs",1) 
-- end)

-- gintszjecs:addLoseEffect (function (self, player)
--     player.room:setPlayerMark(player,"@gintszjecs",0) 
-- end)
local S = require "packages/szyihhsoohssaet/szyih_guos" 

gintszjecs:addEffect("viewas", {
  anim_type = "offensive",
  pattern = ".|.|.|.|ssaet,szjemh,nziuk,tsiuh,tous_tsiacs,liac_tshoavh_seen_hzaac", 
  prompt = "#gintszjecs",
  mute_card = true,
  handly_pile = false,
  expand_pile = "gintszjecs_tszjecs",
  interaction = function(self, player)
    local all_names = {"ssaet","szjemh","tsiuh","nziuk", "tous_tsiacs", "liac_tshoavh_seen_hzaac"}
    local names={}
    local n = #player:getPile("gintszjecs_tszjecs")
    names=all_names
    -- if n>1 then table.insertTable(names,{"ssaet","szjemh"}) end
    -- if n>2 then  table.insertTable(names,{"nziuk","tsiuh"}) end
    -- if n>3 then  table.insertTable(names,{"tous_tsiacs","liac_tshoavh_seen_hzaac"}) end
    local names = player:getViewAsCardNames(gintszjecs.name, names)
    if #names == 0 then return end
    return UI.CardNameBox {choices = names, all_choices = all_names }
  end,
  card_filter = function(self, player, to_select, selected)
    if ( table.contains(player:getPile("gintszjecs_tszjecs"), to_select))
    then 
      return
        (#selected<2 and  table.contains({"ssaet","szjemh"},self.interaction.data))
        or (#selected<3 and  table.contains({"nziuk","tsiuh"},self.interaction.data))
        or (#selected<4 and  table.contains({"tous_tsiacs","liac_tshoavh_seen_hzaac"},self.interaction.data))
    end

  end,
    -- card_filter = function(self, player, to_select, selected)
  --   if (#selected <2 
  --   and table.contains(player:getPile("gintszjecs_tszjecs"), to_select))
  --   then
  --     local card= Fk:getCardById(to_select)
  --     return (card.color==Card.Red and table.contains({"szjemh", "nziuk","liac_tshoavh_seen_hzaac"},self.interaction.data))
  --     or (card.color==Card.Black and table.contains({"ssaet", "tsiuh","tous_tsiacs"},self.interaction.data))
  --   end

  -- end,
  view_as = function(self, player, cards)
    if   not self.interaction.data then return end
    if ( #cards==2 and table.contains({"ssaet","szjemh"},self.interaction.data) )
        or (#cards==3 and  table.contains({"nziuk","tsiuh"},self.interaction.data))
        or (#cards==4 and  table.contains({"tous_tsiacs","liac_tshoavh_seen_hzaac"},self.interaction.data))
    then
      local c = Fk:cloneCard(self.interaction.data)
      c:addSubcards(cards)
      S.mixCard(c)
      c.skillName = gintszjecs.name

      return c
    else
      return
    end
  end,
  -- before_use = function(self, player, use)
  --   -- local n = 2
  --   -- local name= use.card.trueName
  --   -- -- if table.contains({"ssaet","szjemh"},name) then n =2 
  --   -- -- elseif table.contains({"nziuk","tsiuh"},name) then n=3
  --   -- -- else n =4
  --   -- -- end
  --   -- local cards={}
  --   -- for i=1,n,1 do
  --   --   table.insert(cards,player:getPile("gintszjecs_tszjecs")[i])
  --   -- end
  --   -- player.room:moveCardTo(cards, Card.DiscardPile, nil, fk.ReasonPutIntoDiscardPile, gintszjecs.name, nil, true,  player)

  --   player.room:moveCardTo(use.card.fake_subcards, Card.DiscardPile, nil, fk.ReasonPutIntoDiscardPile, gintszjecs.name, nil, true, player)
 
  -- end,
  enabled_at_play =  function(self, player)
    return #player:getPile("gintszjecs_tszjecs")>1
  end,
  enabled_at_response = function(self, player, response) 
    return #player:getPile("gintszjecs_tszjecs")>1
  end,
})

-- gintszjecs:addEffect("targetmod", {
--   bypass_times = function(self, player, skill, scope, card)
--     if card and table.contains(card.skillNames,gintszjecs.name) and scope == Player.HistoryPhase then
--       return true
--     end
--   end,
--   bypass_distances = function(self, player, skill, card)
--     return card and card.skillNames and table.contains(card.skillNames, gintszjecs.name)
--   end,
-- })

local sepc={
  derived_piles = "gintszjecs_tszjecs",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(gintszjecs.name)
  end,
  on_use = function(self, event, target, player, data)
      player:addToPile("gintszjecs_tszjecs", player.room:getNCards(1), true, gintszjecs.name, player)
  end,
}
gintszjecs:addEffect(fk.CardUsing, sepc)
gintszjecs:addEffect(fk.CardResponding, sepc)

return gintszjecs
