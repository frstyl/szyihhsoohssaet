local muohtshiac_acitve = fk.CreateSkill {
  name = "muohtshiac_acitve",
}
Fk:loadTranslationTable{
  ["muohtshiac_acitve"] = "muohtshiac_acitve",
  [":muohtshiac_acitve"] = "muohtshiac_acitvew",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

muohtshiac_acitve:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "ssaet",
  prompt = "#muohtshiac_acitve",
  mute_card = true,
  handly_pile = false,
  card_filter = function(self, player, to_select, selected)
    return true
  end,
  view_as = function(self, player, cards)
    if #cards == 0 then return end
    local c = Fk:cloneCard("ssaet")
    c.skillName = "muohtshiac"
    c:addSubcards(cards)
    S.mixCard(c)
    return c
  end,
  enabled_at_play = Util.TrueFunc,
  enabled_at_response = function(self, player, response) 
    return  not response 
  end,
})


return muohtshiac_acitve
