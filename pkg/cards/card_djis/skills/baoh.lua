local baochSkill = fk.CreateSkill {
  name = "#baoch_skill",
  attached_equip = "baoch",
}

baochSkill:addEffect(fk.AfterCardUseDeclared, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(baochSkill.name) and data.card.name == "ssaet"
  end,
  on_use = function(self, event, target, player, data)
    data:changeCard("fire__ssaet", data.card.suit, data.card.number, baochSkill.name)
  end,
})

return baochSkill
