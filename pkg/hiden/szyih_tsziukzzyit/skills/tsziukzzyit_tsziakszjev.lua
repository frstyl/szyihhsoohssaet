local tsziukzzyit_tsziakszjev = fk.CreateSkill {
  name = "tsziukzzyit_tsziakszjev",
}


local S = require "packages/szyihhsoohssaet/szyih_guos" 


tsziukzzyit_tsziakszjev:addEffect(fk.DamageInflicted, {
  -- globle=true,
  -- is_delay_effect = true,
  can_trigger= function(self, event, target, player, data)
    return target==player and S.hasTsziukzzyit(player,"tsziakszjev")
    and table.contains({ fk.ThunderDamage ,fk.FireDamage },data.damageType) 
  end,
  on_trigger = function(self, event, target, player, data)
    S.changeDamage({damageData=data,num=1,skillName=tsziukzzyit_tsziakszjev.name})
  end,
})

return tsziukzzyit_tsziakszjev
