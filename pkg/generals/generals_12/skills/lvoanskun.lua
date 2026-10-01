local lvoanskun = fk.CreateSkill {
  name = "lvoanskun",
  tags={Skill.Switch},
}

Fk:loadTranslationTable{
  ["lvoanskun"] = "亂軍",
  [":lvoanskun"] = "輪流發動.一脚色受傷後,伱可選擇1腳色(勢力与受傷腳色相同)發動,伱➀令其抽1;➁弃置其1牌",  --類 勢力 陣營--應國戰專用

  ["#lvoanskun-draw"] = "亂軍：你可令%src抽1",
  ["#lvoanskun-discard"] = "亂軍：弃 %src 勢力1牌",

  ["$lvoanskun1"] = "敗將,吾不赶伱",
  ["$lvoanskun2"] = "叫它出來与我交戰"
}

local isSameForce=function(p1,p2)
    -- if room:isGameMode("role_mode") then end
  return  (p1.kingdom ==p2.kingdom)
end

lvoanskun:addEffect(fk.Damaged, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target and player:hasSkill(lvoanskun.name) 
  end,
  -- trigger_times = function(self, event, target, player, data)
  --   return data.Damaged
  -- end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    -- local targets={}
    -- if player:getSwitchSkillState(lvoanskun.name, false)==fk.SwitchYin then
    --   targets=table.filter(room.alive_players,function(p)
    --   return isSameForce(data.to,p)
    --   end)
    --   else
    --           targets=table.filter(room.alive_players,function(p)
    --   return not isSameForce(data.to,p)
    --   end)
    -- end

      local tos = room:askToChoosePlayers(player,{
        targets = room.alive_players,
        min_num=1,
        max_num=1,
        prompt = "#lvoanskun-discard:"..data.to.id,
        skill_name = lvoanskun.name,
        cancelable = true,
      })
      if #tos>0 then 
        event:setCostData(self,{tos=to,player:getSwitchSkillState(lvoanskun.name, false)})
        return true
      end

  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local to =event:getCostData(self).tos[1]
    if event:getCostData(self).switch==fk.SwitchYin then
      if not to:isNude() then
      local cid = room:askToChooseCard(player, { target = to, flag = "he", skill_name = lvoanskun.name })
      room:throwCard({cid}, lvoanskun.name, to, player)
      end
    else  
      to:drawCards(1, lvoanskun.name)
    end
  end,
})



return lvoanskun
