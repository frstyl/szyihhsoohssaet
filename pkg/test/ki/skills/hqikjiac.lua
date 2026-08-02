local hqikjiac = fk.CreateSkill{
  name = "hqikjiac",
  tags={Skill.Switch},
}

Fk:loadTranslationTable{
  ["hqikjiac"] = "抑揚",  --獨奏 合奏 閒奏
  [":hqikjiac"] = "輪流發動｡伱起動演練牌旹,若此牌較伱(當轉內且有此技能期)上一起動演練牌點數{➀高/➁低},伱抽1(无牌无點視爲0點)",  --



}


-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

local spec ={
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(hqikjiac.name)
    and 
    (data.card.number>player:getMark("@hqikjiac-turn") and player:getSwitchSkillState(hqikjiac.name)==0
  or (data.card.number<player:getMark("@hqikjiac-turn") and player:getSwitchSkillState(hqikjiac.name)==1)
  )
  end,

  on_use = function(self, event, target, player, data)
    player:drawCards(1,hqikjiac.name)
  end,
  late_refresh=true,
  can_refresh = function(self, event, target, player, data)
    return target==player and player:hasSkill(hqikjiac.name,false,true)
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:setPlayerMark(player,"@hqikjiac-turn",data.card.number)
  end,
}

hqikjiac:addEffect(fk.CardUsing, spec)
hqikjiac:addEffect(fk.CardResponding, spec)

return hqikjiac
