local tsziukzzyit_hsoonqdzzyes = fk.CreateSkill {
  name = "tsziukzzyit_hsoonqdzzyes",
}

-- Fk:loadTranslationTable{
--   ["tsziukzzyit_hsoonqdzzyes"] = "昏睡",
-- }

local S = require "packages/szyihhsoohssaet/szyih_guos" 

tsziukzzyit_hsoonqdzzyes:addEffect(fk.EventPhaseChanging, {  --start
  -- globle=true,
  -- is_delay_effect = true,
  anim_type = "control",
  can_trigger= function(self, event, target, player, data)
    return target==player and S.hasTsziukzzyit(player,"hsoonqdzzyes") and data.phase == Player.Play
  end,
  on_trigger= function(self, event, target, player, data)
    data.skipped = true
  end,
})

tsziukzzyit_hsoonqdzzyes:addEffect(fk.Damaged, {
  -- globle=true,
  -- is_delay_effect = true,
  can_trigger= function(self, event, target, player, data)
    return target==player and S.hasTsziukzzyit(player,"hsoonqdzzyes")
  end,
  on_trigger = function(self, event, target, player, data)
    S.removeTsziukzzyit(player,"hsoonqdzzyes")
  end,
})

tsziukzzyit_hsoonqdzzyes:addEffect("prohibit", {
  -- globle=true,
  -- is_delay_effect = true,
  prohibit_use = function(self, player, card)
    if card and S.hasTsziukzzyit(player,"hsoonqdzzyes")  then
      return true
    end
  end,
  prohibit_response = function(self, player, card)
    if card and S.hasTsziukzzyit(player,"hsoonqdzzyes")  then
      return true
    end
  end,
})
return tsziukzzyit_hsoonqdzzyes
