local theenqhzeec = fk.CreateSkill {
  name = "theenqhzeec",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["theenqhzeec"] = "天刑",
  [":theenqhzeec"] = "伱所致傷(傷害結算前)視爲无源｡一腳色死亾後,若无傷源,必發,伱抽3｡",

  ["$theenqhzeec1"] = "你的死活，与我何干？",
  ["$theenqhzeec2"] = "无来无去，不悔不怨。",
}

theenqhzeec:addEffect(fk.PreDamage, {
  anim_type = "offensive",
  on_use = function(self, event, target, player, data)
    data.from = nil
  end,
})


theenqhzeec:addEffect(fk.Deathed, {
  anim_type = "drawcard",
  can_trigger= function(self, event, target, player, data)
    return player:hasSkill(theenqhzeec.name) 
    and (data.damage == nil or data.damage.from == nil)
  end,
  on_use = function(self, event, target, player, data)
    player:drawCards(3,theenqhzeec.name)
  end,
})

return theenqhzeec