local hzfacqsoavh = fk.CreateSkill {
  name = "hzfacqsoavh",
  -- tags = { Skill.Compulsory },
}
Fk:loadTranslationTable{
  ["hzfacqsoavh"] = "橫掃",
  [":hzfacqsoavh"] = "伱聲明｢殺｣目幖旹,若唯一,伱可發動｡增加目幖上下家爲目幖(除距離需合理),伱自全部目幖隱祕選擇1腳色A,若{A未/除A目幖}起動｢閃｣抵消此殺,此殺生效次數改爲2且伱結算終旹流失1體力,｡此殺結算期間,目幖｢閃｣視爲護｢閃｣｡",
--隱祕
  ["#hzfacqsoavh-choose"] = "橫掃 選擇目幖",
  -- ["#hzfacqsoavh-invoke2"] = "橫掃 選擇額外目幖 不選目幖确定額外結算 或不發動",

  -- ["#hzfacqsoavh-invoke"] = "橫掃：是否令其他目标脚色选择代替你起動【闪】？",
  -- ["#hzfacqsoavh-ask"] = "橫掃：你可以替 %src 起動【闪】",

  ["#hzfacqsoavh-target"] = "%from  橫掃 目幖爲 %to",

  ["$hzfacqsoavh1"] = "一對白龍爭上下",
  ["$hzfacqsoavh2"] = "董一撞在此",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

-- hzfacqsoavh:addEffect(fk.PreCardUse, {
--   anim_type = "offensive",
--   can_trigger = function(self, event, target, player, data)
--     return target == player and player:hasSkill(hzfacqsoavh.name) and data.card.trueName == "ssaet" and
--       #data:getExtraTargets() > 0
--   end,
--   on_cost = function(self, event, target, player, data)
--     local room = player.room
--     local tos = room:askToChoosePlayers(player, {
--       min_num = 1,
--       max_num = 1,
--       targets = data:getExtraTargets(),
--       skill_name = hzfacqsoavh.name,
--       prompt = "#hzfacqsoavh-choose:::"..data.card:toLogString(),
--       cancelable = true,
--     })
--     if #tos > 0 then
--       event:setCostData(self, {tos = tos})
--       return true
--     end
--   end,
--   on_use = function(self, event, target, player, data)
--     for _, p in ipairs(event:getCostData(self).tos) do
--       data:addTarget(p)
--     end
--     data.extra_data = data.extra_data or {}
--     data.extra_data.hzfacqsoavh = true
--   end,
-- })

hzfacqsoavh:addEffect(fk.AfterCardTargetDeclared, {  --記錄additionalEffect 首輪
  -- mute=true,
  no_indicate=true,
  can_trigger= function(self, event, target, player, data)
    return  data.from == player  and player:hasSkill(hzfacqsoavh.name) and data.card.trueName=="ssaet"
    and #table.filter(data.tos,function(p) return not p.dead end)  == 1  --應有function hasOnlyTarget
  end,
  on_cost= function(self, event, target, player, data)
    local to=table.filter(data.tos,function(p) return not p.dead end)[1]

    if player.room:askToSkillInvoke(player, { skill_name = hzfacqsoavh.name }) then 
      event:setCostData(self,{tos={to}})  --寫于此?
      return true
    end
  end,
  on_use= function(self, event, target, player, data)
    local room=player.room
    local targets=data:getExtraTargets({bypass_distances = true})
    local to=event:getCostData(self).tos[1]
    local temp =S.getNeighbor(to)
    for _, p in ipairs(temp) do
      if table.contains(targets,p) then
        data:addTarget(p)
      end
    end

    local tos = player.room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = data.tos,
      skill_name = hzfacqsoavh.name,
      prompt = "#hzfacqsoavh-choose",
      cancelable = false,
    })

    data.extra_data =  data.extra_data or {}
    -- data.extra_data.hzfacqsoavh={max_additionalEffect=data.additionalEffect or 0,can_use=true,}
    data.extra_data.hzfacqsoavh=tos[1].id
    data.extra_data.hzfacqsoavh_times=0
    data.extra_data.hzfacqsoavh_from=player
    -- data.extra_data.hzfacqsoavh_to=tos[1].id

    for _, p in ipairs(data.tos) do 
      player.room:addPlayerMark(p,"@hzfacqsoavh-viewAs",1)
    end
    data.extra_data.hzfacqsoavh_clear=table.simpleClone(data.tos)


  end,
})


