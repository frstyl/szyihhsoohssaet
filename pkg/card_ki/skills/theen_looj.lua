local cardSkill = fk.CreateSkill {
  name = "theen_looj_skill",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt = "#theen_looj_skill",
  mod_target_filter = Util.TrueFunc,
  max_turn_use_time = 1,
  can_use = function(self, player, card, extra_data)
    return Util.CanUseToSelf(self, player, card, extra_data) 
    and S.magicCanUse(player, card)
  end,
  on_use = function (self, room, cardUseEvent)
    S.magicOnUse(cardUseEvent.from, cardUseEvent)
  end,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    local to = effect.to
    local judge = {
      who = to,
      reason = "theen_looj",
      pattern = ".|2~9|spade",
    }
    room:judge(judge)
    if judge:matchPattern() then
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
    else
      self:onNullified(room, effect)
    end
  end,
  on_nullified = function(self, room, effect)
    local to = effect.to
    local nextp = to
    repeat
      nextp = nextp:getNextAlive(true)
      if nextp == to then
        if nextp:isProhibited(nextp, effect.card) then
          room:moveCards{
            ids = room:getSubcardsByRule(effect.card, { Card.Processing }),
            toArea = Card.DiscardPile,
            moveReason = fk.ReasonPut,
          }
          return
        end
        break
      end
    until not nextp:isProhibited(nextp, effect.card)
-- not nextp:hasDelayedTrick("theen_looj") and 

    if effect.card:isVirtual() then
      nextp:addVirtualEquip(effect.card)
    end

    room:moveCards{
      ids = room:getSubcardsByRule(effect.card, { Card.Processing }),
      to = nextp,
      toArea = Card.PlayerJudge,
      moveReason = fk.ReasonPut,
    }
  end,
})

return cardSkill
