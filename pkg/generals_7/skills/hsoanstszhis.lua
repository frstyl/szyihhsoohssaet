local hsoanstszhis = fk.CreateSkill {
  name = "hsoanstszhis",
}

Fk:loadTranslationTable{
  ["hsoanstszhis"] = "熯熾",
  [":hsoanstszhis"] = "➀伱可將紅色非基本轉化爲火攻使用發動.使用前,伱抽2", --➁伱使用火攻旹可發動,伱抽2

  ["#hsoanstszhis"] = "熯熾：將紅色非基本轉化爲火攻使用",

  ["$hsoanstszhis1"] = "東風起大火生。",
  ["$hsoanstszhis2"] = "以火噟敵 賊人何處逃竄",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

hsoanstszhis:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "hsvoah_kouc",
  prompt = "#hsoanstszhis",
  handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and Fk:getCardById(to_select).color == Card.Red 
    and S.getCardTypeByName(Fk:getCardById(to_select).trueName)~=1
  end,
  before_use = function(self, player, use)
    player:drawCards(2, hsoanstszhis.name)
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then return end
    local card = Fk:cloneCard("hsvoah_kouc")
    card.skillName = hsoanstszhis.name
    card:addSubcard(cards[1])
    return card
  end,
})

-- hsoanstszhis:addEffect(fk.CardUsing, {
--   anim_type = "drawcard",
--   can_trigger = function(self, event, target, player, data)
--     return target == player and player:hasSkill(hsoanstszhis.name) and
--       data.card.name=="hsvoah_kouc"
--   end,
--   on_use = function(self, event, target, player, data)
--     player:drawCards(2, hsoanstszhis.name)
--   end,
-- })

return hsoanstszhis
