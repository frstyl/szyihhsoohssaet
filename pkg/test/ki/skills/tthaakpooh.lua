local tthaakpooh = fk.CreateSkill {
  name = "tthaakpooh",
}

Fk:loadTranslationTable{
  ["tthaakpooh"] = "支絀",
  [":tthaakpooh"] = "伱段始旹,伱可于下述笵圍內轉迻伱1數值(≤0者不可減)攻程,存牌數,額定抽牌數,｢殺｣起動次數限制",

  ["#tthaakpooh-invoke"] = "支絀 轉迻伱1數值",
  -- ["$tthaakpooh1"] = "将为军魂，需以身作则。",
  -- ["$tthaakpooh2"] = "整肃三军，可育虎贲。",
}
local S = require "packages/szyihhsoohssaet/szyih_guos"

tthaakpooh:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(tthaakpooh.name) 
    and player.phase>1 and player.phase<8
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local all={"AddMaxCards","@add_attack_range","@add_phase_draw","@ssaet_times"}

    local getMarkNumber = function(player,name)
    local n = 0
     local t = {"","-round" , "-turn" , "-phase" , "-noclear"}
      for _, suffix in ipairs(t) do
        n=n+player:getMark(name..suffix)       
      end
      return n
    end

    local choiceList={}
    if player:getMaxCards()>0 then table.insert(choiceList,"AddMaxCards") end
    if player:getAttackRange()>0 then table.insert(choiceList,"@add_attack_range") end
    if getMarkNumber(player,"@ssaet_times")+1>0 then  table.insert(choiceList,"@ssaet_times") end
    if getMarkNumber(player,"@add_phase_draw")+2>0 then  table.insert(choiceList,"@add_phase_draw") end
    -- if player:getMaxUseTime(player,Player.Phase,Fk:cloneCard("ssaet"))>0 then then table.insert(choiceList,"@ssaet_times") end
    if #choiceList<2 then return end
    local choices = room:askToChoices(player, {
      choices = choiceList,
      min_num = 2,
      max_num = 2,
      skill_name = tthaakpooh.name,
      all_choices = all,
      cancelable = true,
    })
    if #choices==2 then 
      event:setCostData(self, {choice=choices})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    -- for _, mark in ipairs(event:getCostData(self).choice) do
    -- end  
    local room=player.room
    local t =event:getCostData(self).choice
    room:setPlayerMark(player,t[1],-1+player:getMark(t[1]))
    room:setPlayerMark(player,t[2],1+player:getMark(t[2]))
  end,
})

return tthaakpooh
