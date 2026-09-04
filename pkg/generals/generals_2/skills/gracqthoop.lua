Fk:loadTranslationTable{
  ["gracqthoeop"] = "擎塔",
  [":gracqthoeop"] = "輪限1.一牌起動效果結算前,若起動者不爲伱且目幖數大于1,伱可發動.伱流失1.此牌起動无效,伱取得此牌(子牌)",

  ["#gracqthoeop-choose"] = "擎塔：你可以令此%arg对多个目标无效",

  ["$gracqthoeop1"] = "｡｡｡",

}

local gracqthoeop = fk.CreateSkill{
  name = "gracqthoeop",
  -- tags = { Skill.Limited },
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

gracqthoeop:addEffect(fk.BeforeCardUseEffect, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(gracqthoeop.name) 
    and #data.tos > 1 and
      player:usedSkillTimes(gracqthoeop.name, Player.HistoryRound) == 0
  end,

  on_use = function(self, event, target, player, data)
    player.room:loseHp(player,1,gracqthoeop.name,player)
    S.useNullify(data.use)
    if player.dead then return end
    player.room:obtainCard(player, data.card, true, fk.ReasonPrey, player, gracqthoeop.name)
  end,
})

return gracqthoeop
