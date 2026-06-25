---@class szyih_guos
local szyih_guos = require 'packages/szyihhsoohssaet/_base'


--- invalidataSkillData 技能失效/復效 --參攷handleAddLoseSkills
---@param who ServerPlayer @ 角色
---@param skills table @ 失效技能名
---@param validata_skills table @ 復效技能

---@class szyih_guos.invalidateSkillData: invalidateSkillDataSpec, TriggerData
szyih_guos.invalidateSkillData = TriggerData:subclass("invalidateSkillData")

--- 技能无/有效 TriggerEvent
---@class szyih_guos.invalidateSkill: TriggerEvent
---@field public data szyih_guos.invalidateSkillData
szyih_guos.invalidateSkill = TriggerEvent:subclass("invalidateSkillEvent")

--- 技能失/復效事件前
---@class szyih_guos.PreInvalidateSkill: szyih_guos.invalidateSkill
szyih_guos.PreInvalidateSkill = szyih_guos.invalidateSkill:subclass("szyih_guos.PreInvalidateSkill")



--- 技能失/復效後
---@class szyih_guos.AfterInvalidateSkill: szyih_guos.invalidateSkill
szyih_guos.AfterInvalidateSkill = szyih_guos.invalidateSkill:subclass("szyih_guos.AfterInvalidateSkill")

---@alias invalidateSkillTrigFunc fun(self: TriggerSkill, event: szyih_guos.invalidateSkill,
---  target: ServerPlayer, player: ServerPlayer, data: szyih_guos.invalidateSkillData):any

---@class SkillSkeleton
---@field public addEffect fun(self: SkillSkeleton, key: szyih_guos.invalidateSkill,
---  data: TrigSkelSpec<invalidateSkillTrigFunc>, attr: TrigSkelAttribute?): SkillSkeleton




Fk:loadTranslationTable{
  ["#invalidateSkillBySkill"] = "由于 %arg 的效果， %from 技能 %arg2 失效",
  ["#invalidateSkillBySkillPrevented"] = " %arg 對 %from 技能 %arg2 失效被防止",

  ["#validateSkillBySkill"] = "由于 %arg 的效果， %from 技能 %arg2 復效",
  ["#validateSkillBySkillPrevented"] = " %arg 對 %from 技能 %arg2 復效被防止",
}


---@class invalidateSkill
---@param player ServerPlayer @ 角色  --同旹多角色?
---@param skill_name string|table @ 技能多个 (|)分割 有"+"者恢復  ?需約同旹失效復效 類cardmove?
---@param temp? TempMarkSuffix|"" @ 作用范围，``-round`` ``-turn`` ``-phase``或不填
---@param source_skill? string @ 控制失效与否的技能。（保证不会与其他控制技能互相干扰）
---@param sendlog? boolean @ 是否发送战报，默认发送
---@param no_trigger? boolean @ 是否不触发相关时机

szyih_guos.invalidateSkill = function(player, skill_names, temp, source_skill, sendlog, no_trigger )
  if type(skill_names) == "string" then
    skill_names = skill_names:split("|")
  end
  if #skill_names == 0 then return end
  -- if source==nil then source = "real" end


  local room=Fk:currentRoom()
  local logic = room.logic
  -- local to = player

  local invalidateSkills={}
  local validateSkills={}
  for _, skill in ipairs(skill_names) do
    if string.sub(skill, 1, 1) ~= "+" then
      local actual_skill=skill
        --无技能或已失效 則无旹機(變化),記錄封印層數
      if  
        Fk.skills[actual_skill] 
      and (player:hasSkill(actual_skill,true,true) 
      and not Fk.skills[actual_skill]:isEffectable(player) ) 
      then
        table.insertIfNeed(validateSkills,actual_skill)

      end 

    else
      local actual_skill = string.sub(skill, 2, #skill)
      if  player:hasSkill(actual_skill) then
        table.insertIfNeed(invalidateSkills,actual_skill)
      end

    end
  end


  local invalidateSkillData={
    who=player,
    skills = invalidateSkills,
    validata_skills = validateSkills,
    source_skill=source_skill,
    temp=temp,
  }
  if not no_trigger then
    logic:trigger(szyih_guos.PreInvalidateSkill, player, invalidateSkillData)
  end


  for _, skill in ipairs(invalidateSkillData.skills) do
    room:invalidateSkill(player, skill, temp, source_skill)
  end
  for _, skill in ipairs(invalidateSkillData.validata_skills) do
    room:validateSkill(player, skill, temp, source_skill)
  end

  if not no_trigger then
    logic:trigger(szyih_guos.AfterInvalidateSkill, player, invalidateSkillData)  --CancellOut
  end

  if sendlog~=false then
    for _, skill in ipairs(invalidateSkillData.skills) do
      room:sendLog { type = "#invalidateSkillBySkill", from = player.id , arg=source_skill or "unknown", arg2 = skill}
    end
    for _, skill in ipairs(invalidateSkillData.validata_skills) do
      room:sendLog { type = "#invalidateSkillBySkillPrevented", from = player.id , arg=source_skill or "unknown", arg2 = skill}
    end
  end
  
end

szyih_guos.invalidateUncompulsorySkill = function(player, temp, source_skill, sendlog, no_trigger)  --防止後如何計數?
    local skills={}
    for _, s in ipairs(player.player_skills) do
      if s:isPlayerSkill(player) and not s:hasTag(Skill.Compulsory) then
        table.insertIfNeed(skills, s.name)
      end
    end

    szyih_guos.invalidateSkill(player,skills,temp,source_skill,sendlog,no_trigger)

end

szyih_guos.validateAllSkill = function(player, temp, source_skill, sendlog, no_trigger)  --caesar同理 狀態如何否決--區別類似得某技能与視爲有某技能

end