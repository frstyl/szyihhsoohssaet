local tszjecsprac = fk.CreateSkill {
  name = "tszjecsprac",
}
Fk:loadTranslationTable{
  ["tszjecsprac"] = "正兵",
  [":tszjecsprac"] = "伱可使用護{閃/防患未肰}旹,伱可轉化1牌使用發動",

  ["$tszjecsprac1"] = "今进退两难，势若蝕骨，魏王必当罢兵而还。",
  ["$tszjecsprac2"] = "汝可令士卒收拾行装，魏王明日必定退兵。",
}

tszjecsprac:addEffect("viewas", {
  anim_type = "defensive",
  pattern = "szjemh,buac_hzfan_mujs_nzjen",
  prompt = "#tszjecsprac",
  handly_pile = true,
  interaction = function(self, player)
    local all_names = {"hand__szjemh", "hand__buac_hzfan_mujs_nzjen"}
    local names = player:getViewAsCardNames(tszjecsprac.name, all_names)
    return UI.CardNameBox {choices = names, all_choices = all_names }

  end,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 
    -- and Fk:getCardById(to_select).color == Card.Black 
    -- and table.contains(player:getHandlyIds(), to_select)
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 or not self.interaction.data then return nil end
    local c = Fk:cloneCard(self.interaction.data)
    c.skillName = tszjecsprac.name
    c:addSubcard(cards[1])
    return c
  end,
  enabled_at_response = function(self, player, response) 
    return  not response 
  end,
})

return tszjecsprac
