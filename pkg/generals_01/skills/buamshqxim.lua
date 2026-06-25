
local buamshqxim = fk.CreateSkill {
  name = "buamshqxim",
}

Fk:loadTranslationTable{
  ["buamshqxim"] = "梵音",
  [":buamshqxim"] = "主旹,伱可預弃x不同類牌指定x角色發動.爲所所角色附加昏睡",

  ["#buamshqxim"] = "梵音：x不同類牌指定x角色",

  ["$buamshqxim1"] = "昰細巧手段如何。",
  ["$buamshqxim2"] = "粗中有細",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

buamshqxim:addEffect("active", {
  anim_type = "control",
  prompt = function(self, player)
    return "#buamshqxim:::"..player:getLostHp()
  end,
  min_card_num = 2,
  min_target_num = 1,
  -- max_target_num = 2,
  max_phase_use_time=1,
  -- can_use = function(self, player)
  --   return player:usedSkillTimes(buamshqxim.name, Player.HistoryPhase) == 0
  -- end,
  card_filter = function(self,player,to_select, selected)
    return       
    table.every(selected, function (id)
      local name=Fk:getCardById(to_select).name
      return    
      -- S.getCardTypeByName(to_select)~=S.getCardTypeByName(id)
      -- Fk:getCardById(to_select).name == Fk:getCardById(id).name
      S.compareCardType(name,Fk:getCardById(id).name, true,true)
    end)
  end,
  target_filter = function(self, player, to_select, selected, selected_cards)
    return #selected<#selected_cards and to_select~=player
  end,
  -- feasible = function (self, player, selected, selected_cards)
  -- end,
  on_use = function(self, room, effect)
    local player=effect.from
    room:throwCard(effect.cards, buamshqxim.name, player,player)
    for _, p in ipairs(effect.tos) do
      if not p.dead then
      S.addTsziukzzyitBuff(p,  "hsoondzzyes",player)
      end
    end
  end,
})

return buamshqxim
