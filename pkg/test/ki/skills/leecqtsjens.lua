local leecqtsjens = fk.CreateSkill {
  name = "leecqtsjens",
  tags={Skill.Limit}
}

Fk:loadTranslationTable{
  ["leecqtsjens"] = "翎箭",
  [":leecqtsjens"] = "伱起動牌旹,伱可選1脚色手牌數与伱相同者發動,伱予其1傷",

  ["#leecqtsjens-invoke"] = "翎箭：是否執行額外轉？",
}


leecqtsjens:addEffect(fk.CardUsing, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(leecqtsjens.name)
  end,
  on_cost = function(self, event, target, player, data)
    local n =player:getHandcardNum()
    local targets=table.filter(player.room.alive_players,
  function(p)
  return p:getHandcardNum()==n
  end)
    if #targets==0 then return end
     player.room:askToSkillInvoke(player, {
      targets = targets,
      min_num = 1,
      max_num = 1,
      prompt = "#leecqtsjens-ask",
      skill_name = leecqtsjens.name,
    })
    if #tos > 0 then
      event:setCostData(self, { tos = tos })
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    player.room:damage({
      from=player,
      to=event:getCostData(self).tos[1],
      num=1,
      skillName = leecqtsjens.name,
    })
  end,
})


return leecqtsjens
