local noophzeen = fk.CreateSkill {
  name = "noophzeen",
}

Fk:loadTranslationTable{
  ["noophzeen"] = "納賢",
  [":noophzeen"] = "輪限max(1,伱已損體力值)｡其它角色轉始旹,伱可聲明一階段名發動,伱越過伱下个同名段,該角色此段執行同名段",

  ["#noophzeen-invoke"] = "納賢  %src轉 是否令其額外執行1次階段",
  ["@toSkipPhases"] = "越",

  ["$noophzeen1"] = "兄弟若不嫌弃上吾山寨盤桓數日如何",
  ["$noophzeen2"] = "杜某願把昰把交倚讓与兄弟",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 



noophzeen:addEffect(fk.TurnStart, {
  anim_type = "support",
  times = function(self, player)
    return math.max(player:getLostHp(),1)- player:usedSkillTimes(noophzeen.name, Player.HistoryRound)
  end,
  can_trigger = function(self, event, target, player, data)
    return  target~=player
    and player:hasSkill(noophzeen.name)  
    and  self.times(self, player)>0 
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    -- return player.room:askToSkillInvoke(player, {skill_name = noophzeen.name, prompt = "#noophzeen-invoke:"..target.id.."::"..S.getPhaseString(data.phase)})
    -- local phase={"預段","伏段","補段","主段","撤段","末段","不發動"}

    -- local choices={Player.Start, Card.Judge, Player.Draw, Player.Play, Player.Discard, Player.Finish,}
    local toskip=player:getTableMark("@toSkipPhases")
    -- for _, num in pairs(choices) do
    --           num=S.getPhaseString(num)
    --   if 
    --     table.find(toskip, S.getPhaseString()) 
    --     then
    --    num=nil

    --   end
    -- end

    local choices = {}
    for i = 2, 7, 1 do
      p=S.getPhaseString(i)
      if not table.contains(toskip, p) then
      table.insert(choices, p)
      end
    end
    -- if #choices==0 then return end
    
    table.insert(choices, "Cancel")
    local choice = room:askToChoice(player, {
      choices = choices,
      skill_name = noophzeen.name,
      prompt = "#noophzeen-invoke:"..target.id,
    })

    if choice=="Cancel" then return end
    event:setCostData(self,{phase =  S.getPhaseClass(choice)})
    return true
  end,
  on_use = function(self, event, target, player, data)
    target:drawCards(1,noophzeen.name)
    local phase =event:getCostData(self).phase
    S.skipPhase(player.id , phase)
    target:gainAnExtraPhase(phase, noophzeen.name,true)  --甚至幖記歬 技能內  --delay 加在此段後
  end,
})


return noophzeen
