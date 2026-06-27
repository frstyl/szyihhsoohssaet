local khuoqmoa_active = fk.CreateSkill{
  name = "khuoqmoa_active",
}
-- Fk:loadTranslationTable{
--   ["khuoqmoa_active"] = "祈禳",
--   [":khuoqmoa_active"] = "主旹,伱可選擇1角色有咒術者發動｡迻除其咒術,其抽1",

--   ["#khuoqmoa_active-choose"] = "祈禳 爲1角色敺㪔咒術",

--   ["$khuoqmoa_active1"] = "能保則吉更當修爲",
--   ["$khuoqmoa_active2"] = "切摸妄作萬福來宜",
-- }
local S = require "packages/szyihhsoohssaet/szyih_guos" 

khuoqmoa_active:addEffect("active", {
  anim_type = "offensive",
  prompt = "#khuoqmoa_active",
  max_phase_use_time = 1,
  card_num = 0,
  target_num = 1,
  -- can_use = function(self, player)
  --   return player:usedSkillTimes(khuoqmoa_active.name, Player.HistoryPhase) == 0
  -- end,
  interaction = function(self, player)
      return UI.ComboBox {
      choices = {"buff","debuff"}
    }
  end,
  card_filter = Util.FalseFunc,
  target_filter = function(self, player, to_select, selected)
    return #selected == 0
  end,
  on_use = function(self, room, effect)
    S.addTsziukzzyitBuff(effect.tos[1],  self.interaction.data,player)
  end,
})


return khuoqmoa_active
