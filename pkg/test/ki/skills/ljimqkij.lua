local ljimqkij = fk.CreateSkill {
  name = "ljimqkij",
}

Fk:loadTranslationTable{
  ["ljimqkij"] = "臨機",
  [":ljimqkij"] = "伱可將牌轉化爲其同子類牌起動或演練",


  ["$ljimqkij1"] = "承吾父之勇，翊军立阵。",
  ["$ljimqkij2"] = "继先帝之志，季兴大汉。",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

ljimqkij:addEffect("viewas", {
  pattern = ".",
  prompt = "#ljimqkij1",
  interaction = function(self, player)
    local all_names = Fk:getAllCardNames("btde")
    local names = player:getViewAsCardNames(ljimqkij.name, all_names)
    if #names == 0 then return end
    return UI.CardNameBox {choices = names, all_choices = all_names}
  end,
  handly_pile = true,
  -- filter_pattern = function (self, player, card_name, selected)
  --     return {
  --       min_num = 1,
  --       max_num = 1,
  --       pattern = ".|.|.|.|.|basic",
  --     }
  -- end,
  card_filter = function(self, player, to_select, selected)
    if not self.interaction.data then return end
    return #selected==0 and S.compareCardSubType(self.interaction.data,Fk:getCardById(to_select).trueName)
  end,
  view_as = function(self, player, cards)
    if not self.interaction.data then return end
    if #cards ~= 1 then return end

    local card = Fk:cloneCard(self.interaction.data)
    card:addSubcards(cards)
    S.mixCard(c)
    card.skillName = ljimqkij.name
    return card
  end,
})

return ljimqkij
