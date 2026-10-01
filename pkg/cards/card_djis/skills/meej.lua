local skill = fk.CreateSkill {
  name = "meej_skill",
}

Fk:loadTranslationTable{
["meej_skill"] = "迷",
["#meej_skill"] = "迷 對自己起動 不可起動投出殺閃",

["@@meej-turn"] = "迷",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

skill:addEffect("cardskill", {
  prompt ="#meej_skill",
  max_turn_use_time = 1,
  target_num=1,
  mod_target_filter = function(self, player, to_select, selected, card, extra_data)--攻程內其它脚色? --其它腳色
    return  to_select ~= player --殺自己??
    and  ( (extra_data and extra_data.bypass_distances) or self:withinDistanceLimit(player, true, card, to_select)) 

    and 
      (--次數
        #selected > 0 
        or
        (extra_data and extra_data.bypass_times) 
        or
        self:withinTimesLimit(player, Player.HistoryTurn, card, "meej", to_select)
      ) 
  end,
  target_filter  = Util.CardTargetFilter,
  
  offset_func= Util.FalseFunc,
  on_use = function(self, room, cardUseEvent)
    room:addSkill("meej_delay")
  end,
  on_effect = function(self, room, effect)
    -- if  effect.to.dead then return end
    -- room:addSkill("meej_delay")
    -- room:setPlayerMark(effect.to,"@@meej-turn",1)
    -- room:broadcastProperty(to, "meej")
  end,
})

return skill
