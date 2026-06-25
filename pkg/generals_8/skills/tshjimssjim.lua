local tshjimssjim = fk.CreateSkill{
  name = "tshjimssjim",
}

Fk:loadTranslationTable{
  ["tshjimssjim"] = "沁心",
  [":tshjimssjim"] = "預段末段始旹,伱受傷後,伱可伱聲明一花色發動.伱判定,判定牌生效後,若其:在處理區伱獲得之;花色与伱所聲明相同,伱回1",

  ["tshjimssjim_log"] = "%src 聲明沁心花色爲 %arg ",

  ["$tshjimssjim1"] = "白玉生香",
  ["$tshjimssjim2"] = "清歌浩齒",
}

local tshjimssjim_spec = {
  on_cost = function(self, event, target, player, data)
      local choice = player.room:askToChoice(player, {
      choices = {"log_spade", "log_heart", "log_club", "log_diamond"},
      skill_name = tshjimssjim.name,
      prompt = "#tshjimssjim-choice"
    })
    if choice then 
      event:setCostData(self, {choice = {choice}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    -- room:sendLog("tshjimssjim_log:"..player.id.."::"..choice)
    local choice = event:getCostData(self).choice[1] --id
    room:sendLog{
      type = "#Choice",
      from = player.id,
      arg = choice,
      toast = true,
    }
    local logsuit={"log_spade", "log_heart", "log_club", "log_diamond"}
    local suit={"spade", "heart", "club", "diamond"}
    choice = suit[table.indexOf(logsuit, choice)]
    local judge = {
        who = player,
        reason = tshjimssjim.name,
        pattern = ".|.|"..choice,
      }
    room:judge(judge)
    if  judge.card:getSuitString() == choice then 
      room:recover{
        who = player,
        num = 1,
        recoverBy = player,
        skillName = tshjimssjim.name,
      }
    end
  end,
}
tshjimssjim:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and (player.phase == Player.Start or  player.phase == Player.Finish) and player:hasSkill(tshjimssjim.name)
  end,
  on_cost = tshjimssjim_spec.on_cost,
  on_use = tshjimssjim_spec.on_use,
})

tshjimssjim:addEffect(fk.Damage, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player  and player:hasSkill(tshjimssjim.name)
  end,
  on_cost = tshjimssjim_spec.on_cost,
  on_use = tshjimssjim_spec.on_use,
})

tshjimssjim:addEffect(fk.FinishJudge, {
  mute = true,
  is_delay_effect = true,
  can_trigger = function(self, event, target, player, data)
    return target == player and data.reason == tshjimssjim.name
      and player.room:getCardArea(data.card) == Card.Processing
  end,
  on_use = function(self, event, target, player, data)
    player.room:obtainCard(player, data.card, true, nil, player, tshjimssjim.name)
  end,
})



return tshjimssjim