-- hzfacqsoavh:addEffect(fk.CardEffectCancelledOut, {  --記錄additionalEffect 首輪
--   anim_type = "offensive",
--   can_refresh = function(self, event, target, player, data)
--     return  target==player   --多次刷新?
--     and data.cardsResponded[1].trueName=="szjemh" and data.card.trueName=="ssaet"
--     and data.use.extra_data 
--     and data.use.extra_data.hzfacqsoavh
--     and data.use.extra_data.hzfacqsoavh == data.to
--     -- and data.use.extra_data.hzfacqsoavh.max_additionalEffect== data.use.additionalEffect
--   end,
--   on_refresh = function(self, event, target, player, data)
--     -- data.use.extra_data.hzfacqsoavh.can_use=false
--     data.use.extra_data.hzfacqsoavh=nil
--   end,
-- })
hzfacqsoavh:addEffect(fk.PreCardEffect, {
  can_trigger = function(self, event, target, player, data)
    return 
        player.seat==1
        and
      data.extra_data and data.extra_data.hzfacqsoavh_clear 
    and data.use.effectTimes >= data.use.extra_data.hzfacqsoavh_times
  end,
  on_trigger = function(self, event, target, player, data)
    data.use.extra_data.hzfacqsoavh_times=data.use.extra_data.hzfacqsoavh_times+1
    player.room:loseHp(data.extra_data.hzfacqsoavh_from,1,hzfacqsoavh.name,data.extra_data.hzfacqsoavh_from)
    if data.use.effectTimes==1 then
      player.room:sendLog{
        type = "#hzfacqsoavh-target",
        from = data.extra_data.hzfacqsoavh_from.id,
        to={data.extra_data.hzfacqsoavh},
      }

    end
  end,
})

