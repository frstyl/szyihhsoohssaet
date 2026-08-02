local koarbiuk_active = fk.CreateSkill {
  name = "koarbiuk_active&",
}

Fk:loadTranslationTable{
  ["koarbiuk_active&"] = "葢伏",
  [":koarbiuk_active&"] = "隱祕.主旹,伱葢伏手牌",

  ["#koarbiuk_active"] = "葢伏 選擇葢伏牌",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

-- koarbiuk_active:addEffect("viewas", {
--   mute=true,
--   anim_type = "control",
--   pattern = "khouc__szjemh",  --空 任意旹機條件可用 
--   prompt = "#koarbiuk_active",
--   -- handly_pile = true,
--   card_filter = function(self, player, to_select, selected)
--     return #selected == 0 and table.contains(player:getCardIds("h"), to_select)
--   end,
--   view_as = function(self, player, cards)
--     if #cards ~= 1 then return end
--     -- S.koarbiuk(player, cards[1], koarbiuk_active.name, player)
--     -- local card =Fk:getCardById(cards[1])
--     -- if card:getMark("@@koarbiuk_active-inhand-phase") then 
--     --   card:setMark("@@koarbiuk_active-inhand-phase",0)
--     -- else
--       -- card:setMark("@@koarbiuk_active-inhand-phase",1)  --摸過就上幖記
--       player:setMark("@@koarbiuk_active-inhand-phase",cards[1])  --0是虛牌 --不能淸
--     -- end
--     return nil --Fk:cloneCard("khouc__szjemh")
--   end,
--   -- before_use = function(self, player, use)
--   --   S.koarbiuk(player, use.card, koarbiuk_active.name, effect.from)
--   -- end,
--   enabled_at_response = Util.FalseFunc,
-- })

-- koarbiuk_active:addEffect(fk.EventPhaseEnd, {
--   can_refresh= function(self, event, target, player, data)
--     -- if target==player and player:getMark("@@koarbiuk_active-inhand-phase")==0 then  --鬼
--     -- player:drawCards(1,koarbiuk_active.name)
--       -- return true
--     -- end
--     return target==player and player:hasSkill(koarbiuk_active.name)
--   end,
--   on_refresh= function(self, event, target, player, data)
--     player.room:setPlayerMark(player,"@@koarbiuk_active-inhand-phase", 0)
--   end,
-- })

-- koarbiuk_active:addEffect("filter", {
--   card_filter = function(self, card, player)
--     -- return #card:getTableMark("@@koarbiuk_active-inarea")>0
--     -- return card:getMark("@@koarbiuk_active-inhand-phase")>0
--     return card and table.contains(player:getCardIds("h"), card.id) and player:getMark("@@koarbiuk_active-inhand-phase")== card.id
--   end,
--   view_as = function(self, player, card)
--     local card = Fk:cloneCard("koarbiuk_card", card.suit, card.number)
--     -- card.skillName = koarbiuk_active.name
--     return card
--   end,
-- })

koarbiuk_active:addEffect("active", {
  mute=true,
  no_indicate=true,
  -- anim_type = "drawcard",
  prompt = "#koarbiuk_active",
  min_card_num = 1,
  target_num = 0,
  -- max_phase_use_time = 1,
  card_filter = function(self, player, to_select, selected)
    return table.contains(player:getCardIds("h"), to_select)
    --and Fk:getCardById(to_select).trueName == "ssaet"  
  end,
  -- view_as = function(self, player, cards)
  --       local card =Fk:getCardById(cards[1])
  --   -- if card:getMark("@@koarbiuk_active-inhand-phase") then 
  --   --   card:setMark("@@koarbiuk_active-inhand-phase",0)
  --   -- else
  --     card:setMark("@@koarbiuk_active-inhand-phase",1)  --摸過就上幖記
  --   -- end
  -- end,
  on_use = function(self, room, effect)
    for _, id in ipairs(effect.cards) do
      if effect.from.dead then return end
      if not table.contains(effect.from:getCardIds("h"),id) then return end
    	S.koarbiuk(effect.from, id, koarbiuk_active.name, effect.from)  --一次一張
    end
  end,
  -- feasible=Util.FalseFunc
})





return koarbiuk_active
