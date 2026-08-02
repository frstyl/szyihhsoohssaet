local ssuoszzyit = fk.CreateSkill {
  name = "ssuoszzyit",
}
Fk:loadTranslationTable{
  ["ssuoszzyit"] = "數術",
  [":ssuoszzyit"] = "印牌:以伱2牌(點數合爲𦃃數)轉化起動一卽旹牌(法術事件除外)｡伱抽2",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

local isPrimeNumber=function(n)
  local set={2,3,5,7,11,13,17,19,23,29,
  31,37,41,43,47,53,59,61,67,
  71,73,79,83,89,97}
  return table.contains(set, n)
end
ssuoszzyit:addEffect("viewas", {
  anim_type = "offensive",
  pattern = ".",
  prompt = "#ssuoszzyit",
  mute_card = true,
  handly_pile = true,
  interaction = function(self, player)
    local all_names =  table.filter(Fk:getAllCardNames("b"), function(name)
      local n =S.getCardTypeByName(name)
      return n ==1 or n==2
    end)
    local names = player:getViewAsCardNames(ssuoszzyit.name, all_names)
    if #names == 0 then return end
    return UI.CardNameBox {choices = names, all_choices = all_names}
  end,
  card_filter = function(self, player, to_select, selected)
    return #selected < 2
  end,
  view_as = function(self, player, cards)
    if #cards ~=2 then return end
    local n =Fk:getCardById(cards[1]).number+Fk:getCardById(cards[2]).number
    if not isPrimeNumber(n) then return end
    local card = Fk:cloneCard(self.interaction.data)
    card:addSubcards(cards)
    S.mixCard(c)
    card.skillName = ssuoszzyit.name
    return card
  end,
  before_use = function(self, player, use)
   player:drawCards(1,ssuoszzyit.name)
  end,
  enabled_at_play = Util.TrueFunc,
  enabled_at_response = function(self, player, response) 
    return  not response 
  end,
  enabled_at_nullification = function(self, player, data)
    if not self:enabledAtResponse(player, false) then return end

    local all_names =  table.filter(Fk:getAllCardNames("b"), function(name)
      local n =S.getCardTypeByName(name)
      return n ==1 or n==2
    end)
    local names = player:getViewAsCardNames(ssuoszzyit.name, all_names)
    if #names == 0 then return end

    return true
  end,
})

return ssuoszzyit
