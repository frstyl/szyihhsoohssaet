local maekmaek = fk.CreateSkill{
  name = "maekmaek",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["maekmaek"] = "脈脈",
  [":maekmaek"] = "末段始旹,伱可選1其它已損角色發動,伱令伱与其各回1,翻面牢+1",

  ["#maekmaek-invoke:"] = "无濟 是否對 %src發動",

  ["$maekmaek1"] = "我欲行夏禹旧事，为天下人。",

}

maekmaek:addEffect(fk.EventPhaseStart, {
  anim_type = "control",
  can_trigger = function (self, event, target, player, data)
    return target==player and player:hasSkill(maekmaek.name) and data.phase==Player.Finish
    and table.find(player.room.alive_players,function(p)
      return p~=player and p:isWounded()
    end)
  end,
  on_cost = function (self, event, target, player, data)
    local room = player.room
    local targets=table.filter(player.room.alive_players,function(p)
      return p~=player and p:isWounded()
    end)
    local tos = player.room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = targets,  --
      skill_name = maekmaek.name,
      prompt = "#maekmaek-choose",
      cancelable = true,
    })
    if #tos > 0 then
      event:setCostData(self, {tos = tos})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    exe =function(p)
      if p.dead then return end
    room:recover{
      who = p,
      num = 1,
      recoverBy = player,
      skillName = maekmaek.name,
    }
    room:addPlayerMark(p,"@loav",1)
  end
  exe(player)
  exe(event:getCostData(self).tos[1])
  end,
})



return maekmaek
