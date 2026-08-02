
Skill.NotViewAs="NotViewAs"
local gyihdoos = fk.CreateSkill {
  name = "gyihdoos",
  tags={Skill.NotViewAs}
}

Fk:loadTranslationTable{
["gyihdoos"] = "揆度",
[":gyihdoos"] = "伱可起動牌旹,伱可發動,伱抽1",


}

local S = require "packages/szyihhsoohssaet/szyih_guos" 





-- gyihdoos:addEffect(fk.AskForCardUse, {
--   can_trigger = function(self, event, target, player, data)
--     return  target == player and
--     player:hasSkill(gyihdoos.name) 
--     -- and Exppattern:Parse(data.pattern):matchExp("szjemh|0|nosuit|none") 
--     -- -- and not player:prohibitUse(Fk:cloneCard("szjemh"))
--     -- and not target:prohibitUse(Fk:cloneCard("szjemh"))
--   end,
--   on_use = function(self, event, target, player, data)
--     player:drawCards(1,gyihdoos.name)
--   end,
-- })


gyihdoos:addEffect("viewas", {
  anim_type = "offensive",
  pattern = ".",
  prompt = "#gyihdoos",
  mute_card = true,
  handly_pile = true,
  view_as = function(self, player, cards)
    return nil
  end,
  -- target_filter = function(self, player, to_select, selected, selected_cards, c, extra_data)
  --   return to_select~=player and #selected==0
  -- end,
  feasible = function(self, player, selected, selected_cards, card)
    -- return #selected == 1
    return true
  end,
  on_use = function(self, room, cardUseEvent, _, params)
    local player = cardUseEvent.from
    player:drawCards(1,gyihdoos.name)
    return gyihdoos.name
  end,
  enabled_at_play = function(self, player)
    return player:usedEffectTimes(gyihdoos.name, Player.HistoryPhase) == 0 --主段无法讀記錄
  end,
  enabled_at_response = function(self, player, response) 
    return  not response 
  end,
  enabled_at_nullification = function (self, player, data)
    return true
  end,
})

return gyihdoos
