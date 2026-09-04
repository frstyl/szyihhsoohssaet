local ssxiqtsziucs = fk.CreateSkill {
  name = "ssxiqtsziucs",
  tags={Skill.Compulsory}
}

-- local U = require "packages.utility.utility"

Fk:loadTranslationTable{
  ["ssxiqtsziucs"] = "師眾", --游學
  [":ssxiqtsziucs"] = "➀游戲始旹必發,伱選擇1上家1技能(非自限伱未有),伱復刻之➁輪終旹必發,伱与下家交換位,執行➀",

  ["#ssxiqtsziucs-invoke"] = "師眾 選擇1腳色復刻其技能",
  ["#ssxiqtsziucs-skill"] = "師眾 選擇 %src 技能",

  ["$ssxiqtsziucs1"] = "太丘道广，广则不周。仲举性峻，峻则少通。",
  ["$ssxiqtsziucs2"] = "君生淸平则为奸逆，处乱世当居豪雄。",
}

--自帶技能

local S = require "packages/szyihhsoohssaet/szyih_guos"


local spec={
  can_trigger = function (self, event, target, player, data)
    return player:hasSkill(ssxiqtsziucs.name)
  end,
  on_cost = function (self, event, target, player, data)
    event:setCostData(self,{tos={S.getNextOne(player,event==fk.GameStart and -1 or  1)}})
    return true
  end,
  on_use = function (self, event, target, player, data)
    local room=player.room
    local to =event:getCostData(self).tos[1]
    if event==fk.RoundEnd then     room:moveSeatToNext(player, to, false, false) end
    local skills=table.filter(to:getSkillNameList(),function(skill_name)
    return Fk.skills[skill_name] 
    and not  Fk.skills[skill_name]:hasTag(Skill.Proprietary) 
    and not table.contains(player:getSkillNameList()) 
    end)
    if #skills==0 then
      skills={"dzjiskioh","dzjissjin","dzjishsioh"}
    end

     local choice = room:askToChoice(player, {
      choices = skills,
      skill_name = ssxiqtsziucs.name,
      prompt = "#ssxiqtsziucs-skill::" .. to.id,
      detailed = true,
      cancelable=false,
    })
    room:handleAddLoseSkills(player, choice, nil, true, false)
  end,
}
ssxiqtsziucs:addEffect(fk.GameStart, spec)
ssxiqtsziucs:addEffect(fk.RoundEnd, spec)




-- ssxiqtsziucs:addEffect("filter", {
--   skill_filter = function (self, player)
--     if not table.contains(player:getSkillNameList(), ssxiqtsziucs.name) 
--     -- or not  Fk.skills[ssxiqtsziucs.name]:isEffectable(player) 
--     or #player:getMark("@ssxiqtsziucs")==0
--     then return end
--     return player:getMark("@ssxiqtsziucs")
--   end,
-- })

