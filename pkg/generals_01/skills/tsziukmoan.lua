local tsziukmoan = fk.CreateSkill{
  name = "tsziukmoan",
  -- tags = { Skill.Compulsory },
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{
  ["tsziukmoan"] = "咒謾",
  [":tsziukmoan"] = "其它角色挩離瀕死被救回後,伱可發動,伱爲其附加詛咒",

  ["#tsziukmoan-invoke"] = "咒謾 是否對 %src發動",

  ["$tsziukmoan1"] = "我欲行夏禹旧事，为天下人。",

}

tsziukmoan:addEffect(fk.AfterDying, {
  anim_type = "drawcard",
  can_trigger = function (self, event, target, player, data)
    return target~=player and player:hasSkill(tsziukmoan.name) and not target.dead
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = tsziukmoan.name,
      prompt = "#tsziukmoan-invoke:"..target.id,
    })
  end,
  on_use = function (self, event, target, player, data)
    S.addTsziukzzyitBuff(target,"tssiostsziuk",player)
  end,
})



return tsziukmoan
