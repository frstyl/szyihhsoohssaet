local tsziukzzyit_hzaechquns = fk.CreateSkill {
  name = "tsziukzzyit_hzaechquns",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{
  ["#hzaechquns-effected"] = "%from 𡴘運生效, 額外抽1",
}

tsziukzzyit_hzaechquns:addEffect(fk.DrawNCards, {
  -- globle=true,
  anim_type = "drawcard",
  can_trigger= function(self, event, target, player, data)
    return target==player 
    and S.tsziukzzyitTrigger(player,"hzaechquns")
  end,
  on_trigger = function(self, event, target, player, data)
    player.room:sendLog{ type = "#hzaechquns-effected", from = player.id}
    data.n = data.n + 1
  end,
})

return tsziukzzyit_hzaechquns
