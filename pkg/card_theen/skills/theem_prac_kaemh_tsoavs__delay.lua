local cardSkill = fk.CreateSkill {
  name = "theem_prac_kaemh_tsoavs_delay",
}

-- cardSkill:addEffect(fk.Damaged, {
--   can_trigger = function(self, event, target, player, data)
--     return target==player and data.card and data.card.trueName=="theem_prac_kaemh_tsoavs"
--   end,
--     on_trigger = function(self, event, target, player, data)
--       player:drawCards(5)
--     end,
--   })

cardSkill:addEffect(fk.CardEffectCancelledOut, {
  -- global = true,
  -- mute = true,
  priority = 0,
  can_trigger = function(self, event, target, player, data)
    return target==player  --用殺者
    and
    data.extra_data and  data.extra_data.theem_prac_kaemh_tsoavs 
    and 
    data.from and data.to and not data.from.dead and not data.to.dead
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room

    local from=data.to  --
    local to =data.from  --用殺者

    local card

    for _, c in ipairs(data.cardsResponded) do
      if c.trueName=="theem_prac_kaemh_tsoavs" then
        card=c
      end
    end

    room:doIndicate(from.id, {to.id})
    room:sendLog{
    type = "#theem_prac_kaemh_tsoavs_delay",
    from = from.id,
    tos = {to.id},
    -- arg = card and card:toLogString(),
  }
    local use = room:askToUseCard(to, {
        skill_name = cardSkill.name,
        pattern = "ssaet",
        prompt = "#theem_prac_kaemh_tsoavs-ssaet:"..from.id,
        cancelable = true,
        extra_data = {
          bypass_distances = false,
          bypass_times = true,
          must_targets = {from.id},
        }
      })
      if use then
        room:useCard(use)
      end
      if use  or to.dead then --and use.damageDealt and use.damageDealt[from]
        return 
      end

    local n = 0
    room.logic:getEventsOfScope(GameEvent.UseCard, 1, function (e)
      local dat=e.data
        if dat.from == to and dat.card.trueName=="ssaet" then
          n=n+1
        end
    end, Player.HistoryPhase)

      room:damage{
        from = from,
        to = to,
        card = card,
        damage = n,
        skillName = cardSkill.name,
      }

  end,
})

return cardSkill
