local szjimqkveej = fk.CreateSkill {
  name = "szjimqkveej",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable {
  ["szjimqkveej"] = "㴱閨",
  [":szjimqkveej"] = "恆續,若伱未裝僃防具,伱不昰計謀牌合理目幖",

  ["$szjimqkveej1"] = "小女子從未踏出家門半步",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

szjimqkveej:addEffect("prohibit", {
  is_prohibited = function(self, from, to, card)
    return to and to:hasSkill(szjimqkveej.name) 
	and not S.hasEquip(to,Card.SubtypeArmor)
    and card and S.getCardTypeByName(card.truName)==2
  end,
})

return szjimqkveej