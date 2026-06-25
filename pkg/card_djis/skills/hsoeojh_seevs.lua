local skill = fk.CreateSkill {
  name = "hsoeojh_seevs_skill",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

skill:addEffect("cardskill", {
  prompt = "#hsoeojh_seevs_skill",
  mod_target_filter = Util.TrueFunc,
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
      reason = "hsoeojh_seevs",
      pattern = ".|1,11,12,13|spade,club",
    }
    room:judge(judge)
	local result=judge.card
    if  result  and (result.color==Card.Black) and --(result.suit == Card.Spade or result.suit == Card.club)
    (result.number==1 or result.number ==11 or result.number==12 or result.number==13)
    then
      -- to:throwAllCards("he", "hsoeojh_seevs_skill") --非
      -- room:throwCard(to:getCardIds("he"),"hsoeojh_seevs_skill",to)
    room:moveCards({
      ids = to:getCardIds("he"),
      from = to,
      toArea = Card.DiscardPile,
      moveReason = fk.ReasonDiscard,
      proposer = nil,
      skillName = "hsoeojh_seevs_skill",
    })
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
    until   not nextp:isProhibited(nextp, effect.card)
-- not nextp:hasDelayedTrick(effect.card.name) and

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

return skill

