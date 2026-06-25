local leechjiak = fk.CreateSkill{
  name = "leechjiak",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["leechjiak"] = "冷藥",
  [":leechjiak"] = "其它角色主段終旹,若其當轉未因使用殺而致傷,伱可發動:伱爲其附加溷亂",

  ["#leechjiak-invoke"] = "冷藥 是否對 %src發動",

  ["$leechjiak1"] = "我欲行夏禹旧事，为天下人。",

}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

leechjiak:addEffect(fk.TurnStart, {
  anim_type = "drawcard",
  can_trigger = function (self, event, target, player, data)
    return target~=player and player:hasSkill(leechjiak.name) and not target.dead and S.hasTsziukzzyit(target)
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = leechjiak.name,
      prompt = "#leechjiak-invoke:"..target.id,
    })
  end,
  on_use = function (self, event, target, player, data)
    S.addTsziukzzyitBuff(target,  "dzjecshsfas",player)
  end,
})



return leechjiak
