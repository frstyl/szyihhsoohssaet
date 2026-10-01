local qwenqhzfet = fk.CreateSkill {
  name = "qwenqhzfet",
  -- add_skills = {"change_phase_draw",},
}

Fk:loadTranslationTable{
  ["qwenqhzfet"] = "圓滑",
  [":qwenqhzfet"] = "伱起動牌旹,若目幖不爲伱,伱可選擇1其它腳色A發動,起動者改爲A,伱抽1",


  ["#qwenqhzfet-ask"] = "圓滑 令1腳色成爲 %arg 起動者",
}

qwenqhzfet:addEffect(fk.CardUsing, { 
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return data.from == player and player:hasSkill(qwenqhzfet.name) 
    and not table.contains(data.tos,player)
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local targets = room:getOtherPlayers(player, false)
    local to = room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = targets,
      skill_name = qwenqhzfet.name,
      prompt = "#qwenqhzfet-ask:::"..data.card:toLogString(),
      cancelable = true,
    })
    if #to > 0 then
      event:setCostData(self, {tos = to})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    data.from = event:getCostData(self).tos[1]
    data.extra_data=data.extra_data or {}
    data.extra_data.origin_from=data.extra_data.origin_from or player
    player:drawCards(1,qwenqhzfet.name)
  end,
})

return qwenqhzfet
