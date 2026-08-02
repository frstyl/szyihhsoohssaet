local liacsbiuk = fk.CreateSkill{
  name = "liacsbiuk&",
}

Fk:loadTranslationTable{
  ["liacsbiuk&"] = "亮伏",
  [":liacsbiuk"] = "起動葢伏牌",

  ["#liacsbiuk"] = "起動葢伏牌",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

liacsbiuk:addEffect("viewas", {
  anim_type = "special",
  pattern = ".|.|.|.|.|.",
  prompt = "#liacsbiuk",
  mute=true,
  expand_pile=function(self, player)
      return S.getPlayerKoarbiukCards(player)
      -- return player:getTableMark("koarbiukCards")
  end,
  card_filter = function(self, player, to_select, selected)
      return #selected == 0 and table.contains(S.getPlayerKoarbiukCards(player), to_select) 
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then return end
    return Fk:getCardById(cards[1])
  end,
  -- enabled_at_play = Util.FalseFunc,
  -- enabled_at_response = function(self, player, response)
  --   return true
  --   -- return Fk.currentResponseReason == "koarbiuk_rule"  --不保眞
  -- end,
})

-- liacsbiuk:addEffect("filter", {
--   handly_cards = function (self, player)
--     if player:hasSkill(liacsbiuk.name) then
--       return S.getPlayerKoarbiukCards(player)
--     end
--   end,
-- })
return liacsbiuk
