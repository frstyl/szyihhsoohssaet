local tsjecqsvoans = fk.CreateSkill {
  name = "tsjecqsvoans",
}

Fk:loadTranslationTable{
  ["tsjecqsvoans"] = "精算",
  [":tsjecqsvoans"] = "當伱可使用1卽旹基本牌,伱可將x張手牌轉化之使用(需牌點數合爲13)發動,伱將手牌數補至x.",

  ["#tsjecqsvoans"] = "精算：選擇點數合爲13之牌",
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

tsjecqsvoans:addEffect("viewas", {
  pattern = ".|.|.|.|.|basic",
  prompt = "#tsjecqsvoans",
  interaction = function(self, player)
    local all_names = Fk:getAllCardNames("b")
    local names = player:getViewAsCardNames(tsjecqsvoans.name, all_names)
    if #names == 0 then return end
    return UI.CardNameBox { choices = names, all_choices = all_names }
  end,
  handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    if Fk:getCardById(to_select).number < 13 then
      local num = 0
      for _, id in ipairs(selected) do
        num = num + Fk:getCardById(id).number
      end
      return num + Fk:getCardById(to_select).number <= 13
    end
  end,
  view_as = function (self, player, cards)
    if #cards < 1 or self.interaction.data == nil then return end
    local num = 0
    for _, id in ipairs(cards) do
      num = num + Fk:getCardById(id).number
    end
    if num ~= 13 then return end
    local card = Fk:cloneCard(self.interaction.data)
    card:addSubcards(cards)
    card.skillName = tsjecqsvoans.name
    return card
  end,
  after_use = function (self, player, use)
    local n = #use.subcards-#player:getCardIds("h")
    if n >0 then
      player:drawCards(n,tsjecqsvoans.name)
    end
  end,
  enabled_at_response = function(self, player, response)
    return not response and #player:getViewAsCardNames(tsjecqsvoans.name, Fk:getAllCardNames("t")) > 0
  end,
})

return tsjecqsvoans
