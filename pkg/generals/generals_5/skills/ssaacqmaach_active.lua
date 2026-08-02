local ssaacqmaach_active = fk.CreateSkill {
  name = "ssaacqmaach_active",
}

Fk:loadTranslationTable{
  ["ssaacqmaach_active"] = "生猛",
  -- [":ssaacqmaach_active"] = "",

  ["#ssaacqmaach_active"] = "生猛：選擇",

}

ssaacqmaach_active:addEffect("active", {
  anim_type = "control",
  prompt = "#ssaacqmaach_active",
  interaction = UI.ComboBox {choices = {"draw1","ssaacqmaach-use","both"} }, --,"Cancel"
  can_use = Util.TrueFunc,
  card_num = 0,
  min_target_num = function(self)
    return self.interaction.data == "draw1" and 0 or 1
  end,
  max_target_num = function(self)
    return self.interaction.data == "draw1" and 0 or 999
  end,
  card_filter = Util.FalseFunc,
  target_filter = function(self, player, to_select, selected, selected_cards)
    if self.interaction.data == "draw1" then return false end
    return  to_select:inMyAttackRange(player) 
  end,
  on_use = function(self, room, effect)
    
  end,
})


return ssaacqmaach_active
