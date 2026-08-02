local meejqguac = fk.CreateSkill{
  name = "meejqguac",
}

Fk:loadTranslationTable{
  ["meejqguac"] = "迷狂",
  [":meejqguac"] = "裝僃區牌視爲酒",

  ["meejqguac-kun"] = "軍",

  ["$meejqguac1"] = "資之㴱則取之左逢其源",
}


-- meejqguac:addEffect("filter", {
--   card_filter = function(self, to_select, player)
--     -- return to_select.area ==Card.PlayerEquip
--     return true
--   end,
--   view_as = function(self, player, to_select)
--     local card = Fk:cloneCard("ssaet", to_select.suit, to_select.number)
--     card.skillName = meejqguac.name
--     return card
--   end,
-- })

meejqguac:addEffect("filter", {
  handly_cards = function (self, player)
    if player:hasSkill("meejqguac") then
      return player:getCardIds("e")
    end
  end,
})

return meejqguac
