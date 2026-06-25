local tsziukzzyit_mxiqquns = fk.CreateSkill {
  name = "tsziukzzyit_mxiqquns",--防褈名
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{
  ["#mxiqquns-effected"] = "%from 楣運生效 少抽1",
}

tsziukzzyit_mxiqquns:addEffect(fk.DrawNCards, {
  globle=true,
  anim_type = "drawcard",
  can_trigger= function(self, event, target, player, data)
    return target==player and S.hasTsziukzzyit(player,"mxiqquns")
    and S.tsziukzzyitTrigger(player,"mxiqquns")
    
  end,
  on_trigger = function(self, event, target, player, data)
    -- if  data.n<=1 then return end
    player.room:sendLog{ type = "#mxiqquns-effected", from = player.id}
    data.n = data.n -1
  end,
})

return tsziukzzyit_mxiqquns
