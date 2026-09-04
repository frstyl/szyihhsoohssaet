local jjeqdzius = fk.CreateSkill {
  name = "jjeqdzius",
}

Fk:loadTranslationTable{
  ["jjeqdzius"] = "迻就",
  [":jjeqdzius"] = "伱段始旹,伱可于下述笵圍選擇2項(持續1轉,可負)其前項減1(裝僃欄爲廢除)後項+1數(或恢復):攻程,存牌數,額定抽牌數,起動｢殺｣次數上限,某裝僃欄",

  ["#jjeqdzius-minus"] = "迻就 %arg 減少伱1數值",
  ["#jjeqdzius-add"] = "迻就 %arg 增加伱1數值",

  ["@minus_phase_discard"] = "存牌數",
  -- ["$jjeqdzius1"] = "",
}
local S = require "packages/szyihhsoohssaet/szyih_guos"

jjeqdzius:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(jjeqdzius.name) 
    and player.phase>1 and player.phase<8
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local all={"@minus_phase_discard","@attack_range","@phase_draw","ssaet_times"}
    -- local slots=player.equipSlots

    local getMarkNumber = function(player,name)
    local n = 0
     local t = {"","-round" , "-turn" , "-phase" , "-noclear"}
      for _, suffix in ipairs(t) do
        n=n+player:getMark(name..suffix)       
      end
      return n
    end

    local choiceList={}
    if S.getMaxCards(player)>0 then table.insert(choiceList,"@minus_phase_discard") end
    if player:getAttackRange()>0 then table.insert(choiceList,"@attack_range") end
    if getMarkNumber(player,"@phase_draw")+2>0 then  table.insert(choiceList,"@phase_draw") end
    if getMarkNumber(player,"ssaet_times")+1>0 then  table.insert(choiceList,"ssaet_times") end
    -- -- if player:getMaxUseTime(player,Player.Phase,Fk:cloneCard("ssaet"))>0 then then table.insert(choiceList,"ssaet_times") end
    -- if #choiceList<2 then return end

    table.insertTable(choiceList,player:getAvailableEquipSlots())
    local choices1 = room:askToChoice(player, {
      choices = choiceList,
      skill_name = jjeqdzius.name,
      -- all_choices = all,
      cancelable = true,
      prompt="#jjeqdzius-minus:::"..Util.PhaseStrMapper(data.phase)
    })
    if choices1=="Cancel" then return end 

    choiceList=all
    table.insertTable(choiceList,player.sealedSlots)

    local choices2 = room:askToChoice(player, {
      choices = choiceList,
      skill_name = jjeqdzius.name,
      cancelable = true,
      prompt="#jjeqdzius-add:::"..Util.PhaseStrMapper(data.phase)
    })
    if choices1=="Cancel" then return end 
    local choices={choices1,choices2}
      for _, k in ipairs(choices) do
        if k =="@minus_phase_discard" then k ="AddMaxCards" end
      end
      event:setCostData(self, {choice=choices})
      return true
    
  end,
  on_use = function(self, event, target, player, data)
    -- for _, mark in ipairs(event:getCostData(self).choice) do
    -- end  
    local room=player.room
    local t =event:getCostData(self).choice
    if t[1]:endsWith("Slot") then
      room:abortPlayerArea(player, t[1])
    else
      room:setPlayerMark(player,t[1],-1+player:getMark(t[1]))
    end

    if t[2]:endsWith("Slot") then
      room:resumePlayerArea(player, t[2])
    else
      room:setPlayerMark(player,t[2],1+player:getMark(t[2]))
    end
  end,
})

return jjeqdzius
