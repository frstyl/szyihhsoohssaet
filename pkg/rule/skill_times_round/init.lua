local extension = Package:new("skill_times_round", Package.CardPack)
extension.extensionName = "szyihhsoohssaet"
extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/rule/skill_times_round/skills")


Fk:loadTranslationTable{
["skill_times_round"] = "每輪技能可用次數",

  
["skill_times"] = "每輪技能發動次數",
[":skill_times"] = "每角色每非鎖定技每輪限發動5次.到达數後技能失效.包括裝僃技能,武將牌技能,衍生技能",
}

local skill_times = fk.CreateCard{
  name = "&skill_times",  
  type = Card.TypeBasic,
  -- skill = "khouc",
  -- is_passive = true, 
}


extension:loadCardSkels {
skill_times,
}
extension:addCardSpec("skill_times")--
--


return extension

