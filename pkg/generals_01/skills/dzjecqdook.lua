local dzjecqdook = fk.CreateSkill{
  name = "dzjecqdook",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["dzjecqdook"] = "情毒",
  [":dzjecqdook"] = "伱其它角色主致傷後,伱可發動:伱爲其附加疢毒",

  ["#dzjecqdook-invoke"] = "情毒 是否對 %src發動",

  ["$dzjecqdook1"] = "我欲行夏禹旧事，为天下人。",

}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

dzjecqdook:addEffect(fk.Damage, {
  anim_type = "drawcard",
  can_trigger = function (self, event, target, player, data)
    return target==player and player:hasSkill(dzjecqdook.name) and not data.to.dead 
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = dzjecqdook.name,
      prompt = "#dzjecqdook-invoke:"..data.to.id,
    })
  end,
  on_use = function (self, event, target, player, data)
    S.addTsziukzzyitBuff(data.to,  "tthxinsdook",player)
  end,
})



return dzjecqdook
