local skill = fk.CreateSkill {
  name = "khuo_kujh_dzziuk_zja_skill",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

skill:addEffect("cardskill", {
  prompt = "#khuo_kujh_dzziuk_zja_skill",
  can_use = function(self, player, card, extra_data)
    return not player:prohibitUse(card) 
    and S.magicCanUse(player, card)
  end,
  on_use = function (self, room, cardUseEvent)
    S.magicOnUse(cardUseEvent.from, cardUseEvent)
  end,
  min_target_num = 1,
  max_target_num = 2,
  mod_target_filter = function(self, player, to_select, selected, card)
    return S.hasTsziukzzyit(to_select)
  end,
  target_filter = Util.CardTargetFilter,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    S.removeTsziukzzyit(effect.to)
  end,
})

return skill
