local keenqsziuh = fk.CreateSkill{
  name = "keenqsziuh",
  add_skills={"discardPileInCurrentTurn"}
}

Fk:loadTranslationTable{
  ["keenqsziuh"] = "堅守",
  [":keenqsziuh"] = "印牌:打出x牌,虛擬起動或演練｢閃｣｡x爲1轉弃牌堆未含牌色",

  ["#keenqsziuh"] = "堅守：起動或演練",

  ["$keenqsziuh1"] = "哼，易如反掌。",
  ["$keenqsziuh2"] = "吾主圣明，泽披臣属。",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

keenqsziuh:addEffect("viewas", {
  anim_type = "defensive",
  pattern = "szjemh|.|.|.|.|.",  --
  prompt = "#keenqsziuh",

  -- expand_pile = function(self, player)
  --   return Fk:currentRoom():getBanner("DiscardPile-turn") or {}
  -- end,
  -- filter_pattern = {
  --   min_num = 1,
  --   max_num = 1,
  --   pattern = ".",
  -- },
  card_num=  function(self, player)
    local t= {}
    for _, id in ipairs(Fk:currentRoom():getBanner("DiscardPile-turn") or {}) do
      local c= Fk:getCardById(id).color
      if c~=Card.NoColor then table.insertIfNeed(t,c) end
      if #t==2 then return 0 end
    end
    return 2-#t 
  end,
  -- include_equip=false,
  card_filter = function(self, player, to_select, selected)
    -- local n = {Card.Red,Card.Black}
    -- for _, id in ipairs(Fk:currentRoom():getBanner("DiscardPile-turn") or {}) do
    --   table.removeOne(Fk:getCardById(id))
    --   if #n==0 then return end
    -- end 
    if ( #selected>=self.card_num())
    or not table.contains(player:getHandlyIds(), to_select) 
    then return 
    end
    local card =Fk:getCardById(to_select)
    return not player:prohibitResponse(card) 
    and card.color~=Card.NoColor 
   
    and (not selected[1] or card.color==Fk:getCardById(selected[1]).color )
  end,
  view_as = function(self, player, cards)
    if #cards~=self.card_num() then return end
    local card = Fk:cloneCard("hand__szjemh")
    if cards[1 ]then card:addFakeSubcards(cards) end
    card.skillName=self.name
    return card
  end,
  -- feasible=function(self,player,selected,selected_cards,card)
  -- end,
  -- on_cost = function(self, player, SkillUseData, UseExtraData)
  -- end,  
  before_use = function(self, player, use)
    local cards= use.card.fake_subcards
    if not cards[1] then return end
    S.playCard(cards, self.name,player)
  end,
  enabled_at_play = Util.FalseFunc,
  enabled_at_response = function(self, player, response)
    return true
  end,
})

-- keenqsziuh:addAcquireEffect(function (self, player, is_start)
--   local room = player.room
--   room:addSkill("discardPileInCurrentTurn")
--   if room:getBanner("DiscardPile-turn")~=nil then return end
--   local ids = {}
--   room.logic:getEventsOfScope(GameEvent.MoveCards, 1, function(e)
--     for _, move in ipairs(e.data) do
--       if move.toArea == Card.DiscardPile then
--         for _, info in ipairs(move.moveInfo) do
--           if table.contains(room.discard_pile, info.cardId) then
--             table.insertIfNeed(ids, info.cardId)
--           end
--         end
--       end
--     end
--   end, Player.HistoryTurn)
--   room:setBanner("discardPileInCurrentTurn-turn", ids)
-- end)

return keenqsziuh
