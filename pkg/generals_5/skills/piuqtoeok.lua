local piuqtoeok = fk.CreateSkill {
  name = "piuqtoeok",
  tags = { Skill.Limited },
}

Fk:loadTranslationTable {
  ["piuqtoeok"] = "不得",
  [":piuqtoeok"] = "每局限1.其它角色A死亾亮出身分前,若伱与其身分皆不公開,伱可發動,伱抽1,与A交換身分牌",

  ["#piuqtoeok-invoke"] = "不得：与 %dest 交换身分！",

  ["$piuqtoeok1"] = "跟我師兄一夜 勝于跟伱十秊",
  ["$piuqtoeok2"] = "我嫁給伱两秊，還不如跟我师兄两夜快活",
}

piuqtoeok:addEffect(fk.BeforeGameOverJudge, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(piuqtoeok.name) 
    and player:usedSkillTimes(piuqtoeok.name, Player.HistoryGame) == 0 
    and player.role ~= "lord" and target.role ~= "lord"  --1v2 2v2 3v3?
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = piuqtoeok.name,
      prompt = "#piuqtoeok-invoke::"..target.id
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    player:drawCards(1,piuqtoeok.name)
    player.role, target.role = target.role, player.role
    room:broadcastProperty(player, "role")
    room:broadcastProperty(target, "role")
  end,
})

return piuqtoeok
