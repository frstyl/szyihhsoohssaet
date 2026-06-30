local cardSkill = fk.CreateSkill {
  name = "buac_hzfan_mujs_nzjen_skill",
}

Fk:loadTranslationTable{
  -- ["#AskForbuac_hzfan_mujs_nzjen"] = "是否對目幖爲 %dest 之｢%arg｣ 使用 防患未肰？",
  ["#AskForbuac_hzfan_mujs_nzjen"] = " %src 對 %dest 使用｢%arg｣ 將生效, 是否使用 ｢%arg2｣ ？",
  ["#AskForbuac_hzfan_mujs_nzjenWithoutTo"] = " %src 使用｢%arg｣ 將生效, 是否使用 ｢%arg2｣ ？",
  ["#AskForbuac_hzfan_mujs_nzjenWithoutFrom"] = "目幖爲 %dest 之 ｢%arg｣ 將生效, 是否使用 ｢%arg2｣ ？",

  ["#AskForbuac_hzfan_mujs_nzjen-multi"] = " %src 對 %dest 使用｢%arg｣ 將生效, 是否使用 ｢%arg2｣ ？（第 %arg3 张，共需 %arg4）",
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

cardSkill:addEffect(fk.PreCardEffect, { --以可用之牌分  ---HandleAskForPlayCard
  -- global = true,
  mute = true,
  priority = 0,  --同旹自選 用牌?
  can_trigger = function(self, event, target, player, data)  --禁使用(牌名)/抵消/響應
    if player.seat~=1 then return end --問一次
  
    if  data.isCancellOut or data.nullified then return end  --与水攻誰先?


    local cardNames={}
    if S.getCardTypeByName(data.card.trueName) ==2    then 
      cardNames={"buac_hzfan_mujs_nzjen"}
      if  data.tos==nil or #data.tos==0 or (data.to and data:isOnlyTarget(data.to) )then 
        table.insert(cardNames,"tsiac_keejs_dzius_keejs")  
      end
    elseif data.card.trueName == "ssaet" then
      cardNames = {"szjemh", "theem_prac_kaemh_tsoavs",}
    end

    for _, name in ipairs(data.prohibitedCardNames or {}) do  --此旹機加入??
      table.removeOne(cardNames,name)
    end
    if #cardNames==0 then return end

    local players=table.filter(player.room.alive_players,function(p)
        return not data:isUnoffsetable(p)  and not data:isDisresponsive(p) 
      end)
    if #players==0 then return end



    event:setCostData(self,{players=players,cardNames=cardNames})
    return true    
  end,
  on_trigger = function(self, event, target, player, data) --問何問
    local room=player.room
    local players=event:getCostData(self).players
    local cardNames=event:getCostData(self).cardNames
    local holders={} --不等于players
    -- local loopTimes = data:getResponseTimes()

    -- for i = 1, loopTimes do
    local pattern=""
    local expand={}  --展開 koarbiuk
    local s_params={}  --單獨設 params

    local prompt = ""

          -- -- local e_params={}
    -- for _, p in ipairs(holders) do
    --   expand[p.id]=S.getPlayerKoarbiukCards({p},"tsiac_keejs_dzius_keejs")
    -- end
    -- if data:isOnlyTarget(data.to) then
    --   s_params[data.to.id]=table.simpleClone(params)
    --   s_params[data.to.id].pattern=table.concat({pattern,"tsiac_keejs_dzius_keejs"},";")
    -- end
    local setPattern=function()
      local t={}
      local trueNames={}  --眞名
      local names={}  --名, 如hand 无需葢
      local koarNames={}  --葢
      local targetNames={}  --目幖可自手牌用 同trueNames
      for _, name in ipairs(cardNames) do  --轉爲trueName ids
        -- if name=="buac_hzfan_mujs_nzjen" then
        --   table.insert(trueNames,name)
        -- elseif name=="szjemh" then
        --   -- table.insert(names,"hzoos__szjemh")
        --   table.insert(names,"hand__szjemh")
        -- elseif table.contains({"tsiac_keejs_dzius_keejs", "theem_prac_kaemh_tsoavs",},name) then
        if table.contains({"szjemh", "buac_hzfan_mujs_nzjen", "theem_prac_kaemh_tsoavs",}, name) then  --合并? 与trueNames一起
          table.insert(names,"hand__"..name)
          table.insert(koarNames,name)
          table.insert(targetNames,name)
        elseif table.contains({"tsiac_keejs_dzius_keejs",}, name) then
          table.insert(names,"hand__"..name)
          table.insert(koarNames,name)
        end
      end


      if #trueNames>0 then  --未禁展開牌, 葢牌不應展開不合旹者
        local tp=tostring(Exppattern{ trueName = trueNames })
        table.insert(t,tp)
        holders=S.getHolders(tp,players,fk.ReasonUse,nil, data) 
      end

      if #names>0 then
        local tp=tostring(Exppattern{ name = names })
        table.insert(t,tp)
        table.insertTableIfNeed(holders, S.getHolders(tp,players,fk.ReasonUse,nil,data) )
      end

      if  #koarNames>0  then
          local tp=tostring(Exppattern{ trueName = koarNames })
          ids = {}
          for _, p in ipairs(players) do
            local cs= S.getPlayerKoarbiukCards({p},tp)  
            if #cs>0 then
              expand[p.id]= cs --askToUseKoarbiukCard  中搜索展開?
              table.insertIfNeed(holders,p)
              table.insertTableIfNeed(ids, cs)
            end
          end
          if #ids >0 then
            table.insert(t,tostring(Exppattern{ id = ids }))
          end

          -- local ids,ps =S.getPlayerKoarbiukCards(players,tp)
          -- if #ids>0 then
          --           table.insert(t,tp)
          --           -- table.insert(t,tostring(Exppattern{ id = ids }))
            
          --   -- local ps=S.getHolders("tsiac_keejs_dzius_keejs",players,fk.ReasonUse,"k") 
          --   for _, p in ipairs(ps) do
          --     expand[p.id]=S.getPlayerKoarbiukCards({p},tp)  --askToUseKoarbiukCard  中搜索展開?
          --     table.insertIfNeed(holders,p)
          --   end
          -- end
      end


      pattern = table.concat(t,";")
      Fk.currentResponsePattern = pattern --?有用?


      if  #targetNames>0 and data.to then  --hand__
        local tp= table.concat(targetNames,";") --tostring(Exppattern{ trueName = ms })

        -- if #S.getHolders(tp,{data.to},fk.ReasonUse,nil,data)~=1 then return end

        table.insertIfNeed(holders,data.to)
        s_params[data.to.id]=s_params[data.to.id] or {}
        -- s_params[data.to.id][pattern] = "."
        s_params[data.to.id].pattern =table.concat({tp,t[1]},";")
        -- s_params[data.to.id][prompt] = "#ssaet-szjemh:" .. data.from.id
      end


    end

    local setPrompt = function(loopTimes,i)
      if not data.from then return end
      if loopTimes == 1 then
        if data.from and data.to then
          prompt = "#AskForbuac_hzfan_mujs_nzjen:" .. data.from.id ..":" .. data.to.id .. ":" .. data.card:toLogString() .. ":" .. cardNames[1]
        elseif data.from  then
          prompt = "#AskForbuac_hzfan_mujs_nzjenWithoutTo:" .. data.from.id .. "::" .. data.card:toLogString() .. ":" .. cardNames[1]
        else
          prompt = "#AskForbuac_hzfan_mujs_nzjenWithoutFrom::" .. data.to.id .. "::" .. data.card:toLogString() .. ":" .. cardNames[1]
        end
      else
        if data.from  and data.to then
          prompt = "#AskForbuac_hzfan_mujs_nzjen-multi:" .. data.from.id ..":" .. data.to.id .. ":" .. data.card:toLogString() .. ":" .. cardNames[1] .. "::" .. i .. ":" .. loopTimes
        end
      end
    end


    local loopTimes = data:getResponseTimes() or 1--暫止有閃
    local i=1
    while true do
      setPattern()
      -- if #holders==0 then return end  --能響應无牌 發旹機
      if  table.contains({ "buac_hzfan_mujs_nzjen" ,"tsiac_keejs_dzius_keejs"}, data.card.trueName) then
        player.room:animDelay(2)
      end
      setPrompt(loopTimes,i)

      local extra_data = { effectCardId = data.card.id  }
      if #data.tos > 1 then
        if data.use then  --
          extra_data.useEventId = data.use.id
          extra_data.effectTo = data.to.id
        end
      end
      local params = { ---@type AskToUseCardParams
        pattern = pattern,
        skill_name = "buac_hzfan_mujs_nzjen",
        prompt = prompt,
        cancelable = true,
        extra_data = extra_data,
        event_data = data
      }

      local use = S.askToUseKoarbiukCard(room,holders, params,s_params,expand)
      if not use then return end 

      use.toCard = data.card  --皆有
      use.responseToEvent = data
      room:useCard(use)

    if use.card.trueName=="szjemh" and data.isCancellOut == true then
        data.isCancellOut = i == loopTimes 
        if  data.isCancellOut then
          return
        end
        i=i+1
        cardNames={"szjemh"}
      else
        return
      end

    if data.isCancellOut or data.nullified then return end  --copy
    for _, name in ipairs(data.prohibitedCardNames or {}) do
      table.removeOne(cardNames,name)
    end
    if #cardNames==0 then return end

    players=table.filter(players,function(p)
        return not data:isUnoffsetable(p)  and not data:isDisresponsive(p) 
      end)
    if #players==0 then return end




    end
  end,
})

return cardSkill
