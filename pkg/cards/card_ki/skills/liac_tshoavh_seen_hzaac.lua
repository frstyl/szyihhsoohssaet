local cardSkill = fk.CreateSkill {
  name = "liac_tshoavh_seen_hzaac_skill",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt = "#liac_tshoavh_seen_hzaac_skill",
  mod_target_filter = Util.TrueFunc,
  -- can_use = Util.CanUseToSelf,
  target_num=1,
  target_filter = function(self, player, to_select, selected, _, card, extra_data)
    return S.useToSelfFilter(self, player, to_select, selected, _, card, extra_data)
  end,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    if effect.to.dead then return end
    effect.to:drawCards(2, cardSkill.name)
  end,
})


return cardSkill
