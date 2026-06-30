local kiamsmuoh = fk.CreateSkill {
  name = "kiamsmuoh",
}

Fk:loadTranslationTable{
  ["kiamsmuoh"] = "劍舞",
  [":kiamsmuoh"] = "當伱使用牌對目幖角色A致傷後,伱可發動(每次使用牌限1次).伱亮出牌堆頂5牌,伱對A使用其中殺(无視距離次數且傷害改爲流失體力),若亮出牌中无殺,伱流失1體力.",

  ["kiamsmuoh-choose"] = "劍舞 選擇目幖",
}

local kiamsmuoh_spec = {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    if target == player and player:hasSkill(kiamsmuoh.name) 
    and data.card 
    and not data.to.dead
    then
      local use_event = player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true)
      if use_event then
        local use = use_event.data
        return table.contains(use.tos,data.to) 
        and not use.extra_data 
        or (not use.extra_data.kiamsmuoh)  -- table?一牌不能有多个使用者  
            -- and use.extra_data.kiamsmuoh.from==player.id
      end
    end
  end,

  on_use = function(self, event, target, player, data)
    local room=player.room
    local to =data.to
    local nossaet=true
    local cards = room:getNCards(5)
    room:moveCards({
      ids = cards,
      toArea = Card.Processing,
      moveReason = fk.ReasonJustMove,
      skillName = kiamsmuoh.name,
      proposer = player.id,
    })
    for i=1, #cards,1 do
      local card= Fk:getCardById(cards[i])
      if card.trueName =="ssaet" then
        -- table.insert(card.skillNames , kiamsmuoh.name)
        nossaet=false
        local extra_data={}
        extra_data.kiamsmuoh_ssaet=true
        if player:canUseTo(card,to,{bypass_distances = true, bypass_times = true}) then
          room:useCard({
            from = player,
            tos = {to},
            card = card,
            extra_data=extra_data,
            extraUse=true,
          })
        end
      end
    end

    room:cleanProcessingArea(cards)

    if nossaet==true then
      room:loseHp(player, 1, kiamsmuoh.name,player)
    end

    -- local t=player:getTableMark("__kiamsmuoh_cardids-phase")
    -- table.insert(t,data.card.id)
    -- player.room:setPlayerMark(player,"__kiamsmuoh_cardids-phase",t)

    local use_event = player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true)
      if use_event then
        local use = use_event.data
        use.extra_data=use.extra_data or {}
        use.extra_data.kiamsmuoh=true
      end
  end,
}

kiamsmuoh:addEffect(fk.PreDamage, {
  is_delay_effect=true,
  -- anim_type = "offensive",
  can_refresh= function(self, event, target, player, data)
    if target==player then
      local use_event = player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true)
      return use_event and use_event.data and use_event.data.extra_data and use_event.data.extra_data.kiamsmuoh_ssaet
    end
  end,
  on_refresh = function(self, event, target, player, data)
    local n = data.damage
     data:preventDamage()  --无旹機
    --data.prevented=true  --无旹機
    player.room:loseHp(data.to, n, kiamsmuoh.name,player)
  end,
})

kiamsmuoh:addEffect(fk.Damage, kiamsmuoh_spec) --
-- kiamsmuoh:addEffect(fk.Damaged, kiamsmuoh_spec)


-- kiamsmuoh:addEffect(fk.CardUseFinished, { --
--   can_refresh = function (self, event, target, player, data)
--     return data.card and table.contains(player:getTableMark("__kiamsmuoh_cardids-phase"), data.card.id)
--   end,
--   on_refresh = function (self, event, target, player, data)
--     local t=player:getTableMark("__kiamsmuoh_cardids-phase")
--     table.remove(t, table.indexOf(t, data.card.id))
--     player.room:setPlayerMark(player,"__kiamsmuoh_cardids-phase",t)
--   end,
-- })

return kiamsmuoh
