Fk:loadTranslationTable{
  ["gracqthoop"] = "擎塔",
  [":gracqthoop"] = "輪限1.當一牌指定目幖後,若使用者不爲伱且目幖數大于1,伱可發動.伱流失1體力.此牌使用无效,伱獲得此牌",

  ["#gracqthoop-choose"] = "擎塔：你可以令此%arg对任意个目标无效",

  ["$gracqthoop1"] = "奋勇当先，威名远扬！",
  ["$gracqthoop2"] = "哼！敢欺我东吴无人。",
}

local gracqthoop = fk.CreateSkill{
  name = "gracqthoop",
  -- tags = { Skill.Limited },
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

gracqthoop:addEffect(fk.TargetSpecified, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(gracqthoop.name) 
    and
      data.firstTarget   --問1次
      and #data.use.tos > 1 and
      player:usedSkillTimes(gracqthoop.name, Player.HistoryRound) == 0
  end,

  on_use = function(self, event, target, player, data)
    player.room:loseHp(player,1,gracqthoop.name)
    S.useNullify(data.use)
    if player.dead then return end
    player.room:obtainCard(player, data.card, true, fk.ReasonPrey, player, gracqthoop.name)
  end,
})

return gracqthoop
