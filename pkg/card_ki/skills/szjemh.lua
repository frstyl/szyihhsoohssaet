local cardSkill = fk.CreateSkill {
  name = "szjemh_skill",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  can_use = Util.FalseFunc,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    if effect.responseToEvent  then
      effect.responseToEvent.isCancellOut = true
    end
  end,
})

cardSkill:addEffect(fk.CardEffectCancelledOut, {
  -- global = true,
  mute = true,
  priority = 0,  --同旹自選 用牌?
  can_trigger = function(self, event, target, player, data)
    return data.isCancellOut and data.extra_data and data.extra_data.antiCancel
  end,
  on_trigger = function(self, event, target, player, data)
    data.isCancellOut=false
  end,
})

-- cardSkill:addEffect(fk.PreCardEffect, { --以可用之牌分
--   -- global = true,
--   mute = true,
--   priority = 0,  --同旹自選 用牌?
--   can_trigger = function(self, event, target, player, data)
--     -- if player.seat~= 1 then return end
--     if player~=data.to then return end
--     if  data:isDisresponsive(data.to)  then return end

--     local cardNames={}
--     if not data.isCancellOut  and not data.nullified  and not data:isUnoffsetable(data.to) then  
--       if  data.card.trueName == "ssaet" then
--           cardNames = {"szjemh","theem_prac_kaemh_tsoavs"}  --,"theem_prac_kaemh_tsoavs"

--       -- elseif S.getCardTypeByName(data.card.name) ==2 then  --加速
--       --     if (data:isOnlyTarget(data.to) ) --data.to
--       --         and ( data.prohibitedCardNames==nil or not table.contains(data.prohibitedCardNames,"tsiac_keejs_dzius_keejs") )
--       --         and #S.getHolders("tsiac_keejs_dzius_keejs",{data.to})==1
--       --     then
--       --       event:setCostData(self,{cardNames={"tsiac_keejs_dzius_keejs"}})
--       --       return true
--       --     end   
--       end
--     end

--     if  data.card.trueName == "ssaet"  then
--       table.insert(cardNames, "ssaet")
--     end
--     for _, name in ipairs(data.prohibitedCardNames or {}) do
--       table.removeOne(cardNames,name)
--     end

--     if  #cardNames==0 then return end
    
--     if #S.getPlayerKoarbiukCards(data.to)==0 then --應在ask中
--       if not table.contains(cardNames,"szjemh") then return end
--     end


--     event:setCostData(self,{cardNames=cardNames})
--     return true
--   end,
--   on_trigger = function(self, event, target, player, data)
--     local room=player.room
--     local to = data.to
--     local cardNames=event:getCostData(self).cardNames
--     local pattern=""

--     -- if cardNames[1]=="tsiac_keejs_dzius_keejs" then
--     --   local prompt =   "#AskForNullification::" .. data.to.id .. ":" .. data.card.name
--     --   local params = { ---@type AskToUseCardParams
--     --     pattern = "tsiac_keejs_dzius_keejs",
--     --     skill_name = "tsiac_keejs_dzius_keejs",
--     --     prompt = prompt,
--     --     cancelable = true,
--     --     event_data = data
--     --   }
--     --   local use = room:askToUseCard(data.to, params)
--     --   if use then
--     --     use.responseToEvent = data
--     --     room:useCard(use)
--     --   else
--     --     return
--     --   end
--     -- end

--     -- local expand ={}
--     local setPattern =function()

--       local tns={}--trueName
--       local ims ={}  --id
--       local ns={}
--       for _, name in ipairs(cardNames) do
--         if name=="szjemh" then
--           table.insert(tns,name)
--         elseif name=="ssaet" then 
--           -- table.insert(ns,"ambush__ssaet")
--           table.insert(ims,"ambush__ssaet")
--         elseif name=="theem_prac_kaemh_tsoavs" then
--           table.insert(tns,name)
--         end
--       end
--       -- if table.contains(cardNames,"tsiac_keejs_dzius_keejs") then  --不含葢牌??
--       --   t={"tsiac_keejs_dzius_keejs"}
--       -- else
--       --   if table.contains(cardNames,"szjemh") then
--       --     t={"szjemh"}
--       --   end
--       --   if table.contains(cardNames,"ssaet") then
--       --     local ids =S.getPlayerKoarbiukCards(to,"theem_prac_kaemh_tsoavs")
--       --     table.insert(t,tostring(Exppattern{ id = ids }))
--       --   end
--       --   if table.contains(cardNames,"theem_prac_kaemh_tsoavs") then
--       --       local ids=S.getPlayerKoarbiukCards(to,"theem_prac_kaemh_tsoavs")
--       --     table.insert(t,tostring(Exppattern{ id = ids }))
--       --   end 

--       -- end
--       local t={}
--       if #ims>0 then
--         local ids =S.getPlayerKoarbiukCards(to,table.concat(ims,","))
--         if #ids>0 then
--           table.insert(t,tostring(Exppattern{ id = ids }))
--         end
--       end
--       if #ns>0 then
--         local tp=tostring(Exppattern{ name = ns })
--         table.insert(t,tp)
--       end
--       if #tns>0 then
--         table.insert(t,table.concat(tns,","))
--       end
--       -- return t
--       pattern = table.concat(t,";")
--     end



--     local loopTimes = data:getResponseTimes() --暫止有閃
--     local i=1
--     while true do

--       local prompt = ""
--       if data.from then
--         if loopTimes == 1 then
--           prompt = "#ssaet-szjemh:" .. data.from.id
--         else
--           prompt = "#ssaet-szjemh-multi:" .. data.from.id .. "::" .. i .. ":" .. loopTimes
--         end
--       end
--       setPattern()

--       Fk.currentResponsePattern = pattern --?有用? 
--       local params = { ---@type AskToUseCardParams
--         pattern = pattern,
--         skill_name = "szjemh",
--         prompt = prompt,
--         cancelable = true,
--         event_data = data,
--         extra_data = {
--           exclusive_targets = {data.from.id},
--           bypass_distances = true,
--           bypass_times = false,
--           extraUse = false,
--           -- ssaet={data.from.id},
--         }
--       }
--       local expand={}
--       expand[player.id]=S.getPlayerKoarbiukCards({to},"theem_prac_kaemh_tsoavs;.|.|.|.|ambush__ssaet")
--       local use = S.askToUseKoarbiukCard(room,to, params,nil,expand,nil)  --葢閃?
--       if use then
--         use.toCard = use.card.trueName~="ssaet" and  data.card or nil
--         use.responseToEvent = data
--         room:useCard(use)
--       else
--         return
--       end

--       if use.card.trueName=="szjemh" and data.isCancellOut == true then
--         data.isCancellOut = i == loopTimes 
--         i=i+1
--       else
--         table.removeOne(cardNames,use.card.trueName)
--       end
--       if  data.isCancellOut then
--         table.removeOne(cardNames,"szjemh")
--         table.removeOne(cardNames,"theem_prac_kaemh_tsoavs")
--       end


--       if #cardNames==0 then return end
      
--       if #S.getPlayerKoarbiukCards(data.to)==0 then
--         if not table.contains(cardNames,"szjemh") then return end
--       end

--     end
--   end,
-- })

return cardSkill
