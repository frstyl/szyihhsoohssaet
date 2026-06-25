local hzfens = fk.CreateSkill {
  name = "hzfens_skill",
}

Fk:loadTranslationTable{  --對任意角色用牌 viewAs作旹機
  ["#hzfens_skill"] = "㕕",
}

hzfens:addEffect("cardskill", {
  prompt = "#hzfens_skill",
  -- min_target_num = 1,
  target_num = 1,--extra_target_func
  mod_target_filter = function(self, player, to_select, selected, card)
    return #selected==0
  end,
  target_filter = Util.TrueFunc,
  can_use = Util.TrueFunc,
  -- on_use= function(self, room, effect)
  -- end,
  -- on_effect = function(self, room, effect)
  -- end,
})

return hzfens
