local biuknzjen = fk.CreateSkill {
  name = "biuknzjen",
  tags={Skill.Compulsory}
}

Fk:loadTranslationTable{

["biuknzjen"] = "復燃", --返生
[":biuknzjen"] = "輪始旹,若伱已死,必發,伱復活:體力爲1,抽2,",--<br/>"..

["#biuknzjen-ask"] = "復燃 選擇1取得",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

biuknzjen:addEffect(fk.RoundStart, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    if   player:hasSkill(biuknzjen.name,true,true) and player.dead   then return  true end
  end,

  on_use = function(self, event, target, player, data)
    S.revive({
    who=player,
    recoverHp=1,
    drawN=2,
    skill=biuknzjen.name,
    from=player,
  })
  end,
})



return biuknzjen
