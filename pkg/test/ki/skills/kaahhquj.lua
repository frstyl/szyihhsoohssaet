local kaahhquj = fk.CreateSkill {
  name = "kaahhquj",
}

-- local U = require "packages.utility.utility"

Fk:loadTranslationTable{
  ["kaahhquj"] = "假威",
  [":kaahhquj"] = "若有腳色體力全場冣多且不爲伱,伱視爲有其技能(不能發動,止恆續与必發生效)",


  ["$kaahhquj1"] = "太丘道广，广则不周。仲举性峻，峻则少通。",
  ["$kaahhquj2"] = "君生淸平则为奸逆，处乱世当居豪雄。",
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos"



kaahhquj:addEffect("filter", {
  skill_filter = function (self, player)
    if not table.contains(player:getSkillNameList(), kaahhquj.name) 
    or not  Fk.skills[kaahhquj.name]:isEffectable(player) then return end

    local t = nil
    local n =player.hp
      for _, p in ipairs(Fk:currentRoom().alive_players) do
      if p.hp>n then
        t=p
        n=p.hp
      elseif p.hp==n then
        t=nil
      end
    end
    if t==player or t==nil then return end

    local player_skills=player:getSkillNameList()
    local skills={}
    for _, s in ipairs(t:getSkillNameList()) do
      if  not table.contains(player_skills, s) and Fk.skills[s]:hasTag(Skill.Compulsory)  then
        table.insertIfNeed(skills, s)
      end
    end
      return skills
  end,
})

-- kaahhquj:addEffect(fk.StartPlayCard, {  --𢧵
--   priority=0,
--   can_refresh = function (self, event, target, player, data)
--     return     table.contains(player:getSkillNameList(), kaahhquj.name) 
--     and Fk.skills[kaahhquj.name]:isEffectable(player) 
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

-- kaahhquj:addEffect("filter", {
--   skill_filter = function (self, player)
--     if player:isNude() then return end
--     if table.contains(player:getSkillNameList(), kaahhquj.name) and
--       Fk.skills[kaahhquj.name]:isEffectable(player) 
--     then
--       return otherSkills(player)
--     end
--   end,
-- })

-- kaahhquj:addEffect(fk.SkillEffect, {  --𢧵
--   priority=9,
--   can_refresh = function (self, event, target, player, data)  --區分技能源 發動源
--     return target == player 
--     and table.contains(otherSkills(player), data.skill:getSkeleton().name) 
--     -- and (not table.contains(player:getSkillNameList(), data.skill:getSkeleton().name) or player.room:askToSkillInvoke(player, { skill_name = kaahhquj.name })  )
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
--           prompt = "#kaahhquj-discard",
--           cancelable = true,
--         })
--         if #cards==0 then
--           data.prevented=true
--           return  true
--         else
--           S.playCard(cards,kaahhquj.name,player)
--         end

--   end,
-- })


-- kaahhquj:addEffect("invalidity", {
--   recheck_invalidity = true,
--   invalidity_func = function (self, from, skill)
--     return not from:hasSkill(kaahhquj.name) and from:getMark("js_fangke_skills") ~= 0 and
--       table.contains(from:getTableMark("js_fangke_skills"), skill.name)
--   end,
-- })

return kaahhquj
