local skill = fk.CreateSkill {
  name = "ssaac_dzzjin_koac_skill",
}

skill:addEffect("cardskill", {
  prompt = "#ssaac_dzzjin_koac_skill",
  mod_target_filter = Util.TrueFunc,
  can_use = Util.CanUseToSelf,
  -- target_num = 1, 
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    local to = effect.to
    local judge = {
      who = to,
      reason = "ssaac_dzzjin_koac",
      pattern = ".|1,11,12,13|diamond,heart",
    }
    room:judge(judge)
	local result=judge.card
    if  result  and (result.color==Card.Red) and --(result.suit == Card.Spade or result.suit == Card.club)
    (result.number==1 or result.number ==11 or result.number==12 or result.number==13)
    then
      to:drawCards(5,self.name)
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

