local ssaocqlioc = fk.CreateSkill {
  name = "ssaocqlioc",
  -- tags = { Skill.Compulsory },
}
Fk:loadTranslationTable{
  ["ssaocqlioc"] = "雙龍",
  [":ssaocqlioc"] = "伱所使用｢殺｣旹,伱隱祕選擇其中1目幖發動.此殺目幖｢閃｣視爲護｢閃｣,此殺首輪生效終迻除上述效果,且若其此｢殺｣伱所選角色效果未被｢閃｣抵消,此｢殺｣額外生效1次.",
--隱祕
  ["#ssaocqlioc-choose"] = "雙龍 選擇目幖 或不發動",
  -- ["#ssaocqlioc-invoke2"] = "雙龍 選擇額外目幖 不選目幖确定額外結算 或不發動",

  ["#ssaocqlioc-invoke"] = "雙龍：是否令其他目标角色选择代替你使用【闪】？",
  ["#ssaocqlioc-ask"] = "雙龍：你可以替 %src 使用【闪】",

  ["#ssaocqlioc-target"] = "%from 雙龍生效, 目幖爲 %tos",

  ["$ssaocqlioc1"] = "一對白龍爭上下",
  ["$ssaocqlioc2"] = "董一撞在此",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

-- ssaocqlioc:addEffect(fk.PreCardUse, {
--   anim_type = "offensive",
--   can_trigger = function(self, event, target, player, data)
--     return target == player and player:hasSkill(ssaocqlioc.name) and data.card.trueName == "ssaet" and
--       #data:getExtraTargets() > 0
--   end,
--   on_cost = function(self, event, target, player, data)
--     local room = player.room
--     local tos = room:askToChoosePlayers(player, {
--       min_num = 1,
--       max_num = 1,
--       targets = data:getExtraTargets(),
--       skill_name = ssaocqlioc.name,
--       prompt = "#ssaocqlioc-choose:::"..data.card:toLogString(),
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
--     data.extra_data.ssaocqlioc = true
--   end,
-- })

ssaocqlioc:addEffect(fk.CardUsing, {  --記錄additionalEffect 首輪
  -- mute=true,
  no_indicate=true,
  can_trigger= function(self, event, target, player, data)
    return  data.from == player  and player:hasSkill(ssaocqlioc.name) and data.card.trueName=="ssaet"
  end,
  on_cost= function(self, event, target, player, data)
    local tos = player.room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = data.tos,
      skill_name = ssaocqlioc.name,
      prompt = "#ssaocqlioc-choose",
      cancelable = true,
    })
    if #tos>0 then 
      event:setCostData(self,{tos=tos})  --寫于此?
      return true
    end
  end,
  on_use= function(self, event, target, player, data)
    data.extra_data =    data.extra_data or {}
    -- data.extra_data.ssaocqlioc={max_additionalEffect=data.additionalEffect or 0,can_use=true,}
    data.extra_data.ssaocqlioc=event:getCostData(self).tos[1]

    for _, p in ipairs(data.tos) do 
      player.room:setPlayerMark(p,"ssaocqlioc-viewAs",1)
    end

  end,
})


ssaocqlioc:addEffect(fk.CardEffectCancelledOut, {  --記錄additionalEffect 首輪
  anim_type = "offensive",
  can_refresh = function(self, event, target, player, data)
    return  target==player   --多次刷新?
    and data.cardsResponded[1].trueName=="szjemh" and data.card.trueName=="ssaet"
    and data.use.extra_data 
    and data.use.extra_data.ssaocqlioc
    and data.use.extra_data.ssaocqlioc == data.to
    -- and data.use.extra_data.ssaocqlioc.max_additionalEffect== data.use.additionalEffect
  end,
  on_refresh = function(self, event, target, player, data)
    -- data.use.extra_data.ssaocqlioc.can_use=false
    data.use.extra_data.ssaocqlioc=nil
  end,
})

ssaocqlioc:addEffect(fk.CardEffectFinished, {--CardEffectFinished  --末目幖 tos已排序
  anim_type = "offensive",
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    return data.to==data.tos[#data.tos]
    and  data.card.trueName=="ssaet"
    and  data.use.extra_data and data.use.extra_data.ssaocqlioc
  end,
  on_trigger = function(self, event, target, player, data)
    player.room:sendLog{
    type = "#ssaocqlioc-target",
    from = data.from.id,
    tos={data.use.extra_data.ssaocqlioc.id}
  }
    data.use.additionalEffect = (data.use.additionalEffect or 0) + 1
    data.use.extra_data.ssaocqlioc=nil

    local room=player.room
    for _, p in ipairs(room.players) do --防中途變目幖
      room:setPlayerMark(p,"ssaocqlioc-viewAs",nil)
    end
  end,
})


-- ssaocqlioc:addEffect(fk.HandleAskForPlayCard, {
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
--         room:setPlayerMark(p,"ssaocqlioc-viewAs",nil)
--       end
--     else
--       for _, p in ipairs(data.eventData.tos) do 
--         room:setPlayerMark(p,"ssaocqlioc-viewAs",1)
--       end
--     end
--   end,
-- })

ssaocqlioc:addEffect("filter", {  --如何令其它印牌變hand__
  card_filter = function(self, to_select, player)
    return player:hasMark("ssaocqlioc-viewAs") and to_select.trueName=="szjemh"
  end,
  view_as = function(self, player, to_select)
    local card = Fk:cloneCard("hand__szjemh", to_select.suit, to_select.number)
    card.skillName = ssaocqlioc.name
    return card
  end,
})
-- ssaocqlioc:addEffect(fk.AskForCardUse, {
--   mute = true,
--   is_delay_effect = true,
--   can_trigger = function(self, event, target, player, data)
--     if target == player and
--       Exppattern:Parse(data.pattern):matchExp("szjemh") and
--       (data.extraData == nil or data.extraData.ssaocqlioc_ask == nil) then
--       local e = player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard)
--       if e then
--         local use = e.data
--         if use.card.trueName == "ssaet" and use.extra_data and use.extra_data.ssaocqlioc then
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
--       skill_name = "ssaocqlioc",
--       prompt = "#ssaocqlioc-invoke",
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
--           prompt = "#ssaocqlioc-ask:" .. player.id,
--           cancelable = true,
--           extra_data = {
--             ssaocqlioc_ask = true,
--           },
--         })
--         if respond then
--           respond.skipDrop = true
--           room:responseCard(respond)

--           local new_card = Fk:cloneCard("szjemh")
--           new_card.skillName = ssaocqlioc.name
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

return ssaocqlioc
