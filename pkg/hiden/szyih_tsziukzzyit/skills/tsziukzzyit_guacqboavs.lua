local tsziukzzyit_hzaechquns = fk.CreateSkill {
  name = "tsziukzzyit_guacqboavs",
}

Fk:loadTranslationTable{
  ["guacqboavs"] = "狂虣",
  ["#guacqboavs-effected"] = "%from狂虣生效 傷害+1",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 


tsziukzzyit_hzaechquns:addEffect(fk.DamageInflicted, {
  -- globle=true,
  can_trigger= function(self, event, target, player, data)
    return player.seat==1 and S.hasTsziukzzyit(data.from ,"guacqboavs")
  end,
  on_trigger = function(self, event, target, player, data)
    player.room:sendLog{ type = "#guacqboavs-effected", from = player.id}
    S.changeDamage({damageData= data, num=1, skillName=tsziukzzyit_hzaechquns.name})
  end,
})

return tsziukzzyit_hzaechquns
