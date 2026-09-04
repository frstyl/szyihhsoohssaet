local askToChooseQueue = fk.CreateSkill({
  name = "askToChooseQueue",
})
local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{
  ["askToChooseQueue"] = "選擇隊列",
}
askToChooseQueue:addEffect("active", {  --弃同色牌
  mute = true,
  target_filter = function(self, player, to_select, selected)
    if #selected == 0 then
      if self.starting   then return self.starting ==to_select 
      else
          return true
      end
   end
    return S.getNextOne(selected[#selected])==to_select
  end,
  -- min_target_num = function(self) return self.min end,
  -- max_target_num = function(self) return self.max end,
    feasible= function(self, player, selected, selected_cards, card)
    return #selected >= (self.min or 1) and #selected<= (self.max or 999)
    -- and (self.ending==nil or self.ending==selected[#selected] )
  end,
  -- on_use = function(self, room, effect)
  --   room:throwCard(effect.card, self.skillName, effect,from, effect,from)
  -- end,
})


return askToChooseQueue
