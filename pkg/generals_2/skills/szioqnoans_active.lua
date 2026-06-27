local szioqnoans_active = fk.CreateSkill {
  name = "szioqnoans_active",
}

Fk:loadTranslationTable{
  ["szioqnoans_active"] = "镇卫",
}

szioqnoans_active:addEffect("active", {
  card_num = 1,
  target_num = 0,
  interaction = function(self, player)
    local choices={}
    local all_choices={
      "szioqnoans_transfer:::"..self.card,
      "szioqnoans_recycle::"..self.from..":"..self.card,
    }
    if self.to==player.id then
      choices={
      "szioqnoans_recycle::"..self.from..":"..self.card,
      }
    else
      choices= all_choices
    end
    return UI.ComboBox {
      choices = choices, all_choices=all_choices,
  }
  end,
  card_filter = function (self, player, to_select, selected)
    return #selected == 0 and not player:prohibitResponse(to_select) --and not player:prohibitDiscard(to_select)
  end,
})

return szioqnoans_active
