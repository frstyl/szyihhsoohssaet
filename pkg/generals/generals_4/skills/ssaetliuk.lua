local ssaetliuk = fk.CreateSkill{
  name = "ssaetliuk",
  -- tags = { Skill.Compulsory },  --有次數
}

Fk:loadTranslationTable{
  ["ssaetliuk"] = "殺戮",
  [":ssaetliuk"] = "➀恆續｡伱起動殺旹能且必選擇全部合理目幖.➁伱起動殺結算完畢旹,若此牌致傷,必發.伱占卜x次,若占卜牌爲黑伱取得之,此殺不計入次數限制｡x爲此牌致傷次數",

  -- ["ssaet_times-phase"] = "殺數",

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
    local ex=data:getExtraTargets({bypass_distances = data.extra_data and data.extra_data.bypass_distances or false, bypass_times=true})
    for _, p in ipairs(room.players)  do
      if  table.contains(ex,p) then
      table.insertIfNeed(targets,p)
      end
    end
    room:doIndicate(player, targets)  --不是增加目幖 眞實機爲作用于牌
    data.tos = targets
  end,
})

-- ssaetliuk:addEffect("targetmod", {
  -- fix_target = function(self, player, skill,card,extra_data)
  -- end,
--   extra_target_func = function(self, player, skill,card)
--     if player and player:hasSkill(ssaetliuk.name) and card and card.trueName=="ssaet" then
--       return 999
--     end
--   end,
--   -- bypass_distances = function(self, player, skill, card, to)
--   --   return player and player:hasSkill(ssaetliuk.name) and card and card.trueName=="ssaet"
--   -- end,
-- })

ssaetliuk:addEffect(fk.CardUseFinished, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(ssaetliuk.name) 
    and  data.card.trueName=="ssaet"
    and data.damageDealt
  end,
  on_cost = function(self, event, target, player, data)
    return true
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    for i,v in pairs(data.damageDealt )  do
      if player.dead then return end
      local judge = {
          who = player,
          reason = ssaetliuk.name,
          pattern = ".|.|black",
        }
      room:judge(judge)
      if  judge.card.color == Card.Black then 
        -- room:addSkill("ssaet_times")
        -- room:addPlayerMark(player, "ssaet_times-phase",1)
        if not data.extraUse then
          player:addCardUseHistory(data.card.trueName, -1)
          data.extraUse = true
        end
      end
    end
  end,
})

ssaetliuk:addEffect(fk.FinishJudge, {
  mute = true,
  is_delay_effect = true,
  can_trigger = function(self, event, target, player, data)
    return target == player
     and not player.dead 
     and data.reason==ssaetliuk.name
     and data.card.color==Card.Black
     and  player.room:getCardArea(data.card) == Card.Processing
  end,
  on_use = function(self, event, target, player, data)
    player.room:obtainCard(player, data.card, true, fk.ReasonPrey, nil, ssaetliuk.name)
  end,
})


return ssaetliuk
