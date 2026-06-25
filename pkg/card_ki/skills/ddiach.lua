local sk = fk.CreateSkill {
  name = "#ddiach_skill",
  attached_equip = "ddiach",
  tags = { Skill.Compulsory },
}

sk:addEffect(fk.TargetSpecified, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(sk.name) and data.card.trueName == "ssaet" 
    and data.to 
    -- and not data.to.dead
    and data.to:getHandcardNum()>data.to.hp
  end,
  on_use = function(self, event, target, player, data)

      data.unoffsetable = true  --unoffsetableList抵消 disresponsive

  end,
})

return sk
