
local gwisliac_active = fk.CreateSkill{
  name = "gwisliac_active",
}

Fk:loadTranslationTable{
  ["gwisliac_active"] = "四像",
  ["#gwisliac_active"] = "選擇不同花色牌",

}


gwisliac_active:addEffect("active", {
  anim_type = "drawCards",
  prompt = "#gwisliac_active",
  -- min_target_num = 1,
  -- -- max_target_num = 3,
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
  -- target_filter = function(self, player, to_select, selected, selected_cards)
  --     return #selected <#selected_cards
  -- end,
  -- feasible = function (self, player, selected, selected_cards)
  --   return #selected==#selected_cards
  -- end,
  -- on_use = function(self, room, effect)
  -- end,
})
return gwisliac_active
