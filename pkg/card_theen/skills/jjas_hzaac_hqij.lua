local equipSkill = fk.CreateSkill {
  name = "#jjas_hzaac_hqij_skill",
  tags = { Skill.Compulsory },
  attached_equip = "jjas_hzaac_hqij",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

equipSkill:addEffect("prohibit", {
  is_prohibited = function(self, from, to, card)
    return to:hasSkill(equipSkill.name) 
    -- and to:isKongcheng() 
    and card 
    and card.trueName=="ssaet"
    -- and (card.number %2 ==0) 
    and (card.number==0 or card.number>to.hp)
    and not S.isIgnoreArmorFromAToB(from,to,card)
  end,
})


return equipSkill
