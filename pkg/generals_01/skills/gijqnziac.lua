local gijqnziac = fk.CreateSkill{
  name = "gijqnziac",
}
Fk:loadTranslationTable{
  ["gijqnziac"] = "祈禳",
  [":gijqnziac"] = "主旹,伱可選擇1角色有咒術者發動｡迻除其咒術,其抽1",

  ["#gijqnziac-choose"] = "祈禳 爲1角色敺㪔咒術",

  ["$gijqnziac1"] = "能保則吉更當修爲",
  ["$gijqnziac2"] = "切摸妄作萬福來宜",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

gijqnziac:addEffect("active", {
  anim_type = "offensive",
  prompt = "#gijqnziac",
  max_phase_use_time = 1,
  card_num = 0,
  target_num = 1,
  -- can_use = function(self, player)
  --   return player:usedSkillTimes(gijqnziac.name, Player.HistoryPhase) == 0
  -- end,
  card_filter = Util.FalseFunc,
  target_filter = function(self, player, to_select, selected)
    return #selected == 0 and S.hasTsziukzzyit(to_select)
  end,
  on_use = function(self, room, effect)
    local to =effect.tos[1]
      if S.removeTsziukzzyit(to) and not to.dead then
      to:drawCards(1,gijqnziac.name)
      end
  end,
})
-- gijqnziac:addEffect(fk.EventPhaseStart, {
--   anim_type = "drawcard",
--   can_trigger = function(self, event, target, player, data) 
--     if target == player and player:hasSkill(gijqnziac.name) and player.phase == Player.Start  then
--       local targets= table.filter(player.room.alive_players, function(p)
--         return S.hasTsziukzzyit(p)
--       end)
--       if #targets>0 then
--         event:setCostData(self,{targets=targets})
--         return true
--       end
--       end
--   end,
--   on_cost = function(self, event, target, player, data)
--     local room=player.room
--     local tos = room:askToChoosePlayers(player, {
--       min_num = 1,
--       max_num = 1,
--       targets =event:getCostData(self).targets,
--       skill_name = gijqnziac.name,
--       prompt = "#gijqnziac-choose",
--       cancelable = true,
--     })
--     if #tos>0 then
--       event:setCostData(self,{tos=tos})
--       return true
--     end
--   end,
--   on_use = function(self, event, target, player, data)
--     local to=event:getCostData(self).tos[1]
--     if S.removeTsziukzzyit(to) and not to.dead then
--       to:drawCards(1,gijqnziac.name)
--     end
--   end,
-- })


return gijqnziac
