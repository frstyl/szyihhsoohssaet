local deecstsshaek_active = fk.CreateSkill {
  name = "deecstsshaek_active",
}

Fk:loadTranslationTable{
  ["deecstsshaek_active"] = "定策",
  -- [":deecstsshaek_active"] = "主旹,預選1計謀与1其它脚色發動.伱將此牌交予該脚色与其同旹選擇1項,若相同執行之,否則伱起動此牌(无視距離)抽1",
  ["deecstsshaek-ssaet"] = "起動虛擬殺",
  ["deecstsshaek-draw"] = "抽2",
  ["deecstsshaek-recover"] = "令1已損脚色回1",
  ["deecstsshaek-recast"] = "緟鑄1至4手牌",
}

deecstsshaek_active:addEffect("active", {
  anim_type = "control",
  interaction = function(self, player)
    return UI.ComboBox {
      choices = {"deecstsshaek-ssaet","deecstsshaek-draw","deecstsshaek-recover","deecstsshaek-recast"},
    }
  end,
  card_filter = function(self, player, to_select, selected)
    return self.interaction.data=="deecstsshaek-recast" and  #selected < 4 and table.contains(player:getCardIds("h"),to_select)
  end,
  target_filter = function(self, player, to_select, selected)
    return   (self.interaction.data=="deecstsshaek-ssaet" and     
    player:canUseTo(Fk:cloneCard("ssaet"), to_select, {bypass_distances = true, bypass_times = true})
    and #selected==0)

    or (self.interaction.data=="deecstsshaek-recover" and to_select:isWounded() and #selected==0)
  end,
  on_use = function(self, room, effect)
  end,
--   feasible = function (self, player, selected, selected_cards, card)
--     return #selected_cards-1 == #selected
--   end,
})

return deecstsshaek_active
