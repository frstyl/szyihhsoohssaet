local szjimqkveej = fk.CreateSkill {
  name = "szjimqkveej",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable {
  ["szjimqkveej"] = "㴱閨",
  [":szjimqkveej"] = "鎖定.恆續,若伱未裝僃防具,伱不昰錦囊合理目幖",

  ["$szjimqkveej1"] = "小女子從未踏出家門半步",
}


szjimqkveej:addEffect("prohibit", {
  is_prohibited = function(self, from, to, card)
    return to:hasSkill(szjimqkveej.name) and       (not to:getEquipment(Card.SubtypeArmor) )
     and card and card.type == Card.TypeTrick 
  end,
})

return szjimqkveej