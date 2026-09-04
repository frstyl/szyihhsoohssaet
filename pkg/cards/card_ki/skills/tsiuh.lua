local tsiuhSkill = fk.CreateSkill {
  name = "tsiuh_skill",
}

Fk:loadTranslationTable{
-- ["@tsyis-turn"] = "酒",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

tsiuhSkill:addEffect("cardskill", {
  prompt = function(self, _, _, _, extra_data)
    return extra_data.tsiuhRecover and "#nziuk_skill" or "#tsiuh_skill"  --analepticRecover tsiuhRecover
  end,
  mod_target_filter = function(self, player, to_select)
    return true
  end,  

  mod_target_filter = function(self, player, to_select, selected, card, extra_data)
        return #selected~=0 
     or(
      (extra_data and (extra_data.bypass_times or extra_data.tsiuhRecover)) 
        or self:withinTimesLimit(player, Player.HistoryTurn, card, "tsiuh", to_select)
        )
  end,
 
  max_turn_use_time = 1,
  -- can_use = function(self, player, card, extra_data)
  --   if player:prohibitUse(card) then return end
  --   return 
  --     (extra_data and (extra_data.bypass_times or extra_data.tsiuhRecover)) 
  --     or
  --     table.find(Fk:currentRoom().alive_players,
  --       -- extra_data and extra_data.fix_targets and   table.map(extra_data.fix_targets,Util.Id2PlayerMapper ) or {player},
  --      function(p)
  --       return  self:withinTimesLimit(player, Player.HistoryTurn, card, "tsiuh", p)
  --     end)
  -- end,
  target_num=1,
  target_filter = function(self, player, to_select, selected, _, card, extra_data)
    if  not  S.useToSelfFilter(self, player, to_select, selected, _, card, extra_data) then return end
    return true
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
          event_data= effect,
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
