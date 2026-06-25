local extension = Package:new("card_times_round", Package.CardPack)
extension.extensionName = "szyihhsoohssaet"
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/rule/card_times_round/skills")


Fk:loadTranslationTable{
["card_times_round"] = "每輪牌名可用次數",

["card_times_skill"] = "每輪牌使用次數",
["card_times"] = "每輪牌使用次數",
[":card_times"] = "每角色每牌名每輪限使用5次.到达次數後禁止使用.同名牌共用次數",
}

local card_times = fk.CreateCard{
  name = "&card_times",  
  type = Card.TypeBasic,
  -- skill = "card_times_skill",
  -- is_passive = true, 
}


extension:loadCardSkels {
card_times,
}
extension:addCardSpec("card_times")--


return extension

