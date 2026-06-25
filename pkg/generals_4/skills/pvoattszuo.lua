local pvoattszuo = fk.CreateSkill {
  name = "pvoattszuo",
}

Fk:loadTranslationTable{
  ["pvoattszuo"] = "撥珠",
  [":pvoattszuo"] = "伱于主段內使用牌旹,若x爲{單/雙}數,令記錄{+/-}此牌點數,无點數視爲0.轉限1.主段終,若記錄爲0且x>0,伱可發動,伱抽x執行1額外主段.x爲伱當段所用牌數",

  ["#pvoattszuo-invoke"] = "撥珠：抽%arg執行額外主段",

  ["@pvoattszuo_number-phase"] = "撥珠",
  -- ["pvoattszuo_count-phase"] = "用牌數",

  ["$pvoattszuo1"] = "今日宴请诸位，有要事相商。",
  ["$pvoattszuo2"] = "天下未定，请主公以大局为重。",
}

pvoattszuo:addEffect(fk.EventPhaseEnd, {
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(pvoattszuo.name) 
    -- and target==player and target.phase == Player.Play 
    -- and  player:usedSkillTimes(pvoattszuo.name, Player.HistoryTurn) == 0 
    and player:getMark("@pvoattszuo_number-phase")==0
    and player:getMark("pvoattszuo_count-phase")>0
  end,
  -- on_cost = function(self, event, target, player, data)
  --   local room = player.room
  --   local cards = room:askToDiscard(player, {
  --     min_num = 1,
  --     max_num = 1,
  --     include_equip = true,
  --     skill_name = pvoattszuo.name,
  --     cancelable = true,
  --     prompt = "#pvoattszuo-invoke::"..player:getMark("@pvoattszuo_number-phase"),
  --     skip = true,
  --   })
  --   if #cards > 0 then
  --     event:setCostData(self, {tos = {target}, cards = cards})
  --     return true
  --   end
  -- end,
  on_use = function(self, event, target, player, data)
    player:drawCards(player:getMark("pvoattszuo_count-phase"),pvoattszuo.name)
    player:gainAnExtraPhase(Player.Play, pvoattszuo.name)
  end,
})

pvoattszuo:addEffect(fk.EventPhaseStart, {
  can_refresh = function (self, event, target, player, data)
    return player:hasSkill(pvoattszuo.name) and target==player and target.phase == Player.Play 
    and  player:usedSkillTimes(pvoattszuo.name, Player.HistoryTurn) == 0 
  end,
  on_refresh = function (self, event, target, player, data)
      player.room:setPlayerMark(player,"pvoattszuo_start-phase",1)
  end,
})
pvoattszuo:addEffect(fk.AfterCardUseDeclared, {
  can_refresh = function (self, event, target, player, data)
    return target == player and player:getMark("pvoattszuo_start-phase")>0
  end,
  on_refresh = function (self, event, target, player, data)
    local room=player.room
    local n =data.card.number
    local m =player:getMark("@pvoattszuo_number-phase")
    if player:getMark("pvoattszuo_switch-phase") > 0 then  --➁
      m=m-n
      room:setPlayerMark(player,"pvoattszuo_switch-phase",0)
    else
      m=m+n
      room:setPlayerMark(player,"pvoattszuo_switch-phase",1)
    end
    room:setPlayerMark(player,"@pvoattszuo_number-phase",m)
    room:addPlayerMark(player,"pvoattszuo_count-phase",1)
  end,
})
return pvoattszuo
