local butjyen = fk.CreateSkill {
  name = "butjyen",
  tags = {Skill.Compulsory},
  derived_piles = "butjyen_piles",
}

Fk:loadTranslationTable{
  ["butjyen"] = "佛緣",
  [":butjyen"] = "鎖定｡➀伱成为卽旹元牌唯一目幖後必發｡此牌使用无效,伱將之置于伱將牌上｡➁伱轉終,若伱有佛緣牌必發,伱依序廢置一佛緣牌并令其對伱執行效果",

  ["butjyen_piles"] = "佛緣",

  ["$butjyen1"] = "佛緣鐵卷在此,誰敢不敬。",
  ["$butjyen2"] = "御賜佛緣鐵卷,可保祖孫三代",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

butjyen:addEffect(fk.TargetConfirmed, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(butjyen.name) 
    and not data.card:isVirtual()
    and  S.getCardUsageType(data.card.trueName)==1
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    S.useNullify(data.use,player,butjyen.name)
    if player.room:getCardArea(data.card) == Card.Processing  and not player.dead then
      player:addToPile("butjyen_piles", data.card, true, butjyen.name) 
    end
  end,
})

butjyen:addEffect(fk.TurnEnd, {
  anim_type = "negative",
  can_trigger = function(self, event, target, player, data)
    return
      player:hasSkill(butjyen.name) 
      and player == target
      and #player:getPile("butjyen_piles") > 0
  end,
  on_use = function(self, event, target, player, data)

    local room = player.room

    while #player:getPile("butjyen_piles") > 0 do
      local id = player:getPile("butjyen_piles")[1]


      room:moveCards({
        from = player,
        ids = { id },
        toArea = Card.DiscardPile,
        moveReason = fk.ReasonPutIntoDiscardPile,
        skillName = butjyen.name,
      })
      if player.dead then return end

          local card = Fk:getCardById(id)
          local effect_data = CardEffectData:new {
            card = card,
            to = player,
            tos = { player },
          }
          room:sendLog{
            type = "#CardEffect",
            from = player.id,
            arg = card:toLogString(),
          }
          room:doCardEffect(effect_data)

    end
  end,
})

return butjyen
