local pujqkiams_active = fk.CreateSkill({
  name = "pujqkiams_active",
})

pujqkiams_active:addEffect("active", {  --飛劍選牌
  mute = true,
  card_num = 2,
  target_num = 1,
  -- expand_pile = extra_data.extra_ids,
  card_filter = function (self, player, to_select, selected)
    return 
       
       ( #selected == 0 and table.contains(self.expand_pile, to_select)   )
    or  ( 
      #selected == 1 
      and table.contains(player:getCardIds("h"), to_select) 
    and (not player:prohibitResponse(Fk:getCardById(to_select)) )
    and (not Fk:getCardById(to_select):compareColorWith(Fk:getCardById(selected[1])) )
  )
    

  end,
  target_filter = function (self, player, to_select, selected, selected_cards)
    return  #selected == 0 
    -- and player:canUseTo(Fk:cloneCard("ssaet"), to_select, {bypass_distances = true, bypass_times = true})--不當有
  end,
})

-- Fk:loadTranslationTable{
--   ["pujqkiams"] = "飛劍",
--   [":pujqkiams"] = "當非伱區域之殺不因使用打出進入弃牌堆後,你可以預弃1不牌与此殺不同色發動,伱使用虛擬此殺(无視距離且不可響應)。",
-- }

return pujqkiams_active
