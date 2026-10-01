local hqoavhsiacs = fk.CreateSkill {
  name = "hqoavhsiacs",
  tags = {Skill.Compulsory,Skill.Switch}
}

Fk:loadTranslationTable{
  ["hqoavhsiacs"] = "媼相",
  [":hqoavhsiacs"] = "輪限1｡輪流發動｡伱體力數變化後,若其➀昜:爲1或2,必發,伱獲得技能｢王宦｣;➁不爲1或2,必發,伱回1,失去｢王宦｣｡",

  -- ["@[:]virtual_skills"] = "虛技",

}
local U = require "packages/utility/utility"
-- local S = require "packages/szyihhsoohssaet/szyih_guos" 



hqoavhsiacs:addEffect(fk.HpChanged, {
  can_trigger = function(self, event, target, player, data)
    if target==player and player:hasSkill(hqoavhsiacs.name) 
    and  player:usedSkillTimes(hqoavhsiacs.name, Player.HistoryRound) == 0   
    then
      if  player:getSwitchSkillState(hqoavhsiacs.name, true)==fk.SwitchYang and (player.hp==1 or player.hp==2) then
        event:setCostData(self,{switch=fk.SwitchYang})
        return true
      elseif player:getSwitchSkillState(hqoavhsiacs.name, true)==fk.SwitchYin and (player.hp~=1 and player.hp~=2) then
        event:setCostData(self,{switch=fk.SwitchYin})
        return true
      end
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    if  event:getCostData(self).switch==fk.SwitchYang then  --昜入侌

      U.SetSwitchSkillState(player, hqoavhsiacs.name, player:getSwitchSkillState(hqoavhsiacs.name, false), {"__", "hzfanskvoan__"})
      -- room:changeMaxHp(player,-1) --,hqoavhsiacs.name
      room:handleAddLoseSkills(player,"quacqhzfans",nil,true,false) --source_skill

    else
      room:recover{
        who = player,
        num = 1 ,
        recoverBy = player,
        skillName = hqoavhsiacs.name,
      }  
      
      U.SetSwitchSkillState(player, hqoavhsiacs.name, player:getSwitchSkillState(hqoavhsiacs.name, false),  {"__", "hzfanskvoan__"})
      -- room:changeMaxHp(player,1) --,hqoavhsiacs.name
      room:handleAddLoseSkills(player,"-quacqhzfans",nil,true,false)
      -- S.handleAddLoseVirtualSkills(player,"-quacqhzfans",hqoavhsiacs.name)
    end
  end,
})


return hqoavhsiacs
