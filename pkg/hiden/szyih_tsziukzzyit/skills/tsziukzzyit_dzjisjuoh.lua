local tsziukzzyit_hzaechquns = fk.CreateSkill {
  name = "tsziukzzyit_dzjisjuoh",
}

Fk:loadTranslationTable{
  ["#dzjisjuoh-effected"] = "%from自愈生效 回1",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

tsziukzzyit_hzaechquns:addEffect(fk.EventPhaseStart, {
  -- globle=true,
  -- is_delay_effect = true,
  anim_type = "drawcard",
  can_trigger= function(self, event, target, player, data)
    return target==player and S.hasTsziukzzyit(player,"dzjisjuoh") and player.phase==Player.Finish
  end,
  on_trigger = function(self, event, target, player, data)
    player.room:sendLog{ type = "#dzjisjuoh-effected", from = player.id}
    player.room:recover({
        who = player,
        num = 1,
        recoverBy = player,
        skillName = tsziukzzyit_hzaechquns.name,
      })
  end,
})

return tsziukzzyit_hzaechquns
