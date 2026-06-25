local tsiuhSkill = fk.CreateSkill {
  name = "tsiuh_skill",
}

Fk:loadTranslationTable{
["@tsyis-turn"] = "酒",
}

tsiuhSkill:addEffect("cardskill", {
  prompt = function(self, _, _, _, extra_data)
    return extra_data.tsiuhRecover and "#nziuk_skill" or "#tsiuh_skill"  --analepticRecover tsiuhRecover
  end,
  max_turn_use_time = 1,
  mod_target_filter = Util.TrueFunc,
  can_use = function(self, player, card, extra_data)
    return Util.CanUseToSelf(self, player, card, extra_data) and
      ((extra_data and (extra_data.bypass_times or extra_data.tsiuhRecover)) or
      self:withinTimesLimit(player, Player.HistoryTurn, card, "tsiuh", player))  --保畱?
  end,
  on_use = function(self, room, use)
    if use.extra_data and use.extra_data.tsiuhRecover then
      use.extraUse = true
    end
  end,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
        
    local to = effect.to
    if effect.extra_data and effect.extra_data.tsiuhRecover then
      if to:isWounded() and not to.dead then
        room:recover({
          who = to,
          num = 1,
          recoverBy = effect.from,
          card = effect.card,
        })
      end
    else
      to.drank = to.drank + 1 + ((effect.extra_data or {}).additionalDrank or 0)
      room:setPlayerMark(to,"@tsyis-turn",to.drank)
      room:broadcastProperty(to, "drank")
      room:addSkill("tsiuh_delay")
    end
  end,
})

return tsiuhSkill
