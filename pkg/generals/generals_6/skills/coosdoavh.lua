local coosdoavh = fk.CreateSkill {
  name = "coosdoavh",
  tags = { Skill.Wake,Skill.Compulsory,Skill.Limited },
  related_skills={"khoucqmoon","meecqhsiach","lyithzoeoc"},  --"sziacqtsoeoc"
}

Fk:loadTranslationTable{
  ["coosdoavh"] = "悟道",
  [":coosdoavh"] = "自限:擁有技能｢溷元｣.局限1,一轉終旹,若伱熵大于其局游戲脚色數,必發.伱自下選擇獲得2个技能｢空門｣｢冥響｣｢律恆｣",
  ["#coosdoavh-skill"] = "悟道 選擇",

  ["$coosdoavh1"] = "时机已到，今日起兵！",
  ["$coosdoavh2"] = "欲取天下，当在此时！"
}

coosdoavh:addEffect(fk.TurnEnd, {
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(coosdoavh.name) 
    and  player:usedSkillTimes(coosdoavh.name, Player.HistoryGame) == 0
  end,
  can_wake = function(self, event, target, player, data)  --
    return #player:getPile("hzoonscuan_sziac") > #player.room.players
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local skill_name = room:askToChoice(player, {
        choices = {"khoucqmoon","meecqhsiach","lyithzoeoc"}, 
        all_choices=all_choices,
        skill_name = coosdoavh.name, 
        prompt = "#coosdoavh-skill" ,
        detailed=true,
      })
    room:changeMaxHp(player, -1)

    room:handleAddLoseSkills(player, skill_name)

    -- if player.dead then return end
    -- local choices = {"draw2"}
    -- if player:isWounded() then
    --   table.insert(choices, "recover")
    -- end
    -- local choice = room:askToChoice(player, {
    --   choices = choices,
    --   skill_name = coosdoavh.name
    -- })
    -- if choice == "draw2" then
    --   player:drawCards(3, coosdoavh.name)
    -- else
    --   room:recover{
    --     who = player,
    --     num = 1,
    --     recoverBy = player,
    --     skillName = coosdoavh.name,
    --   }
    -- end
    -- if player.dead then return end

  end,
})

return coosdoavh
