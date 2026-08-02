local thoeomqdzoeoj = fk.CreateSkill({
  name = "thoeomqdzoeoj",
  tags = {Skill.Compulsory},
})

Fk:loadTranslationTable{
  ["thoeomqdzoeoj"] = "貪財",
  [":thoeomqdzoeoj"] = "伱撤段始旹,必動,伱抽x+1,肰後伱可流失1體力且本局畱牌數+1",
  ["#thoeomqdzoeoj-loseHp"] = "貪財：是否流失體力",

  -- ["$thoeomqdzoeoj1"] = "皓月如晝共椉歡爭忍歸來",
  -- ["$thoeomqdzoeoj2"] = "瓊林玉殿朝喧弦管暮列笙琶",
}


thoeomqdzoeoj:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(thoeomqdzoeoj.name) and player.phase == Player.Discard 
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local drawers = {}
    player:drawCards(1+player:getLostHp(),thoeomqdzoeoj.name)
    if room:askToSkillInvoke(player, { skill_name = thoeomqdzoeoj.name ,prompt="#thoeomqdzoeoj-loseHp"}) then
      room:loseHp(player,1,thoeomqdzoeoj.name,player)
      -- room:addPlayerMark(player, MarkEnum.AddMaxCardsInTurn, 2*player:getLostHp())
      room:addPlayerMark(player, MarkEnum.AddMaxCards, 1)
    end
  end,
})


return thoeomqdzoeoj
