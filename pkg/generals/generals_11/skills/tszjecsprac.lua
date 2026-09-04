local tszjecsprac = fk.CreateSkill {
  name = "tszjecsprac",
}
Fk:loadTranslationTable{
  ["tszjecsprac"] = "正兵",
  [":tszjecsprac"] = "印牌:展示暗置伱1{紅/黑}手牌起動虛擬{閃/防患未肰}",

  ["$tszjecsprac1"] = "待我擺个陣勢",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

tszjecsprac:addEffect("viewas", {
  anim_type = "defensive",
  pattern = "szjemh,buac_hzfan_mujs_nzjen",
  prompt = "#tszjecsprac",
  -- handly_pile = true,
  interaction = function(self, player)
    local all_names = {"hand__szjemh", "hand__buac_hzfan_mujs_nzjen"}
    local names = player:getViewAsCardNames(tszjecsprac.name, all_names)
    return UI.CardNameBox {choices = names, all_choices = all_names }

  end,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 
    and table.contains(player:getCardIds("h"), to_select)
    and  S.canSetVisible(to_select)
    and (
      (self.interaction.data =="hand__szjemh"  and Fk:getCardById(to_select).color == Card.Red )
      or  (self.interaction.data =="hand__buac_hzfan_mujs_nzjen"  and Fk:getCardById(to_select).color == Card.Black )
    )
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 or not self.interaction.data then return nil end
    local c = Fk:cloneCard(self.interaction.data)
    c.skillName = tszjecsprac.name
    -- c:addSubcard(cards[1])
    c:addFakeSubcard(cards[1])
    return c
  end,
  before_use = function (self, player, use)
    player.room:addSkill("openCards")
    local  card = Fk:getCardById(use.card.fake_subcards[1])
    player.room:showCards(cards,player,player)
    S.setCardsVisible(card)
  end,
  enabled_at_response = function(self, player, response) 
    return  not response 
    -- and not player:isKongcheng()
    and table.find(player:getCardIds("h"),function(id)
				return not Fk:getCardById(id):hasMark("@@opend")
			end
			)
  end,
  -- enabled_at_nullification = function(self, player) 
  --   return  enabled_at_response
  -- end,
})

return tszjecsprac
