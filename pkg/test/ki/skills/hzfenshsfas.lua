local hzfenshsfas = fk.CreateSkill {
  name = "hzfenshsfas",
  tags={Skill.NotViewAs},
}

Fk:loadTranslationTable{
["hzfenshsfas"] = "㕕化",
[":hzfenshsfas"] = "伱可因A起動演練(虛无色无點无屬){肉/閃/殺/酒}旹B,伱可發動.伱占卜,若占卜牌爲{<font color='red'>♥</font>/<font color='red'>♦</font>/♣/♠},視爲伱于B旹機起動之｡",
-- [":hzfenshsfas"] = "印牌:起動演練虛擬{肉/閃/殺/酒}｡起動前伱占卜,若占卜牌不爲{<font color='red'>♥</font>/<font color='red'>♦</font>/♣/♠},防止起動｡每問牌事件每牌名限1次",

["#hzfenshsfas"] = "㕕化:  占卜 若占卜牌无花色或花色非紅桃 視若伱起動演練殺",
}

hzfenshsfas:addEffect("viewas", {
  anim_type = "offensive",
  pattern = ".|.|.|.|ssaet,szjemh,tsiuh,nziuk",  --
  prompt = "#hzfenshsfas",
  -- mute_card = true,
  interaction = function(self, player)
    local all_names = {"ssaet", "szjemh", "nziuk", "tsiuh"}
    local names = player:getViewAsCardNames(hzfenshsfas.name, all_names)
    -- local t=player:getTableMark("hzfenshsfas-phase") or {}
    -- names = table.filter(names,function(name)
    --   return not table.contains(t,name)
    -- end)
    return  UI.CardNameBox {choices =  names, all_choices = all_names }
    -- return UI.CardNameBox {choices = all_names, all_choices = all_names }
  end,
  card_filter = Util.FalseFunc,
  view_as = function(self, player, cards)
    if not self.interaction.data then return nil end
    local c = Fk:cloneCard(self.interaction.data)
    c.skillName = hzfenshsfas.name
    -- player.room:setCardArea(c.id,Card.PlayerHand, player.id)
    return c
  end,
  -- before_use = function (self, player, use)
  --   local room = player.room

  --   local event=room.logic:getCurrentEvent().parent  --某牌可于一事件多旹機用??  --getCurrentEvent爲技能
  --   event.data.extra_data=event.data.extra_data or {}
  --   event.data.extra_data.hzfenshsfas=event.data.extra_data.hzfenshsfas or {}
  --   event.data.extra_data.hzfenshsfas[player.id] =event.data.extra_data.hzfenshsfas[player.id] or{}
  --   table.insertIfNeed(event.data.extra_data.hzfenshsfas[player.id], use.card.trueName)
    
  --   local map={ ["ssaet"]="club",
  --               ["tsiuh"]="spade",
  --               ["nziuk"]="heart",
  --               ["szjemh"]="diamond"}
  --   local judgeData = {
  --     who = player,
  --     reason = hzfenshsfas.name,
  --     pattern = ".|.|"..map[use.card.trueName],
  --   }
  --   room:judge(judgeData)
  --   if not judgeData:matchPattern() then 
  --     -- room:invalidateSkill(player, hzfenshsfas.name,"-turn")  --待改
  --     return  hzfenshsfas.name  --多牌名可用?
  --   end
  --   -- player.room:addTableMarkIfNeed(player,"hzfenshsfas-phase",use.card.trueName)

  -- end,
  enabled_at_play = function(self, player)
    -- return true
    return player:usedEffectTimes(hzfenshsfas.name, Player.HistoryPhase) == 0
  end,
  enabled_at_response = function(self, player, response)  --終止旹機/流程條件 爲  --每旹機(用牌元因如瀕死)限1次
    return true --not response
  end,
})

-- hzfenshsfas:addEffect(fk.HandleAskForPlayCard, {  --問牌非事件 --連續多次問牌合爲1事件
--   mute = true,
--   can_refresh = function(self, event, target, player, data)
--     return player:hasSkill(hzfenshsfas.name)
--   end,
--   on_refresh = function(self, event, target, player, data)
--     local room = player.room
--     if  data.afterRequest then
--       --不需淸理
--     else
--       -- player:drawCards(2)
--       local t={}
--       local event=Fk:currentRoom().logic:getCurrentEvent()
--       if event 
--       and event.data 
--       and event.data.extra_data 
--       and  event.data.extra_data.hzfenshsfas 
--       and  event.data.extra_data.hzfenshsfas[player.id] 
--       then
--         room:setPlayerMark(player,"hzfenshsfas-phase", event.data.extra_data.hzfenshsfas[player.id])
--       end
--     end
--   end,
-- })

-- hzfenshsfas:addEffect(fk.StartPlayCard, {  --主旹
--   mute = true,
--   can_refresh = function(self, event, target, player, data)
--     return target==player  and  player:hasSkill(hzfenshsfas.name)
--   end,
--   on_refresh = function(self, event, target, player, data)
--     local room = player.room

--       local t={}
--       local event=Fk:currentRoom().logic:getCurrentEvent()
--       if event 
--       and event.data 
--       and event.data.extra_data 
--       and  event.data.extra_data.hzfenshsfas 
--       and  event.data.extra_data.hzfenshsfas[player.id] 
--       then
--               player:drawCards(5)
--         room:setPlayerMark(player,"hzfenshsfas-phase", event.data.extra_data.hzfenshsfas[player.id])
--       end
    
--   end,
-- })
return hzfenshsfas
