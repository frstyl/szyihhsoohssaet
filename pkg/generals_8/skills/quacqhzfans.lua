local quacqhzfans = fk.CreateSkill {
  name = "quacqhzfans",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["quacqhzfans"] = "王宦",
  [":quacqhzfans"] = "鎖➀伱使用殺指定其他角色爲目幖後,必發,目幖須弃1手牌➁其他角色使用殺指定伱爲目幖後,必發,伱抽1",
}
quacqhzfans:addEffect(fk.TargetSpecified, {
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(quacqhzfans.name) and data.card.trueName == "ssaet" 
    and (
      (data.from == player  and data.to~=player)
    or (data.to ==player and  data.from~=player)
  )
  end,
  on_use = function(self, event, target, player, data)
    if data.from == player then 
      player.room:askToDiscard(data.to ,{
        min_num=1,
        max_num=1,
        include_equip=false,
        skip=false,
        skill_name=quacqhzfans.name,
        cancelable = false,
      })
    else
      player:drawCards(1, quacqhzfans.name)
    end
  end,
})

return quacqhzfans
