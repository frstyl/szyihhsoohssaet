local times = fk.CreateSkill {
  name = "times_skill",
}



times:addEffect(fk.PreCardUse, {
  -- global=true,
  priority=999, --禁插入結算
  can_trigger = function(self, event, target, player, data)
    return target == player
  end,
  on_trigger = function(self, event, target, player, data)  --addPlayerMark?
    local all= player:getTableMark("cardTimes")
    local t =  all[data.card.name]  or {0, 0, 0, 0}  --分別trueName??

    for i, _ in ipairs(t) do
      t[i] = t[i] + 1
    end
    all[data.card.name]=t
    player.room:setPlayerMark(player,"cardTimes", all)
  end,
})


times:addEffect(fk.SkillEffect, {
  -- global=true,
  priority=999, --禁插入結算
  can_trigger = function(self, event, target, player, data)
    return data.who == player  --含cardSkill  --skill某段effect_names  getSkeleton爲總次數  --分支可能多旹機
  end,
  on_trigger = function(self, event, target, player, data)
    local names={
    data.skill:getSkeleton().name,  --框架次數    --分別trueName??
    data.skill.name ~= data.skill:getSkeleton().name and data.skill.name or "#" .. data.skill.name .. "_main_skill",  --段次數 可能同旹機 同效
    }
    local all= player:getTableMark("skillTimes")
    for _,name in ipairs(names) do
      local t =  all[name]  or {0, 0, 0, 0}
      for i, _ in ipairs(t) do
        t[i] = t[i] + 1
      end
      all[name]=t
    end
    player.room:setPlayerMark(player,"skillTimes", all)



    -- local branch = data.skill_data and data.skill_data.history_branch  --分支次數 --如何止禁分支?  --同一效果多个計數 
    -- if branch then
    --   local all= player:getTableMark("skillBranchTimes")
    --   local t = [data.skill.name] = all[data.skill.name]  or {}
    --   t[branch]=t[branch] or {0, 0, 0, 0}
    --   for i, _ in ipairs(t[branch]) do
    --     t[i] = t[branch][i] + num
    --   end
    --   all[data.skill.name]=t
    --   player.room:setPlayerMark(player,"skillBranchTimes", all)
    -- end

  end,
})



return times
