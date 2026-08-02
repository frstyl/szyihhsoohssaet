local cardSkill = fk.CreateSkill {
  name = "szjemh_skill",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  can_use = Util.FalseFunc,
  offset_func= Util.FalseFunc,
  target_num=0,
  on_effect = function(self, room, effect)
    if effect.responseToEvent  then --cardEffectData
      effect.responseToEvent.offsetTimes = (effect.responseToEvent.offsetTimes or 0) +1
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

--toCard額外生效
--事件就止發旹機
cardSkill:addEffect(fk.BeforeCardUseEffect, {
  priority = 0,
  mute = true,
  can_trigger = function(self, event, target, player, data)
    return player.seat==1 
    and data.toCard
    and data.additionalEffect
  end,
  on_trigger = function(self, event, target, player, data)
    local effectTimes=0
    local room=player.room
    while effectTimes < data.additionalEffect do  --複製
      local cardEffectData = CardEffectData:new{
        from = data.from,
        tos = data.tos,
        subTos = data.subTos,
        card = data.card,
        toCard = data.toCard,
        use = data,
        responseToEvent = data.responseToEvent,
        additionalDamage = data.additionalDamage,
        additionalRecover = data.additionalRecover,
        cardsResponded = data.cardsResponded,
        prohibitedCardNames = data.prohibitedCardNames,
        extra_data = data.extra_data,
      }
      room:doCardEffect(cardEffectData)

      if cardEffectData.cardsResponded then
        data.cardsResponded = data.cardsResponded or {}
        for _, card in ipairs(cardEffectData.cardsResponded) do
          table.insertIfNeed(data.cardsResponded, card)
        end
      end

      effectTimes=effectTimes+1
    end
  end,
})

return cardSkill
