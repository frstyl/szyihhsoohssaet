local loucssjecs = fk.CreateSkill{
  name = "loucssjecs",
  -- tags = { Skill.Compulsory },
  related_skills={"tsziukzzyit_tssiostsziuk"},
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{
  ["loucssjecs"] = "弄性",
  [":loucssjecs"] = "其它脚色挩離後,若其存活,伱可發動,伱爲其附加咒術｢詛咒｣",

  ["#loucssjecs-invoke"] = "弄性 是否對 %src發動",

  ["$loucssjecs1"] = "我欲行夏禹旧事，为天下人。",

}

loucssjecs:addEffect(fk.AfterDying, {
  anim_type = "drawcard",
  can_trigger = function (self, event, target, player, data)
    return target~=player and player:hasSkill(loucssjecs.name) and not target.dead
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = loucssjecs.name,
      prompt = "#loucssjecs-invoke:"..target.id,
    })
  end,
  on_use = function (self, event, target, player, data)
    S.addTsziukzzyitBuff(target,"tssiostsziuk",player)
  end,
})



return loucssjecs
