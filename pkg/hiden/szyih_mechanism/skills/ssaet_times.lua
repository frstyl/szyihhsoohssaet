local ssaet_times = fk.CreateSkill {
  name = "ssaet_times",
}

Fk:loadTranslationTable{
  ["ssaet_times"] = "殺次數上限",
  ["ssaet_target_number"] = "殺目幖上限",

  ["@ssaet_remain_times-phase"] = "殺次數",
  -- ["$jjeqdzius1"] = "",
}
local temp = {"","-round" , "-turn" , "-phase" , "-noclear"}

ssaet_times:addEffect("targetmod", {
  -- fix_target = function(self, player, skill,card,extra_data)
  -- end,
  extra_target_func = function(self, player, skill,card)
    if  card.trueName == "ssaet"  then
      local n =0
      for _, suf in ipairs(temp ) do
        n=n+player:getMark("ssaet_target_number"..suf)
      end
      return n
    end
  end,
  residue_func = function(self, player, skill, scope,card, to)
    if  card.trueName == "ssaet"  then
      local n =0
      for _, suf in ipairs(temp ) do
        n=n+player:getMark("ssaet_times"..suf)
      end
      return n
    end
  end,
  -- fix_times_func = function(self, player, skill, scope, card,to)

  -- end,
  bypass_times = function(self, player, skill, scope, card, to)
    if  card and card.trueName == "ssaet" then
      if player and player:hasMark("ssaet_bypass_times")  then return true end
      if to and   table.contains(player:getTableMark("ssaet_bypass_times_to"), to.id)   then return true end --if to必需
    end
  end,
  bypass_distances = function (self, player, skill,card,to)
    return  card.trueName == "ssaet"  and (player:hasMark("ssaet_bypass_distances")
    or  table.contains(player:getTableMark("ssaet_bypass_distances_to"), to.id) )
  end,
  -- distance_limit_func = function (self, player, skill,card,to)
  -- end,
})

ssaet_times:addEffect(fk.StartPlayCard, {
  can_refresh = function (self, event, target, player, data)
    return target == player
    -- and not player:hasMark("ssaet_bypass_times") 
  end,
  on_refresh = function (self, event, target, player, data)
    -- local n=
    -- if n and n>0 then
     player.room:setPlayerMark(player,"@ssaet_remain_times-phase",{ player:usedCardTimes("ssaet", Player.HistoryPhase) ,Fk:cloneCard("ssaet").skill:getMaxUseTime(player, Player.HistoryPhase, Fk:cloneCard("ssaet")) })
    -- end
  end,
})

ssaet_times:addEffect(fk.PreCardUse, {
  can_refresh = function (self, event, target, player, data)
    return target == player and not data.extraUse 
    and (player:hasMark("ssaet_extra_use") or data.card:hasMark("extra_use"))

  end,
  on_refresh = function (self, event, target, player, data)
    if player:hasMark("ssaet_extra_use") then
    data.extraUse = true
    end
  end,
})


return ssaet_times
