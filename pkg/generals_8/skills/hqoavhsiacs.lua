local hqoavhsiacs = fk.CreateSkill {
  name = "hqoavhsiacs",
  tags = {Skill.Compulsory,Skill.Switch}
}

Fk:loadTranslationTable{
  ["hqoavhsiacs"] = "媼相",
  [":hqoavhsiacs"] = "鎖定｡轉換｡伱進入瀕死旹必發➀昜:伱將體力回至1,減1體力上限,獲得技能｢王宦｣;➁侌,伱加1體力上限,失去王宦｡",

  -- ["@[:]virtual_skills"] = "虛技",

}
local U = require "packages/utility/utility"
local S = require "packages/szyihhsoohssaet/szyih_guos" 



hqoavhsiacs:addEffect(fk.EnterDying, {
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(hqoavhsiacs.name)
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    if  player:getSwitchSkillState(hqoavhsiacs.name, true)==fk.SwitchYang then  --昜入侌
      room:recover{
        who = player,
        num = 1 - player.hp,
        recoverBy = player,
        skillName = hqoavhsiacs.name,
      }    
      U.SetSwitchSkillState(player, hqoavhsiacs.name, player:getSwitchSkillState(hqoavhsiacs.name, false), {"__", "hzfanskvoan__"})
      room:changeMaxHp(player,-1) --,hqoavhsiacs.name
      room:handleAddLoseSkills(player,"quacqhzfans",nil,true,false) --source_skill
      -- S.handleAddLoseVirtualSkills(player,"quacqhzfans",hqoavhsiacs.name)
    else
      room:recover{
        who = player,
        num = 1 - player.hp,
        recoverBy = player,
        skillName = hqoavhsiacs.name,
      }  
      
      U.SetSwitchSkillState(player, hqoavhsiacs.name, player:getSwitchSkillState(hqoavhsiacs.name, false),  {"__", "hzfanskvoan__"})
      room:changeMaxHp(player,1) --,hqoavhsiacs.name
      room:handleAddLoseSkills(player,"-quacqhzfans",nil,true,false)
      -- S.handleAddLoseVirtualSkills(player,"-quacqhzfans",hqoavhsiacs.name)
    end
  end,
})


return hqoavhsiacs
