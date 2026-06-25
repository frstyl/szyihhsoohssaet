local ssaet_times = fk.CreateSkill {
  name = "ssaet_times",
}

ssaet_times:addEffect("targetmod", {
  residue_func = function(self, player, skill, scope,card)

    if  card.trueName == "ssaet" and scope == Player.HistoryPhase then
      local n =0
      for _, suf in ipairs({ "-phase", "-turn", "-round", "" } ) do
        n=n+player:getMark("@ssaet_times"..suf)
      end
      return n
    end
  end,
})
-- ssaet_times:addEffect("targetmod", {
--   residue_func = function(self, player, skill, scope)
--     if  skill.trueName == "ssaet_skill" and scope == Player.HistoryPhase then
--       local n = 0
--       for _, suffix in ipairs({"","-turn","-phase","-round"}) do
--         n=n+player:getMark("@ssaet_times"..suffix)
--       end
--       return n
--     end
--   end,
-- })
return ssaet_times
