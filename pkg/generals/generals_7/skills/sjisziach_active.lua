
local sjisziach_active = fk.CreateSkill{
  name = "sjisziach_active",
}

Fk:loadTranslationTable{
  ["sjisziach_active"] = "四像",

}


sjisziach_active:addEffect("active", {
  anim_type = "drawCards",
  prompt = "#sjisziach_active",
  min_target_num = 1,
  -- max_target_num = 3,
  min_card_num = 1,
  max_card_num = 4,
  -- max_phase_use_time = 1,
  -- interaction = function(self, player)
  --   return UI.ComboBox {
  --     choices = {"damage","discard"},
  --   }
  -- end,
  card_filter = function(self, player, to_select, selected)

    local c=Fk:getCardById(to_select)
      return 
      -- not player:prohibitResponse(c) 
      -- and 
      c.suit~=Card.NoSuit
      and table.every(selected,function(id)
      return Fk:getCardById(id).suit~=c.suit
      end)
  end,
  target_filter = function(self, player, to_select, selected, selected_cards)
      return #selected <#selected_cards
  end,
  -- feasible = function (self, player, selected, selected_cards)
  --   return #selected==#selected_cards
  -- end,
  -- on_use = function(self, room, effect)
  -- end,
})
return sjisziach_active
