local equipSkill = fk.CreateSkill {
  name = "#nzuo_biuk_skill",
  tags = { Skill.Compulsory },
  attached_equip = "nzuo_biuk",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

equipSkill:addEffect("prohibit", {
  is_prohibited = function(self, from, to, card)
    return
    -- to:hasSkill(equipSkill.name)  and
    
     card and to
    and from~=to
    and S.isInstantTrick(card.trueName)
    and S.hasEquip(to,equipSkill.attached_equip)  
    and Fk.skills[equipSkill.name]:isEffectable(to)    
    and not S.isIgnoreArmorFromAToB(from,to,card)
  end,
})


return equipSkill
