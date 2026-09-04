
local ljerphioc = fk.CreateSkill{
  name = "ljerphioc",
}

Fk:loadTranslationTable{
  ["ljerphioc"] = "礪鋒",
  [":ljerphioc"] = "主旹无限次｡選擇1腳色發動,目幖腳色｢殺｣次數上限其局+1",

}

local S = require "packages/szyihhsoohssaet/szyih_guos"

ljerphioc:addEffect("active", {
  anim_type = "drawCards",
  prompt = "#ljerphioc",
  target_num = 1,
  card_num = 1,
  -- max_phase_use_time = 1,
  -- interaction = function(self, player)
  --   return UI.ComboBox {
  --     choices = {"damage","discard"},
  --   }
  -- end,
  card_filter = function(self, player, to_select, selected)

    local c=Fk:getCardById(to_select)
      return 
      -- not player:prohibitResponse(c) 
      -- and 
      c.suit~=Card.NoSuit
      and table.every(selected,function(id)
      return Fk:getCardById(id).suit~=c.suit
      end)
  end,
  target_filter = function(self, player, to_select, selected, selected_cards)
      return true
  end,
  card_filter = function(self, player, to_select, selected)
    local c=Fk:getCardById(to_select)
    return c.trueName=="ssaet"
  end,
  on_use = function(self, room, effect)
    S.playCard(effect.cards, ljerphioc.name,effect.from)
    for _,p in ipairs(effect.tos) do
      room:addPlayerMark(p,"ssaet_times",1)
    end
  end,
})

return ljerphioc
