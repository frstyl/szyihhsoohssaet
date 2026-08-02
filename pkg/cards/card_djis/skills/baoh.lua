local baohSkill = fk.CreateSkill {
  name = "#baoh_skill",
  attached_equip = "baoh",
}

baohSkill:addEffect(fk.AfterCardUseDeclared, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(baohSkill.name) and data.card.name == "ssaet"
  end,
  on_use = function(self, event, target, player, data)
    data:changeCard("fire__ssaet", data.card.suit, data.card.number, baohSkill.name)
  end,
})

return baohSkill
