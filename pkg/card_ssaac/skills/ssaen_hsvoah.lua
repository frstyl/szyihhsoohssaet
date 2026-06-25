local cardSkill = fk.CreateSkill {
  name = "ssaen_hsvoah_skill",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt = "#ssaen_hsvoah_skill",
  mod_target_filter = Util.TrueFunc,
  max_turn_use_time = 1,
  can_use = function(self, player, card, extra_data)
    return Util.CanUseToSelf(self, player, card, extra_data) 
    and S.magicCanUse(player, card)
    -- and self:withinTimesLimit(player, Player.HistoryTurn, card, "ssaen_hsvoah", player)
  end,  
  on_use = function(self, room, cardUseEvent)
    S.magicOnUse(cardUseEvent.from, cardUseEvent)
  end,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    local to = effect.to
    local judge = {
      who = to,
      reason = "ssaen_hsvoah",
      pattern = ".|.|heart",
    }
    room:judge(judge)
    if judge:matchPattern() then

      if not to.dead then
      room:damage{
        to = to,
        damage = 2,
        card = effect.card,
        damageType =  fk.FireDamage,
        skillName = self.name,
      }
      end
      local tos ={ }
      table.insert(tos, S.getNextOne(to,-1))
      table.insert(tos, S.getNextOne(to,1)) --上下家同人則兩次

      -- table.insertIfNeed(tos,S.getNextOne(to,1))
      -- if tos[1]==to then return end
      
      -- room:sortByAction(tos)
      for _, p in ipairs(tos) do
        if not p.dead then
        room:damage{
          to = p,
          damage = 1,
          card = effect.card,
          damageType =  fk.FireDamage,
          skillName = self.name,
        }
        end
      end
      --
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
-- not nextp:hasDelayedTrick("djis_douch") and 

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
