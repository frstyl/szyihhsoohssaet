local hsio = fk.CreateSkill {
  name = "hsio_skill",
}

Fk:loadTranslationTable{
  ["#hsio_skill"] = "虛",
}

hsio:addEffect("cardskill", {
  prompt = "#hsio_skill",
  -- target_num = 1,
  -- mod_target_filter= function(self, player, to_select, selected, selected_cards)
  --     return #selected == 0
  -- end,
  -- target_filter = function(self, player, to_select, selected, selected_cards)
  --     return #selected == 0
  -- end,
  can_use = Util.TrueFunc,
  -- on_use= function(self, room, effect)
  -- end,
  -- on_effect = function(self, room, effect)
  -- end,
})

return hsio