-- local spec={
--   can_trigger = function (self, event, target, player, data)
--     return player:hasSkill(ssxiqtsziucs.name)
--   end,
--   on_cost = function (self, event, target, player, data)
--     local room=player.room
--     local getSkills=function(p)
--     local t={}
--      for _, skill_name in ipairs(p:getSkillNameList())  do
--       if not  Fk.skills[skill_name]:hasTag(Skill.Proprietary) and not table.contains(player:getSkillNameList()) then
--         table.insert(t,skill_name)
--       end
--      end
--      return t
--     end

--     local targets =table.filter(room.alive_players,function(p)return #getSkills(p)>0 end)
--     if #targets== 0 then return end
--     local tos = room:askToChoosePlayers(player, {
--       targets = targets,
--       min_num = 1,
--       max_num = 1,
--       prompt = "#ssxiqtsziucs-invoke",
--       skill_name = ssxiqtsziucs.name,
--     })
--     if #tos > 0 then
--       local choice = room:askToChoice(player, {
--       choices = getSkills(tos[1]),
--       skill_name = ssxiqtsziucs.name,
--       prompt = "#ssxiqtsziucs-skill::" .. tos[1].id,
--       detailed = true,
--     })

--       event:setCostData(self, { tos = tos,choice=choice })
--       return true
--     end
--   end,
--   on_use = function (self, event, target, player, data)
--     local room=player.room
--     room:moveSeatToNext(player, event:getCostData(self).tos[1], false,false)
--     room:handleAddLoseSkills(player, event:getCostData(self).choice, nil, true, false)
--   end,
-- }


-- ssxiqtsziucs:addEffect(fk.StartPlayCard, {  --𢧵
--   priority=0,
--   can_refresh = function (self, event, target, player, data)
--     return     table.contains(player:getSkillNameList(), ssxiqtsziucs.name) 
--     and Fk.skills[ssxiqtsziucs.name]:isEffectable(player) 
--    end,
--   on_refresh = function (self, event, target, player, data) 
--     local t = nil
--     local n =player.hp
--       for _, p in ipairs(Fk:currentRoom().alive_players) do
--       if p.hp>n then
--         t=p
--         n=p.hp
--       elseif p.hp==n then
--         t=nil
--       end
--     end
--     if t==player or t==nil then return end

--     local player_skills=player:getSkillNameList()
--     local skills={}
--     for _, s in ipairs(t:getSkillNameList()) do
--       if  not table.contains(player_skills, s)  then
--         local skill=Fk.skills[s]
--         if skill:isInstanceOf(ActiveSkill) or skill:isInstanceOf(ViewAsSkill) then
--           -- player.room:doBroadcastNotify("AddSkill", {  --不可
--           --   player.id, s,
--           -- })
--           table.insertIfNeed(skills,s)
--         end
--       end
--     end

--     if #skills>0 then 
--       -- table.insert(skills,"Cancel")
--       local room=player.room
--       local skill_name = room:askToChoice(player, {
--         skill_name = "trigger",
--         prompt = "#choose-trigger",
--         choices = skills,
--         cancelable=true,
--       })
--       if skill_name~="Cancel" then 
--        local  yes, dat = room:askToUseActiveSkill(player,{  
--         skill_name = skill_name,
--         -- prompt = "#pujqkiams-choose",
--         cancelable = true,
--         skip = false, 
--         -- extra_data = {
--         --   expand_pile = temp,
--         --   skillName = pujqkiams.name,
--         })
--       if not yes then return end
--       local use_spec = {
--         from = player,
--         cards = dat.cards,
--         tos = dat.targets,
--         interaction_data = dat.interaction
--       }
--       skill:onUse(player.room, use_spec)
--       -- room:useSkill(player,skill_name, function()
--       --   skill:onUse(room, use_data)
--       -- end, use_data))

--       end
--     end

--   end,
-- })


-- local function otherSkills(player)
--       local skills = {}
--       local pSK=player:getSkillNameList()
--       for _, p in ipairs(Fk:currentRoom().players) do
--         if p~=player  then 
--           		for _, s in ipairs(p:getSkillNameList()) do
--                 -- if  not table.contains(pSK, s.name)  then
--                   table.insertIfNeed(skills, s.name)
--                 -- end
--               end
--         end
--       end
--       return skills
-- end

-- ssxiqtsziucs:addEffect("filter", {
--   skill_filter = function (self, player)
--     if player:isNude() then return end
--     if table.contains(player:getSkillNameList(), ssxiqtsziucs.name) and
--       Fk.skills[ssxiqtsziucs.name]:isEffectable(player) 
--     then
--       return otherSkills(player)
--     end
--   end,
-- })

-- ssxiqtsziucs:addEffect(fk.SkillEffect, {  --𢧵
--   priority=9,
--   can_refresh = function (self, event, target, player, data)  --區分技能源 發動源
--     return target == player 
--     and table.contains(otherSkills(player), data.skill:getSkeleton().name) 
--     -- and (not table.contains(player:getSkillNameList(), data.skill:getSkeleton().name) or player.room:askToSkillInvoke(player, { skill_name = ssxiqtsziucs.name })  )
--   end,
--   on_refresh = function (self, event, target, player, data)
--     local room = player.room

--         local cards=room:askToCards(player,{
--           min_num=1,
--           max_num=1,
--           include_equip=false,
--           pattern=tostring(Exppattern{ id = table.filter(player:getCardIds("h"),function(id)
--             return not player:prohibitResponse(Fk:getCardById(id))
--           end
--           ) }),
--           prompt = "#ssxiqtsziucs-discard",
--           cancelable = true,
--         })
--         if #cards==0 then
--           data.prevented=true
--           return  true
--         else
--           S.playCard(cards,ssxiqtsziucs.name,player)
--         end

--   end,
-- })


-- ssxiqtsziucs:addEffect("invalidity", {
--   recheck_invalidity = true,
--   invalidity_func = function (self, from, skill)
--     return not from:hasSkill(ssxiqtsziucs.name) and from:getMark("js_fangke_skills") ~= 0 and
--       table.contains(from:getTableMark("js_fangke_skills"), skill.name)
--   end,
-- })

return ssxiqtsziucs
