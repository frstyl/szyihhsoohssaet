
local doachddio = fk.CreateSkill {
  name = "doachddio",
}

Fk:loadTranslationTable{
  ["doachddio"] = "潒除",
  [":doachddio"] = "伱起動｢｢殺｣｣旹伱可爲此｢殺｣選擇1至多額外目幖發動｡增加所選目幖,此｢殺｣結算終旹,若有目幖:響應,此｢殺｣不計入次數;未響應,伱取得此｢殺｣子牌",
  -- [":doachddio"] = "伱起動｢｢殺｣｣旹伱可爲此｢殺｣指定1至多額外目幖(无視距離),發動｡伱流失1,｡若此｢殺｣未對目幖脚色A致傷,伱1段下1｢殺｣對A无視距離次數",


  ["#doachddio-choose"] = "潒除 爲 %arg 指定額外目幖",

  ["$doachddio1"] = "昰細巧手段如何。",
  ["$doachddio2"] = "粗中有細",
}
doachddio:addEffect(fk.CardUsing, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player 
    and player:hasSkill(doachddio.name) 
    and data.card.trueName=="ssaet"
  end,
  on_cost = function(self, event, target, player, data)
    local room=player.room
    if #data:getExtraTargets({bypass_distances = true, bypass_times=true}) == 0 then  return end
      local tos = room:askToChoosePlayers(player, {
        targets = data:getExtraTargets({bypass_distances = false, bypass_times=true}),
        min_num = 1,
        max_num = 999,
        prompt = "#doachddio-choose:::"..data.card:toLogString(),
        skill_name = doachddio.name,
        cancelable = true,
      })
      if #tos > 0 then
        room:sortByAction(tos)
        event:setCostData(self,{tos=tos})
        return true
      end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    room:loseHp(player,1,doachddio.name)
    local tos = event:getCostData(self).tos
        for _, p in ipairs(tos) do
          data:addTarget(p)
        end
        room:sendLog{
          type = "#AddTargetsBySkill",
          from = player.id,
          to = table.map(tos, Util.IdMapper),
          arg = doachddio.name,
          arg2 = data.card:toLogString(),
        }
      data.extra_data = data.extra_data or {}
      data.extra_data.doachddio={from=player.id,extraUse=false,get=false}

  end,
})

doachddio:addEffect(fk.CardEffectFinished, {
  can_refresh= function (self, event, target, player, data)
    return target == player 
    and data.use
    and data.use.extra_data
    and data.use.extra_data.doachddio
  end,
  on_refresh = function (self, event, target, player, data)
    if not data.use then return end
    if data.cardsResponded ~=data.use.cardsResponded then  --effect繼承use cardsResponded
      data.use.extra_data.doachddio.extraUse=true
    else
      data.use.extra_data.doachddio.get=true
    end
  end
})
doachddio:addEffect(fk.CardUseFinished, {
  can_trigger= function (self, event, target, player, data)
    return target == player 
    and data.extra_data
    and data.extra_data.doachddio
  end,
  on_trigger = function (self, event, target, player, data)
    local room=player.room
    local from=room:getPlayerById(data.extra_data.doachddio.from)

    if data.extra_data.doachddio.extraUse then
      if data.extraUse ~= true then
        from:addCardUseHistory(data.card.trueName, -1)
        data.extraUse = true 
      end
    end
    if data.extra_data.doachddio.get then
      if room:getCardArea(data.card) == Card.Processing then
        room:obtainCard(from, data.card, true, fk.ReasonPrey, from, doachddio.name)
      end
    end
  end,
})

return doachddio


-- doachddio:addEffect(fk.CardUsing, {
--   anim_type = "offensive",
--   can_trigger = function(self, event, target, player, data)
--     return target == player 
--     and player:hasSkill(doachddio.name) 
--     and data.card.trueName=="ssaet"
--   end,
--   on_cost = function(self, event, target, player, data)
--     local room=player.room
--     if #data:getExtraTargets({bypass_distances = true}) == 0 then  return end
--       local tos = room:askToChoosePlayers(player, {
--         targets = data:getExtraTargets({bypass_distances = false}),
--         min_num = 1,
--         max_num = 999,
--         prompt = "#doachddio-choose:::"..data.card:toLogString(),
--         skill_name = doachddio.name,
--         cancelable = true,
--       })
--       if #tos > 0 then
--         room:sortByAction(tos)
--         event:setCostData(self,{tos=tos})
--         return true
--       end
--   end,
--   on_use = function(self, event, target, player, data)
--     local room=player.room
--     room:loseHp(player,1,doachddio.name)
--     local tos = event:getCostData(self).tos
--         for _, p in ipairs(tos) do
--           data:addTarget(p)
--         end
--         room:sendLog{
--           type = "#AddTargetsBySkill",
--           from = player.id,
--           to = table.map(tos, Util.IdMapper),
--           arg = doachddio.name,
--           arg2 = data.card:toLogString(),
--         }

--       room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true):addCleaner(function()
--         for _, p in ipairs(data.tos) do  --
--           if data.damageDealt==nil or data.damageDealt[p]==nil then
--             p:drawCards(1)
--             room:addTableMark(player,"doachddio-phase",p.id)
--           end
--         end
--       end)

--   end,
-- })

-- doachddio:addEffect(fk.PreCardUse, {
--   can_refresh = function (self, event, target, player, data)
--     return target == player 
--     and data.card.trueName=="ssaet"
--     and player:getMark("doachddio-phase")~=0
--   end,
--   on_refresh = function (self, event, target, player, data)
--     for _, p in ipairs(data.tos) do
--       if table.contains(player:getTableMark("doachddio-phase"),p.id) then
--       data.extraUse = true
--       break
--       end
--     end
--     player.room:setPlayerMark(player,"doachddio-phase",0)
--   end
-- })
-- doachddio:addEffect("targetmod", {
--   bypass_times = function(self, player, skill, scope, card,to)
--     if  card and card.trueName == "ssaet" and scope == Player.HistoryPhase and to 
--     and table.contains(player:getTableMark("doachddio-phase"),to.id)
--     then
--       return true
--     end
--   end,
--   bypass_distances = function(self, player, skill, card,to)
--     if  card and card.trueName == "ssaet" and to 
--     and table.contains(player:getTableMark("doachddio-phase"),to.id)
--     then
--       return true
--     end
--   end,
-- })
