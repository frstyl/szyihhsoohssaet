local toeocqsjen = fk.CreateSkill {
  name = "toeocqsjen",
}

Fk:loadTranslationTable{
  ["toeocqsjen"] = "登仙",
  [":toeocqsjen"] = "當伱進入瀕死,伱可發動.伱判定,若結果爲为<font color='red'>♥</font>，伱體力回至1,抽2,體力上限+1",

}

toeocqsjen:addEffect(fk.EnterDying, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(toeocqsjen.name)
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local judge = {
      who = target,
      reason = toeocqsjen.name,
      pattern = ".|.|heart",
    }
    room:judge(judge)
    if judge:matchPattern() and target:isWounded() and not target.dead then
      room:recover{
        who = target,
        num = 1-player.hp,
        recoverBy = player,
        skillName = toeocqsjen.name,
      }
      if not player.dead then
        player:drawCards(2,toeocqsjen.name)
      end
      room:changeMaxHp(player,1)
    end

  end,
})

return toeocqsjen
