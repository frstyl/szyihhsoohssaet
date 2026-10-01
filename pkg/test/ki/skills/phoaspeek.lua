local phoaspeek = fk.CreateSkill {
  name = "phoaspeek",
}

Fk:loadTranslationTable{
  ["phoaspeek"] = "破壁",
  [":phoaspeek"] = "印牌:釜底抽薪",


}
local S = require "packages/szyihhsoohssaet/szyih_guos"


phoaspeek:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "buoh_teejh_tthiu_sjin", 
  prompt = "#phoaspeek-active",
  mute_card = true,
  handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return table.every(selected,function(id) return Fk:getCardById(to_select).package~=Fk:getCardById(id).package or Fk:getCardById(id).package==nil end)
  end,
  view_as = function(self, player, cards)
    if #cards == 0 then return end
    local c = Fk:cloneCard("buoh_teejh_tthiu_sjin")
    c.skillName = phoaspeek.name
    c:addSubcards(cards)
    S.mixCard(c)
    return c
  end,
  enabled_at_response = function(self, player, response)
    return  not response
  end,
})


phoaspeek:addEffect("targetmod", {
  extra_target_func = function(self, player, skill, card)
    if card and card.skillNames and table.contains(card.skillNames, phoaspeek.name) then
      return #card.subcards-1
    end
  end,
})
return phoaspeek
