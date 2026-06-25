local lvoanskun = fk.CreateSkill {
  name = "lvoanskun",
  tags={Skill.Switch},
}

Fk:loadTranslationTable{
  ["lvoanskun"] = "亂軍",
  [":lvoanskun"] = "輪流發動.當一角色受傷後,伱可➀發動,令其抽1;➁選擇其勢力(羣類)1牌發動,伱弃之",  --類 勢力 陣營--應國戰專用

  ["#lvoanskun-draw"] = "亂軍：你可令%src抽1",
  ["#lvoanskun-discard"] = "亂軍：弃 %src 勢力1牌",

  ["$lvoanskun1"] = "敗將,吾不赶伱",
  ["$lvoanskun2"] = "叫它出來与我交戰"
}

local isSameForce=function(p1,p2)
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
    if player:getSwitchSkillState(lvoanskun.name, false)==fk.SwitchYin then
      targets=table.filter(room.alive_players,function(p)
      return isSameForce(data.to,p)
      end)
      local to = room:askToChoosePlayers(player,{
        targets = targets,
        min_num=1,
        max_num=1,
        prompt = "#lvoanskun-discard:"..data.to.id,
        skill_name = lvoanskun.name,
        cancelable = true,
      })
      if #to>0 then 
        event:setCostData(self,{tos=to,choose=2})
        return true
      end
    else
      if room:askToSkillInvoke(player, { skill_name = lvoanskun.name ,prompt="#lvoanskun-draw:"..data.to.id})  then
        event:setCostData(self,{tos=to,choose=1})
        return true
      end
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    if event:getCostData(self).choose==2 then
      local to =event:getCostData(self).tos[1]
      local cid = room:askToChooseCard(player, { target = to, flag = "he", skill_name = lvoanskun.name })
      room:throwCard({cid}, lvoanskun.name, to, player)

    else  
      target:drawCards(1, lvoanskun.name)
    end
  end,
})



return lvoanskun
