local skill = fk.CreateSkill {
  name = "tshoak_hsvoah_tsjek_sjin_check",
}

Fk:loadTranslationTable{

["tshoak_hsvoah_tsjek_sjin_check"] = "厝",
["#CardEffect"] = " %from %arg 將生效",
}

skill:addEffect(fk.DamageInflicted, {
  -- global = true,
  late_refresh = true,
  can_trigger = function(self, event, target, player, data)
    return target==player
    and data.damageType == fk.FireDamage and  player:hasDelayedTrick("tshoak_hsvoah_tsjek_sjin")
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room
    local exe=function(card)
          room:moveCardTo(card, Card.Processing, nil, fk.ReasonPut, "phase_judge")

          local effect_data = CardEffectData:new {
            card = card,
            to = player,
            tos = { player },
            responseToEvent = data
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
      if c.name == "tshoak_hsvoah_tsjek_sjin" then
        exe(c)
      end
    end
  end,
})




return skill
