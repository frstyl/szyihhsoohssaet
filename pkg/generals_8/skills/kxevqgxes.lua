
local kxevqgxes = fk.CreateSkill{
  name = "kxevqgxes",
}

Fk:loadTranslationTable{
["kxevqgxes"] = "驕騎",
[":kxevqgxes"] = "伱使用殺旹可發動.伱抽1,此殺結算期閒,其它角色手牌視爲閃,非鎖定技失效.此殺結算終旹,若其曾致傷伱抽x,否則抽y(x爲此殺傷害基數,y爲子牌數)",  --全部牌當閃

["@@kxevqgxes-phase"] = "驕騎",
}


kxevqgxes:addEffect(fk.CardUsing, {----TargetSpecified
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(kxevqgxes.name) and data.card.trueName=="ssaet"
  end,

  on_use = function(self, event, target, player, data)
    local room = player.room
    -- player:drawCards(1,kxevqgxes.name)

    for _, p in ipairs(room:getOtherPlayers(player)) do  --
        room:addTableMark(p,"@@kxevqgxes-phase", event.id)
      room:addPlayerMark(p,MarkEnum.UncompulsoryInvalidity .. "-phase",1)
    end

    data.extra_data=    data.extra_data or {}
    data.extra_data.kxevqgxes={
      from=player.id, --多餘
      event=event.id,
    }

    room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true):addCleaner(function()
      for _, p in ipairs(room:getOtherPlayers(player)) do  --
        room:removeTableMark(p,"@@kxevqgxes-phase", event.id)
        room:removePlayerMark(p,MarkEnum.UncompulsoryInvalidity .. "-phase", 1)
      end
    end)

  end,
})



kxevqgxes:addEffect(fk.CardUseFinished, {
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    return    target==player
    and  data.extra_data 
    and data.extra_data.kxevqgxes 
    and data.extra_data.kxevqgxes.from ==player.id
  end,
  on_trigger = function(self, event, target, player, data)
    -- player:drawCards(1,kxevqgxes.name)
    local m=0
    if data.damageDealt then
      m =(data.additionalDamage or 0)+1
    else
      m =data.card:isVirtual() and #data.card.subcards or 1
    end
    player:drawCards(m,kxevqgxes.name)
  end,
})

-- kxevqgxes:addEffect(fk.CardUseFinished, {
--   priority = 0,
--   is_delay_effect=true,
--   can_trigger = function(self, event, target, player, data)
--     return    target==player
--     and table.contains(player:getTableMark("@@kxevqgxes-phase"), event.id )

--   end,
--   on_trigger = function(self, event, target, player, data)
--     room:removeTableMark(player,"@@kxevqgxes-phase", event.id)
--   end,
-- })

kxevqgxes:addEffect("filter", {  --不區別源 多个同技能止1次
  -- mute = true,
  card_filter = function(self, to_select, player)
      return #player:getTableMark("@@kxevqgxes-phase")>0
  end,
  view_as = function(self, player, card)
    return Fk:cloneCard("szjemh", card.suit, card.number)
  end,
})

return kxevqgxes
