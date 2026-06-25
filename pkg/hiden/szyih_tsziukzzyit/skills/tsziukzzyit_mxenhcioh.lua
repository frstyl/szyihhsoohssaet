local tsziukzzyit_mxenhcioh = fk.CreateSkill {
  name = "tsziukzzyit_mxenhcioh",
}

Fk:loadTranslationTable{
  -- ["tsziukzzyit_mxenhcioh"] = "免敔",
  -- [":tsziukzzyit_mxenhcioh"] = "伱受傷流失體力旹,迻除免敔,防止之",

  ["#PreventLoseHpBySkill"] = "由于 %arg 效果，%from 受到流失體力被防止",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 



tsziukzzyit_mxenhcioh:addEffect(fk.DamageInflicted, {
  -- globle=true,
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return (target == player) and S.hasTsziukzzyit(player,"mxenhcioh")
  end,
  on_trigger  = function(self, event, target, player, data)
    data:preventDamage()
    player.room:sendLog{ type = "#PreventDamageBySkill", from = player.id, arg = "mxenhcioh" }
    S.removeTsziukzzyit(player,"mxenhcioh")
  end,
})

tsziukzzyit_mxenhcioh:addEffect(fk.PreHpLost, {
  -- globle=true,
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return (target == player) and S.hasTsziukzzyit(player,"mxenhcioh")
  end,
  on_trigger  = function(self, event, target, player, data)
    data.prevented=true
    player.room:sendLog{ type = "#PreventLoseHpBySkill", from = player.id, arg = "mxenhcioh" }
    S.removeTsziukzzyit(player,"mxenhcioh")
  end,
})
return tsziukzzyit_mxenhcioh

