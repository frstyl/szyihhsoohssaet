local tsziukzzyit_hzaechquns = fk.CreateSkill {
  name = "tsziukzzyit_szyihdoonh",
}

-- Fk:loadTranslationTable{
--   ["@tsziukzzyit_szyihdoonh"] = "灼燒",
-- }

local S = require "packages/szyihhsoohssaet/szyih_guos" 


tsziukzzyit_hzaechquns:addEffect(fk.DamageInflicted, {
  -- globle=true,
  -- is_delay_effect = true,
  can_trigger= function(self, event, target, player, data)
    return target==player and S.hasTsziukzzyit(player,"szyihdoonh")
    and table.contains({ fk.ThunderDamage ,fk.FireDamage },data.damageType) 
  end,
  on_trigger = function(self, event, target, player, data)
    S.changeDamage({damageData=data, num = -1,skillName=tsziukzzyit_hzaechquns.name})
  end,
})

return tsziukzzyit_hzaechquns
