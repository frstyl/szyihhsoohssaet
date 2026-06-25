local hqrach = fk.CreateSkill {
  name = "hqrach_skill",
}

Fk:loadTranslationTable{  --對任意角色用牌 viewAs作旹機
  ["#hqrach_skill"] = "影",
}

hqrach:addEffect("cardskill", {
  prompt = "#hqrach_skill",
  -- min_target_num = 1,
  target_num = 1,--extra_target_func
  mod_target_filter = function(self, player, to_select, selected, card)
    return #selected==0 and to_select~=player
  end,
  target_filter = Util.TrueFunc,
  can_use = Util.TrueFunc,
  -- on_use= function(self, room, effect)
  -- end,
  -- on_effect = function(self, room, effect)
  -- end,
})

return hqrach
