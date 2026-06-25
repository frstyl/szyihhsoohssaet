local coosdoavh = fk.CreateSkill {
  name = "coosdoavh",
  tags = { Skill.Wake,Skill.Compulsory,Skill.Limited },
}

Fk:loadTranslationTable{
  ["coosdoavh"] = "悟道",
  [":coosdoavh"] = "自限,擁有技能溷元.鎖定.輪終旹,若伱熵大于本局游戲角色數,必發.",

  ["$coosdoavh1"] = "时机已到，今日起兵！",
  ["$coosdoavh2"] = "欲取天下，当在此时！"
}

coosdoavh:addEffect(fk.RoundEnd, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(coosdoavh.name) 
    and  player:usedSkillTimes(coosdoavh.name, Player.HistoryGame) == 0
  end,
  can_wake = function(self, event, target, player, data)  --
    return #player:getPile("hzoonscuan_sziac") > #player.room.players
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:changeMaxHp(player, -1)
    room:handleAddLoseSkills(player, "khoucqmoon")
    if player.dead then return end
    local choices = {"draw2"}
    if player:isWounded() then
      table.insert(choices, "recover")
    end
    local choice = room:askToChoice(player, {
      choices = choices,
      skill_name = coosdoavh.name
    })
    if choice == "draw2" then
      player:drawCards(3, coosdoavh.name)
    else
      room:recover{
        who = player,
        num = 1,
        recoverBy = player,
        skillName = coosdoavh.name,
      }
    end
    if player.dead then return end

  end,
})

return coosdoavh
