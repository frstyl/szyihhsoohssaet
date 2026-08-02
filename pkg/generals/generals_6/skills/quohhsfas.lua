local quohhsfas = fk.CreateSkill {
  name = "quohhsfas",
}

Fk:loadTranslationTable{
  ["quohhsfas"] = "羽化",
  [":quohhsfas"] = "一腳色進入瀕死旹,伱可發動.其占卜,若占卜牌爲为<font color='red'>♥</font>，其體力回至1",

}

quohhsfas:addEffect(fk.EnterDying, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(quohhsfas.name)
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local judge = {
      who = target,
      reason = quohhsfas.name,
      pattern = ".|.|heart",
    }
    room:judge(judge)
    if judge:matchPattern() and target:isWounded() and not target.dead then
      room:recover{
        who = target,
        num = 1-player.hp,
        recoverBy = player,
        skillName = quohhsfas.name,
      }
    end

  end,
})

return quohhsfas
