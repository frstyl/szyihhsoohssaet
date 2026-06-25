local extension = Package:new("draw_cards_number", Package.CardPack)
extension.extensionName = "szyihhsoohssaet"
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/rule/draw_cards_number/skills")

Fk:loadTranslationTable{
["draw_cards_number"] = "單次抽牌數上限",

["draw_cards"] = "單次抽牌數",
[":draw_cards"] = "單效果單次抽牌數至多爲5,多效果同旹抽牌每效果至多+5",
}

--
local draw_cards = fk.CreateCard{
  name = "&draw_cards",  
  type = Card.TypeBasic,
  -- skill = "draw_cards_skill",
  -- is_passive = true, 
}


extension:loadCardSkels {
draw_cards,
}
extension:addCardSpec("draw_cards")--
--

return extension

