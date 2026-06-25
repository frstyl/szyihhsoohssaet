local khitdzjec = fk.CreateSkill{
  name = "khitdzjec",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["khitdzjec"] = "乞情",
  [":khitdzjec"] = "其它角色受傷後,伱可發動:伱爲其附加 𡴘運",

  ["#khitdzjec-invoke"] = "乞情 是否對 %src發動",

  ["$khitdzjec1"] = "我欲行夏禹旧事，为天下人。",

}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

khitdzjec:addEffect(fk.Damaged, {
  anim_type = "drawcard",
  can_trigger = function (self, event, target, player, data)
    return target~=player and player:hasSkill(khitdzjec.name) and not target.dead
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = khitdzjec.name,
      prompt = "#khitdzjec-invoke:"..target.id,
    })
  end,
  on_use = function (self, event, target, player, data)
    S.addTsziukzzyitBuff(target,  "hzaechquns",player)
  end,
})



return khitdzjec
