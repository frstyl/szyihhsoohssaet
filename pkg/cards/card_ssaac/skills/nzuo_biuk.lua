local equipSkill = fk.CreateSkill {
  name = "#nzuo_biuk_skill",
  tags = { Skill.Compulsory },
  attached_equip = "nzuo_biuk",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

equipSkill:addEffect("prohibit", {
  is_prohibited = function(self, from, to, card)
    return to:hasSkill(equipSkill.name) 
    -- and to:isKongcheng() 
    and card 
    -- and S.getCardTypeByName(card.trueName)==2
    and S.isInstantTrick(card.trueName)
    and not S.isIgnoreArmorFromAToB(from,to,card)
  end,
})


return equipSkill