hzfacqsoavh:addEffect(fk.CardEffectFinished, {--CardEffectFinished  --末目幖 tos已排序
  anim_type = "offensive",
  can_refresh = function(self, event, target, player, data)
    return
    data.use.extra_data 
    and data.use.extra_data.hzfacqsoavh
    and data.use.effectTimes==0
    and not data.use.extra_data.hzfacqsoavh_trigger
  end,
  on_refresh = function(self, event, target, player, data)
      if (data.isCancellOut and data.to.id~= data.use.extra_data.hzfacqsoavh
      and data.cardsResponded[#data.cardsResponded].trueName=="szjemh")
      or ( data.to.id == data.use.extra_data.hzfacqsoavh
      and not( data.isCancellOut and data.cardsResponded[#data.cardsResponded].trueName=="szjemh"))
      then
        data.use.extra_data.hzfacqsoavh_trigger=true
        data.use.additionalEffect = (data.use.additionalEffect or 0) +1  --必于終旹執行
      end

  end,
})

-- hzfacqsoavh:addEffect(fk.PreCardEffect, { --sendLog  不對 察不到結算輪數 onAction?
--   anim_type = "offensive",
--   can_refresh = function(self, event, target, player, data)
--     return data.use.extra_data and data.use.extra_data.hzfacqsoavh==false
--   end,
--   on_refresh = function(self, event, target, player, data)
--     player.room:sendLog{
--     type = "#hzfacqsoavh-target",
--     from = data.from.id,
--     tos={data.use.extra_data.hzfacqsoavh}
--   }
--     data.use.extra_data.hzfacqsoavh=nil
--   end,
-- })


hzfacqsoavh:addEffect(fk.CardUseFinished, {
  anim_type = "offensive",
  late_refresh=true,
  can_refresh = function(self, event, target, player, data)
    return data.extra_data and data.extra_data.hzfacqsoavh_clear
  end,
  on_refresh = function(self, event, target, player, data)
    local room=player.room
    for _, p in ipairs(data.extra_data.hzfacqsoavh_clear) do  --目幖變?
      room:removePlayerMark(p,"@hzfacqsoavh-viewAs",1)
    end
    -- player.room:sendLog{
    --   type = "#hzfacqsoavh-target",
    --   from = data.from.id,
    --   to=
    -- }
    data.extra_data.hzfacqsoavh_clear=nil

  end,
})
-- hzfacqsoavh:addEffect(fk.HandleAskForPlayCard, {
--   mute = true,
--   is_delay_effect = true,
--   can_refresh = function(self, event, target, player, data)
--     if player.seat==1 and data.extraData then
--       -- player:drawCards(4)
--       return true
--     end
--   end,
--   on_refresh = function(self, event, target, player, data)
--     local room = player.room
--     if data.afterRequest then
--       for _, p in ipairs(room.players) do --防中途變目幖
--         room:setPlayerMark(p,"@hzfacqsoavh-viewAs",nil)
--       end
--     else
--       for _, p in ipairs(data.eventData.tos) do 
--         room:setPlayerMark(p,"@hzfacqsoavh-viewAs",1)
--       end
--     end
--   end,
-- })

hzfacqsoavh:addEffect("filter", {  --如何令其它印牌變hand__
  card_filter = function(self, to_select, player)
    return player:hasMark("@hzfacqsoavh-viewAs") and to_select.trueName=="szjemh"
  end,
  view_as = function(self, player, to_select)
    local card = Fk:cloneCard("hand__szjemh", to_select.suit, to_select.number)
    card.skillName = hzfacqsoavh.name
    return card
  end,
})
-- hzfacqsoavh:addEffect(fk.AskForCardUse, {
--   mute = true,
--   is_delay_effect = true,
--   can_trigger = function(self, event, target, player, data)
--     if target == player and
--       Exppattern:Parse(data.pattern):matchExp("szjemh") and
--       (data.extraData == nil or data.extraData.hzfacqsoavh_ask == nil) then
--       local e = player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard)
--       if e then
--         local use = e.data
--         if use.card.trueName == "ssaet" and use.extra_data and use.extra_data.hzfacqsoavh then
--           local targets =  table.filter(use.tos, function (p)
--             return p ~= player and not p.dead
--           end)
--           if #targets > 0 then
--             event:setCostData(self, {tos = targets})
--             return true
--           end
--         end
--       end
--     end
--   end,
--   on_cost = function(self, event, target, player, data)
--     local room = player.room
--     if room:askToSkillInvoke(player, {
--       skill_name = "hzfacqsoavh",
--       prompt = "#hzfacqsoavh-invoke",
--     }) then
--       local tos = event:getCostData(self).tos
--       room:sortByAction(tos)
--       event:setCostData(self, {tos = tos})
--       return true
--     end
--   end,
--   on_use = function(self, event, target, player, data)
--     local room = player.room
--     for _, p in ipairs(event:getCostData(self).tos) do
--       if not p.dead then
--         local respond = room:askToResponse(p, {
--           skill_name = "szjemh",
--           pattern = "szjemh",
--           prompt = "#hzfacqsoavh-ask:" .. player.id,
--           cancelable = true,
--           extra_data = {
--             hzfacqsoavh_ask = true,
--           },
--         })
--         if respond then
--           respond.skipDrop = true
--           room:responseCard(respond)

--           local new_card = Fk:cloneCard("szjemh")
--           new_card.skillName = hzfacqsoavh.name
--           new_card:addSubcards(room:getSubcardsByRule(respond.card, { Card.Processing }))
-- 		  S.mixCard(new_card)
--           data.result = {
--             from = player,
--             card = new_card,
--             tos = {},
--           }
--           return true
--         end
--       end
--     end
--   end,
-- })

return hzfacqsoavh
