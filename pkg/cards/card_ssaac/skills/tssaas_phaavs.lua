local cardSkill = fk.CreateSkill {
  name = "tssaas_phaavs_skill",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt = "#tssaas_phaavs_skill",
  mod_target_filter = Util.TrueFunc,
  can_use = function(self, player, card, extra_data)
    return Util.CanUseToSelf(self, player, card, extra_data) 
  end,
  target_num=1,
  target_filter = function(self, player, to_select, selected, _, card, extra_data)
    return S.useToSelfFilter(self, player, to_select, selected, _, card, extra_data)
  end,
  on_use = function (self, room, cardUseEvent)
    local cards = room:askToCards(player, {
      min_num = 1,
      max_num = 1,
      skill_name = cardSkill.name,
      pattern =".",
      prompt = "#tssaas_phaavs_skill-ask::"..cardUseEvent.from.id,
      cancelable = true,
    }) 
    if not cards[1] then return end

    local card=Fk:getCardById(cards[1])
    room:setCardMark(cardUseEvent.card,"tssaas_phaavs_mark-inarea",{card.suit,card.number, Card.PlayerJudge,Card.Processing})
  end,
  on_effect = function(self, room, effect)
    local to = effect.to
      room:damage{
        to = to,
        damage = 3,
        card = effect.card,
        damageType = Fk:getDamageNature(fk.ThunderDamage) and fk.ThunderDamage or fk.NormalDamage,
        skillName = self.name,
      }

      room:moveCards{
        ids = room:getSubcardsByRule(effect.card, { Card.Processing }),
        toArea = Card.DiscardPile,
        moveReason = fk.ReasonUse,
      }
  end,
  on_nullified = function(self, room, effect)
    room:moveCards{
      ids = room:getSubcardsByRule(effect.card, { Card.Processing }),
      to = effect.to,
      toArea = Card.PlayerJudge,
      moveReason = fk.ReasonPut,
    }
  end,
})

cardSkill:addEffect(fk.AfterCardUseDeclared, {
  -- global = true,

  can_trigger = function(self, event, target, player, data)
    if target==player
    and  player:hasDelayedTrick("tssaas_phaavs") then
      return true
    end
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room
    local exe=function(card)
          room:moveCardTo(card, Card.Processing, nil, fk.ReasonPut, "tssaas_phaavs_skill" )

          local effect_data = CardEffectData:new {
            card = card,
            to = player,
            tos = { player },
            responseToEvent = nil,
            extar_data={
              tshoak_hsvoah_tsjek_sjin=data
            }
          }
          room:sendLog{
            type = "#CardEffect",
            from = player.id,
            arg = card:toLogString(),
          }
          room:doCardEffect(effect_data)
        end
    for _, id in ipairs(player:getCardIds(Player.Judge)) do
      local c = player:getVirualEquip(id)
      if not c then c = Fk:getCardById(id) end
      if c.trueName == "tssaas_phaavs" then
          if c:getMark("tssaas_phaavs_mark-inarea")[1] == data.card.suit or  cc:getMark("tssaas_phaavs_mark-inarea")[2] == data.card.number then exe(c) end 
        
      end
    end
  end,
})
return cardSkill
