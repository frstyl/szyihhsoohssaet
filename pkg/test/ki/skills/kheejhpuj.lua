local kheejhpuj = fk.CreateSkill {
  name = "kheejhpuj",
  tags={Skill.Limit}
}

Fk:loadTranslationTable{
  ["kheejhpuj"] = "啓飛",--啓飛
  [":kheejhpuj"] = "局限1｡一脚色死亾後/轉終旹,伱可發動｡伱執行1額外轉",

  ["#kheejhpuj-invoke"] = "啓飛：是否執行額外轉？",
}

local spec = {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(kheejhpuj.name)
    and player:usedEffectTimes(kheejhpuj.name, Player.HistoryGame) == 0
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = kheejhpuj.name,
      prompt = "#kheejhpuj-invoke",
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    player:gainAnExtraTurn(false, kheejhpuj.name)
  end,
}

kheejhpuj:addEffect(fk.Deathed, spec)
kheejhpuj:addEffect(fk.TurnEnd, spec)


return kheejhpuj
