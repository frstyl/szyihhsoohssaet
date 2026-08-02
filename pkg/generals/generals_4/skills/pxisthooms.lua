local pxisthoeoms = fk.CreateSkill {
  name = "pxisthoeoms",
}

Fk:loadTranslationTable{
["pxisthoeoms"] = "祕探",
[":pxisthoeoms"] = "段限1.伱可將1手牌轉化爲探察起動發動",

["#pxisthoeoms"] = "祕探 將1手牌轉化爲探察起動",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

pxisthoeoms:addEffect("viewas", {--視爲起動? 起動虛牌?
  anim_type = "defensive",
  pattern = "thoeoms_tsshaet",  --
  prompt = "#pxisthoeoms",
  mute_card = true,
  -- handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and table.contains(player:getCardIds("h"),to_select)
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then
      return nil
    end
    local c = Fk:cloneCard("thoeoms_tsshaet")
    c.skillName = pxisthoeoms.name
    c:addSubcards(cards)
    S.mixCard(c)
    return c
  end,
  enabled_at_play = function(self, player)
    return  player:usedSkillTimes(pxisthoeoms.name, Player.HistoryTurn) == 0
  end,
  enabled_at_response = function(self, player, response)
    return  player:usedSkillTimes(pxisthoeoms.name, Player.HistoryTurn) == 0
  end,
})



return pxisthoeoms
