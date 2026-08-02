local noeophzeen = fk.CreateSkill {
  name = "noeophzeen",
}

Fk:loadTranslationTable{
  ["noeophzeen"] = "納賢",
  [":noeophzeen"] = "輪限max(1,伱已損體力值)｡其它脚色轉始旹,伱可聲明一段類發動,伱越過伱下个同名段,該脚色此段執行同名段",

  ["#noeophzeen-invoke"] = "納賢  %src轉 是否令其額外執行1次階段",
  ["@toSkipPhases"] = "越",

  ["$noeophzeen1"] = "兄弟若不嫌弃上吾山寨盤桓數日如何",
  ["$noeophzeen2"] = "杜某願把昰把交倚讓与兄弟",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 



noeophzeen:addEffect(fk.TurnStart, {
  anim_type = "support",
  times = function(self, player)
    return math.max(player:getLostHp(),1)- player:usedSkillTimes(noeophzeen.name, Player.HistoryRound)
  end,
  can_trigger = function(self, event, target, player, data)
    return  target~=player
    and player:hasSkill(noeophzeen.name)  
    and  self.times(self, player)>0 
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    -- return player.room:askToSkillInvoke(player, {skill_name = noeophzeen.name, prompt = "#noeophzeen-invoke:"..target.id.."::"..S.getPhaseString(data.phase)})
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
      skill_name = noeophzeen.name,
      prompt = "#noeophzeen-invoke:"..target.id,
    })

    if choice=="Cancel" then return end
    event:setCostData(self,{phase =  S.getPhaseClass(choice)})
    return true
  end,
  on_use = function(self, event, target, player, data)
    target:drawCards(1,noeophzeen.name)
    local phase =event:getCostData(self).phase
    S.skipPhase(player.id , phase)
    target:gainAnExtraPhase(phase, noeophzeen.name,true)  --甚至幖記歬 技能內  --delay 加在此段後
  end,
})


return noeophzeen
