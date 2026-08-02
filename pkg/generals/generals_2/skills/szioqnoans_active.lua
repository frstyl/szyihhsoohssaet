local szioqnoans_active = fk.CreateSkill {
  name = "szioqnoans_active",
}

Fk:loadTranslationTable{
  ["szioqnoans_active"] = "紓難",
}

szioqnoans_active:addEffect("active", {
  min_card_num = 0,
  max_card_num = 1,
  target_num = 0,
  interaction = function(self, player)
    local choices=self.choices
    local all_choices={
      "szioqnoans_transfer",
      "szioqnoans_recycle",
    }
    return UI.ComboBox {choices = choices, all_choices=all_choices,}
  end,
  card_filter = function (self, player, to_select, selected)
    return self.interaction.data=="szioqnoans_recycle" and #selected == 0 and not player:prohibitResponse(Fk:getCardById(to_select))
  end,
  feasible = function(self, player, selected, selected_cards)
    return (self.interaction.data=="szioqnoans_transfer" and #selected_cards == 0)
    or (self.interaction.data=="szioqnoans_recycle" and #selected_cards == 1)
  end,
})

return szioqnoans_active
