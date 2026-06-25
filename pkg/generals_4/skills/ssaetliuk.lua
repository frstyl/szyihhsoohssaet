local ssaetliuk = fk.CreateSkill{
  name = "ssaetliuk",
  -- tags = { Skill.Compulsory },  --有次數
}

Fk:loadTranslationTable{
  ["ssaetliuk"] = "殺戮",
  [":ssaetliuk"] = "➀恆續效果伱使用殺旹能且必選擇全部合理目幖.➁伱使用殺結算完畢旹,若此牌于此次使用中致傷,必發.伱判定,伱獲得判定牌且若其爲黑,此階段伱殺使用上限+1",

  ["@ssaet_times-phase"] = "殺數",

  -- ["$ssaetliuk"] = "喫俺一斧",
}

ssaetliuk:addEffect(fk.PreCardUse, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(ssaetliuk.name) and
      data.card.trueName=="ssaet"
      --and #data:getExtraTargets(data.extra_data)>0
  end,
  on_trigger = function(self, event, target, player, data)
    local room = player.room
    local targets = data.tos
    local ex=data:getExtraTargets(data.extra_data)
    for _, p in ipairs(room.players)  do
      if  table.contains(ex,p) then
      table.insertIfNeed(targets,p)
      end
    end
    room:doIndicate(player, targets)  --不是增加目幖 眞實機爲作用于牌
    data.tos = targets
  end,
})

ssaetliuk:addEffect(fk.CardUseFinished, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(ssaetliuk.name) and
      data.card.trueName=="ssaet" and data.damageDealt
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local judge = {
        who = player,
        reason = ssaetliuk.name,
        pattern = ".|.|black",
      }
    room:judge(judge)
    if  judge.card.color == Card.Black then 
      room:addPlayerMark(player, "@ssaet_times-phase",1)
    end
  end,
})

ssaetliuk:addEffect(fk.FinishJudge, {
  mute = true,
  is_delay_effect = true,
  can_trigger = function(self, event, target, player, data)
    return target == player and not player.dead 
     and  player.room:getCardArea(data.card) == Card.Processing
  end,
  on_use = function(self, event, target, player, data)
    player.room:obtainCard(player, data.card, true, fk.ReasonJustMove, nil, ssaetliuk.name)
  end,
})

ssaetliuk:addEffect("targetmod", {
  residue_func = function(self, player, skill, scope)
    if player:getMark("@ssaet_times-phase") > 0 and skill.trueName == "ssaet_skill" and scope == Player.HistoryPhase then
      return player:getMark("@ssaet_times-phase")
    end
  end,
})

return ssaetliuk
