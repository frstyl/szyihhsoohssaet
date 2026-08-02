local ssaet_times = fk.CreateSkill {
  name = "ssaet_times",
}

local temp = {"","-round" , "-turn" , "-phase" , "-noclear"}
ssaet_times:addEffect("targetmod", {
  -- fix_target = function(self, player, skill,card,extra_data)
  -- end,
  extra_target_func = function(self, player, skill,card)
    if  card.trueName == "ssaet"  then
      local n =0
      for _, suf in ipairs(temp ) do
        n=n+player:getMark("ssaet_target"..suf)
      end
      return n
    end
  end,
  residue_func = function(self, player, skill, scope,card, to)
    if  card.trueName == "ssaet"  then
      local n =0
      for _, suf in ipairs(temp ) do
        n=n+player:getMark("@ssaet_times"..suf)
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


ssaet_times:addEffect(fk.PreCardUse, {
  can_refresh = function (self, event, target, player, data)
    if target ~= player or data.extraUse then return end
    return player:hasMark("ssaet_extraUse")
  end,
  on_refresh = function (self, event, target, player, data)
    data.extraUse = true
  end,
})


return ssaet_times
