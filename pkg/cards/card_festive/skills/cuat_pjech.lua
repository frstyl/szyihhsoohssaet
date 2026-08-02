local cardSkill = fk.CreateSkill {
  name = "cuat_pjech_skill",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt = "#cuat_pjech_skill",
  mod_target_filter = Util.TrueFunc,
  -- mod_target_filter = function(self, player, to_select)
  --   return to_select:getMark("cuat_pjech")==0
  -- end,
  max_round_use_time=1,
  -- can_use = function(self, player, card, extra_data)  --无視次數?
    -- return Util.CanUseToSelf(self, player, card, extra_data) and
      -- (extra_data and (extra_data.bypass_times ) or
  --     table.find(Fk:currentRoom().alive_players,
  --       -- extra_data and extra_data.fix_targets and   table.map(extra_data.fix_targets,Util.Id2PlayerMapper ) or {player},
  --      function(p)
  --       return  self:withinTimesLimit(player, Player.HistoryRound, card, "cuat_pjech", p)
  --     end)
  -- end,
  target_num=1,
  target_filter = function(self, player, to_select, selected, _, card, extra_data)
    if  not  S.useToSelfFilter(self, player, to_select, selected, _, card, extra_data) then return end
    return #selected~=0 
     or
      (extra_data and extra_data.bypass_times ) 
        or self:withinTimesLimit(player, Player.HistoryRound, card, "cuat_pjech", to_select)
  end,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    room:addPlayerMark(effect.to,"cuat_pjech",1)
    room:handleAddLoseSkills(effect.to, "&hqjevqcuat", nil, false, false)
  end,
})

return cardSkill
