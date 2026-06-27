local pxisthooms = fk.CreateSkill {
  name = "pxisthooms",
}

Fk:loadTranslationTable{
["pxisthooms"] = "祕探",
[":pxisthooms"] = "段限1.伱可將1手牌轉化爲探聽使用發動",

["#pxisthooms"] = "祕探 將1手牌轉化爲探聽使用",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

pxisthooms:addEffect("viewas", {--視爲使用? 使用虛牌?
  anim_type = "defensive",
  pattern = "thooms_theec",  --
  prompt = "#pxisthooms",
  mute_card = true,
  -- handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and table.contains(player:getCardIds("h"),to_select)
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then
      return nil
    end
    local c = Fk:cloneCard("thooms_theec")
    c.skillName = pxisthooms.name
    c:addSubcards(cards)
    S.mixCard(c)
    return c
  end,
  enabled_at_play = function(self, player)
    return  player:usedSkillTimes(pxisthooms.name, Player.HistoryTurn) == 0
  end,
  enabled_at_response = function(self, player, response)
    return  player:usedSkillTimes(pxisthooms.name, Player.HistoryTurn) == 0
  end,
})



return pxisthooms
