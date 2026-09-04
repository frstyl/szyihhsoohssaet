local dvoattoamh = fk.CreateSkill {
  name = "dvoattoamh",
}

Fk:loadTranslationTable{
["dvoattoamh"] = "敓膽",
[":dvoattoamh"] = "伱起動殺指定目幖後伱可發動.其可起動閃影響此殺旹,若其手牌中有可起動之閃,其隨機起動其一,否則其展示手牌",

["#dvoattoamh-invoke"] = "敓膽 是否對%src 發動",
}

dvoattoamh:addEffect(fk.TargetConfirmed, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return data.from ==player and player:hasSkill(dvoattoamh.name) and data.card.trueName == "ssaet" 
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = dvoattoamh.name,
      prompt = "#dvoattoamh-invoke:"..data.to.id,
    }) 
  end,
  on_use = function(self, event, target, player, data)
    -- player:drawCards(2,dvoattoamh.name)

    -- for _, p in ipairs(room:getOtherPlayers(player)) do  --
    --     room:addTableMark(p,"@@dvoattoamh-phase", event.id)
    --   room:addPlayerMark(p,MarkEnum.UncompulsoryInvalidity .. "-phase",1)
    -- end

    data.extra_data=    extra_data or {}  --banner 此牌不可響應->此牌无視技能
    data.extra_data.dvoattoamh={
        from=player.id,
        card=data.card.id,
      }

    -- room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true):addCleaner(function()
    --   for _, p in ipairs(room:getOtherPlayers(player)) do  --
    --     room:removeTableMark(p,"@@dvoattoamh-phase", event.id)
    --     room:removePlayerMark(p,MarkEnum.UncompulsoryInvalidity .. "-phase", 1)
    --   end
    -- end)

  end,
})

dvoattoamh:addEffect(fk.AskForCardUse, {
  is_delay_effect = true,
  can_trigger = function(self, event, target, player, data)
    return 
          data.eventData
      and player==data.eventData.to
      and data.eventData.use
      and data.eventData.use.extra_data and  data.eventData.use.extra_data.dvoattoamh 
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room

    local cards = table.filter(player:getCardIds("h"), function (id)
      local card = Fk:getCardById(id)
      return card.trueName == "szjemh" and not player:prohibitUse(card)
    end)
    if #cards > 0 then
      local result = {
        from = player,
        card = Fk:getCardById(room:tableRandomPick(cards, 1)[1] ),
        tos = {}
      }
      data.result = result
      return true
    else
      player:showCards(player:getCardIds("h"))
      data.eventData.additionalDamage=(data.eventData.additionalDamage or 0) +1
      -- if not player:isKongcheng() then
      --   player:showCards(player:getCardIds("h"))
      --   cards=  table.filter(player:getCardIds("h"), function (id)
      --     local card = Fk:getCardById(id)
      --     return card.type ==Card.TypeBasic  and not player:prohibitDiscard(card)
      --   end)
      --   room:throwCard(cards ,dvoattoamh.name,player,player)
      -- end
    end

  end,
})

dvoattoamh:addEffect(fk.HandleAskForPlayCard, {
  can_refresh = function(self, event, target, player, data)
    return player.seat==1 and
      data.eventData
      and data.eventData.use
      and data.eventData.use.extra_data and  data.eventData.use.extra_data.dvoattoamh 
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    if not data.afterRequest then
      room:setBanner(dvoattoamh.name, true)
    else
      room:setBanner(dvoattoamh.name, nil)
    end
  end,
})

dvoattoamh:addEffect("prohibit", {
  prohibit_use = function(self, player, card)
    local ex = Fk:currentRoom():getBanner(dvoattoamh.name)
    if card and ex then
      return 
       (card.trueName=="szjemh" and card:isVirtual())
      
    end
  end,
})
return dvoattoamh
