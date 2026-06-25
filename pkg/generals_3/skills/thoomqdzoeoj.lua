local thoomqdzoeoj = fk.CreateSkill({
  name = "thoomqdzoeoj",
  tags = {Skill.Compulsory},
})

Fk:loadTranslationTable{
  ["thoomqdzoeoj"] = "貪財",
  [":thoomqdzoeoj"] = "鎖定｡伱撤段始旹,必動,伱抽x+1,肰後伱可流失1體力且本局畱牌數+1",
  ["#thoomqdzoeoj-loseHp"] = "貪財：是否失去體力",

  -- ["$thoomqdzoeoj1"] = "皓月如晝共椉歡爭忍歸來",
  -- ["$thoomqdzoeoj2"] = "瓊林玉殿朝喧弦管暮列笙琶",
}


thoomqdzoeoj:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(thoomqdzoeoj.name) and player.phase == Player.Discard 
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local drawers = {}
    player:drawCards(1+player:getLostHp(),thoomqdzoeoj.name)
    if room:askToSkillInvoke(player, { skill_name = thoomqdzoeoj.name ,prompt="#thoomqdzoeoj-loseHp"}) then
      room:loseHp(player,1,thoomqdzoeoj.name)
      -- room:addPlayerMark(player, MarkEnum.AddMaxCardsInTurn, 2*player:getLostHp())
      room:addPlayerMark(player, MarkEnum.AddMaxCards, 1)
    end
  end,
})


return thoomqdzoeoj
