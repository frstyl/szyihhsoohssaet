local virtual_use = fk.CreateSkill{
  name = "virtual_use",
}

Fk:loadTranslationTable{
  ["#virtual_use"] = "%arg 起動%arg2",

}

virtual_use:addEffect("viewas", {
  prompt=  function (self, player)
    if self.card then return "#virtual_use:::".. self.card:toLogString() end
  end,
  expand_pile = function (self, player)
      return self.subcards or {}
  end,
  card_filter = function (self, player, to_select, selected)
      return self.subcards and table.contains(self.subcards, to_select)
  end,
  -- interaction = function(self)
  --   if #self.all_choices == 1 and not self.namebox then return end
  --   return UI.CardNameBox { choices = self.choices, all_choices = self.all_choices }
  -- end,
  view_as = function(self, player, cards)
    if self.card then return  self.card end
    return Fk:getCardById(cards[1])
    -- if not cards[1] then return end
    -- local card=Fk:cloneCard(data.card.name, data.card.suit,  data.card.number)

    -- if self.skillName then
    --   card.skillName = self.skillName
    -- end

    -- if player:prohibitUse(card) then return nil end 

    -- return card
  end,
})

return virtual_use
