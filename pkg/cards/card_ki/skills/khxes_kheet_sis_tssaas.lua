local skill = fk.CreateSkill {
  name = "khxes_kheet_sis_tssaas_skill",
}
-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

skill:addEffect("cardskill", {
  prompt = "#khxes_kheet_sis_tssaas_skill",
  mod_target_filter = function(self, player, to_select, selected, card, distance_limited)
    return to_select ~= player
  end,
  target_filter = Util.CardTargetFilter,
  target_num = 1,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    if not (effect.extar_data and  effect.extar_data.phase_data) then return end
    local to = effect.to
    local judge = {
      who = to,
      reason = "khxes_kheet_sis_tssaas",
      pattern = ".|.|spade,club,diamond",
    }
    room:judge(judge)
    if judge:matchPattern() then
      -- to:skip(Player.Play)
        effect.extar_data.phase_data.skipped=true
      -- S.skipPhase(to.id , Player.Play)
    end
    self:onNullified(room, effect)
  end,
  on_nullified = function(self, room, effect)
    room:moveCards{
      ids = room:getSubcardsByRule(effect.card, { Card.Processing }),
      toArea = Card.DiscardPile,
      moveReason = fk.ReasonUse,
    }
  end,
})


skill:addEffect(fk.EventPhaseChanging , {
  priority = 0,
  can_trigger = function(self, event, target, player, data)
    return player==target
    and (
      (data.phase==Player.Discard and target:hasDelayedTrick("tsjek_tshoavh_doon_liac")   )
    or  (data.phase==Player.Play and target:hasDelayedTrick("khxes_kheet_sis_tssaas") )
    or  (data.phase==Player.Draw and target:hasDelayedTrick("tvoans_liac_dzyet_quan") )
  )
  end,
  -- trigger_times = function(self, event, target, player, data)
  --   return 999
  -- end,
  on_trigger = function(self, event, target, player, data)
    local room=target.room


    local exe=function(card)
      room:moveCardTo(card, Card.Processing, nil, fk.ReasonPut, "phase_judge")
      if card:isVirtual() then
        room:sendCardVirtName({cid}, card.name)
      end

      local effect_data = CardEffectData:new {
        card = card,
        to = target,
        tos = { target },
        extar_data={
          phase_data=data
        }
      }
      room:sendLog{
        type = "#CardEffect",
        from = target.id,
        arg = card:toLogString(),
      }
      room:doCardEffect(effect_data)
      if effect_data.isCancellOut then
        card.skill:onNullified(room, effect_data)
      end
    end

    local name = data.phase==Player.Discard and "tsjek_tshoavh_doon_liac" 
    or (data.phase==Player.Play and "khxes_kheet_sis_tssaas") 
    or (data.phase==Player.Draw and "tvoans_liac_dzyet_quan") 

    for _,cid in  ipairs(target:getCardIds(Player.Judge)) do
      local c=   target:getVirtualEquip(cid) or Fk:getCardById(cid)
      if c.trueName==name then exe(c)  end
    end
  end,
})

return skill
