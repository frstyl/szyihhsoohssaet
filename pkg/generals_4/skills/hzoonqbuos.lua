local hzoonqbuos = fk.CreateSkill {
  name = "hzoonqbuos",
  tags = { Skill.Limited },
}

Fk:loadTranslationTable {
  ["hzoonqbuos"] = "䰟附",
  [":hzoonqbuos"] = "每局限1.其它角色A死亾後,伱可發動,伱技能改爲与其相同,伱殺死兇手旹恢復",

  ["#hzoonqbuos-invoke"] = "䰟附：復刻 %dest 技能",

  ["$hzoonqbuos1"] = "弟之英䰟㬎靈",
}

hzoonqbuos:addEffect(fk.Deathed, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(hzoonqbuos.name) 
    and player:usedSkillTimes(hzoonqbuos.name, Player.HistoryGame) == 0 
    and player:getMark("hzoonqbuos_from")==0 
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = hzoonqbuos.name,
      prompt = "#hzoonqbuos-invoke::"..target.id
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local sk={}
    for k, p in ipairs({player,target}) do
      local skills={}
      for _, s in ipairs(p.player_skills) do
      if s:isPlayerSkill(p) then
        table.insertIfNeed(skills, s.name)
        end
      end
      room:setPlayerMark(player, hzoonqbuos.name..tostring(k), skills)
      sk[p.id] = skills
    end
    room:setPlayerMark(player, "hzoonqbuos_killer",  data.killer.id)
    room:setPlayerMark(player, "hzoonqbuos_from",  target.id)
    local skill=table.concat(sk[target.id],"|").."|-"..table.concat(sk[player.id], "|-")
    room:handleAddLoseSkills(player,skill, nil, true, false)  --function不同旹
  end,
})

hzoonqbuos:addEffect(fk.Death,{ 
  can_trigger = function(self, event, target, player, data)  --錯過旹機不恢復
    return target.id == player:getMark("hzoonqbuos_killer")
  end,
  on_trigger = function(self, event, target, player, data)
    local room = player.room
    local skill=table.concat(player:getTableMark(hzoonqbuos.name.."1"),"|").."|-"..table.concat(player:getTableMark(hzoonqbuos.name.."2"), "|-")
    room:handleAddLoseSkills(player,skill, nil, true, false)
    room:setPlayerMark(player, hzoonqbuos.name.."1",  nil)
    room:setPlayerMark(player, hzoonqbuos.name.."2",  nil)
    room:setPlayerMark(player, "hzoonqbuos_killer",  nil)
    room:setPlayerMark(player, "hzoonqbuos_from",  nil)
end,
})
return hzoonqbuos
