local cardSkill = fk.CreateSkill {
  name = "theen_looj_skill",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt = "#theen_looj_skill",
  mod_target_filter = Util.TrueFunc,
  can_use = function(self, player, card, extra_data)
    if player:prohibitUse(card) then return end
    return  S.scourgeCanUse(self, player, card, extra_data)
  end,
  target_num=1,
  target_filter = function(self, player, to_select, selected, _, card, extra_data)
    return S.useToSelfFilter(self, player, to_select, selected, _, card, extra_data)
  end,
  on_use = function(self, room, cardUseEvent)
    S.scourgeOnUse(self, cardUseEvent.from, cardUseEvent)
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
        if nextp:isProhibitedTarget(effect.card) then
          room:moveCards{
            ids = room:getSubcardsByRule(effect.card, { Card.Processing }),
            toArea = Card.DiscardPile,
            moveReason = fk.ReasonPut,
          }
          return
        end
        break
      end
    until not nextp:isProhibitedTarget(effect.card)
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


-- cardSkill:addEffect(fk.EventPhaseChanging , {
--   priority = 0,
--   can_trigger = function(self, event, target, player, data)
--     return player==target
--       (data.phase==Player.Judge )
--   end,
--   -- trigger_times = function(self, event, target, player, data)
--   --   return 999
--   -- end,
--   on_trigger = function(self, event, target, player, data)
--     local room=target.room


--     local exe=function(card)
--       room:moveCardTo(card, Card.Processing, nil, fk.ReasonPut, "phase_judge")
--       if card:isVirtual() then
--         room:sendCardVirtName({cid}, card.name)
--       end

--       local effect_data = CardEffectData:new {
--         card = card,
--         to = target,
--         tos = { target },
--         extar_data={
--           phase_data=data
--         }
--       }
--       room:sendLog{
--         type = "#CardEffect",
--         from = target.id,
--         arg = card:toLogString(),
--       }
--       room:doCardEffect(effect_data)
--       if effect_data.isCancellOut then
--         card.skill:onNullified(room, effect_data)
--       end
--     end

--     local names = {"theen_looj","ssaen_hsvoah","djis_douch","hsoeojh_seevs",  "ssaac_dzzjin_koac"}

--     for _,cid in  pairs(target:getCardIds(Player.Judge)) do --新來?
--       if data.phase_end then return end
--       local c=   target:getVirtualEquip(cid) or Fk:getCardById(cid)
--       if table.contains(names,c.trueName) then exe(c)  end
--     end
--   end,
-- })

return cardSkill
