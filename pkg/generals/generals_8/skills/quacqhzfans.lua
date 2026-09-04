local quacqhzfans = fk.CreateSkill {
  name = "quacqhzfans",
  tags = { Skill.Compulsory,Skill.Composite },
}

Fk:loadTranslationTable{
  ["quacqhzfans"] = "王宦",
  [":quacqhzfans"] = "➀伱指定其它脚色爲｢殺｣目幖後,必發,目幖須弃1手牌➁伱成爲其它腳色｢殺｣爲目幖後,必發,伱抽1",
}

quacqhzfans:addEffect(fk.TargetConfirmed, {
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(quacqhzfans.name) and data.card.trueName == "ssaet" 
    and 
      (data.from == player )
	  and  data.from~=data.to
  
  end,
  on_use = function(self, event, target, player, data)
      player.room:askToDiscard(data.to ,{
        min_num=1,
        max_num=1,
        include_equip=false,
        skip=false,
        skill_name=quacqhzfans.name,
        cancelable = false,
      })

  end,
})

quacqhzfans:addEffect(fk.TargetConfirmed, {
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(quacqhzfans.name) and data.card.trueName == "ssaet" 
    and 
      ( data.to ==player)
	  and  data.from~=data.to
  
  end,
  on_use = function(self, event, target, player, data)
    player:drawCards(1, quacqhzfans.name)
  end,
})


return quacqhzfans
