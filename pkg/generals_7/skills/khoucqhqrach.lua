local khoucqhqrach = fk.CreateSkill({
  name = "khoucqhqrach",
})

Fk:loadTranslationTable{
  ["khoucqhqrach"] = "空影",
  [":khoucqhqrach"] = "當伱使用或打出{「閃」/「殺」}旹，你可指定1其他角色發動,其須打出1{「閃」/「殺」},否則伱与其1雷傷。",

  ["#khoucqhqrach-choose"] = "空影： 選擇雷劈目幖",
  ["#khoucqhqrach-ask"] = "空影： 來自%src 打出 %arg",

  -- ["$khoucqhqrach1"] = "以我之真气，合天地之造化！",
  -- ["$khoucqhqrach2"] = "雷公助我！",
}

local khoucqhqrach_spec = {
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(khoucqhqrach.name) and target == player and (data.card.name == "szjemh" or data.card.trueName == "ssaet")
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local to = room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = room:getOtherPlayers(player),
      skill_name = khoucqhqrach.name,
      prompt = "#khoucqhqrach-choose",
      cancelable = true,
    })
    if #to > 0 then
      event:setCostData(self, {tos = to})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local to = event:getCostData(self).tos[1]

    local respond = room:askToResponse(to, {--?? SkillEffectDataSpec
      skill_name = khoucqhqrach.name,
      pattern = data.card.trueName,
      prompt = "#khoucqhqrach-ask:" .. player.id .. "::"  .. data.card.trueName,
      cancelable = true,
      -- event_data = {
      --   to=to,
      --   from=player,
      -- },--skill card
    })
    if respond then
        room:responseCard(respond)
    else
    room:damage{
      from = player,
      to = to,
      damage = 1,
      damageType = fk.ThunderDamage,
      skillName = khoucqhqrach.name,
    }
    end
  end,
}

khoucqhqrach:addEffect(fk.CardUsing, khoucqhqrach_spec)
khoucqhqrach:addEffect(fk.CardResponding, khoucqhqrach_spec)

return khoucqhqrach
