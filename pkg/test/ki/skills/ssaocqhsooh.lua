local ssaocqhsooh = fk.CreateSkill {
  name = "ssaocqhsooh",
  tags = { Skill.Compulsory },
}



ssaocqhsooh:addEffect(fk.CardUsing, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(ssaocqhsooh.name) 
  end,
  on_use = function(self, event, target, player, data)
    data.additionalEffect = (data.additionalEffect or 0) +1
  end,
})


-- ssaocqhsooh:addEffect(fk.TargetSpecified, {
--   anim_type = "offensive",
--   can_trigger = function(self, event, target, player, data)
--     return target == player and player:hasSkill(ssaocqhsooh.name)
--   end,
--   on_use = function(self, event, target, player, data)
--     data:setResponseTimes(2, data.to)
--   end,
-- })

return ssaocqhsooh
