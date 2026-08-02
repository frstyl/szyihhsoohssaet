local ttxenhszjes = fk.CreateSkill {
  name = "ttxenhszjes",
  tags={Skill.Limited, Skill.Wake, Skill.Compulsory, Skill.Permanent}
}

Fk:loadTranslationTable{
  ["ttxenhszjes"] = "展翅",
  [":ttxenhszjes"] = "每局限1.伱轉始旹,伱可發動.伱廢除伏區裝僃區,抽2,獲得技能<a href=':doeocqpuj'>騰飛</a>",  --持恆技!!

  ["#ttxenhszjes-invoke:"] = "展翅 是否起飛",

  ["$ttxenhszjes1"] = "迦樓羅 緟生",
}

ttxenhszjes:addEffect(fk.TurnStart, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return  target==player    and player:hasSkill(ttxenhszjes.name) 
    and player:usedSkillTimes(ttxenhszjes.name, Player.HistoryGame) == 0
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = ttxenhszjes.name,
      prompt = "#ttxenhszjes-invoke:",
    }) 
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local eqipSlots = player:getAvailableEquipSlots()
    if not table.contains(player.sealedSlots, Player.JudgeSlot) then
      table.insert(eqipSlots, Player.JudgeSlot)
    end
    room:abortPlayerArea(player, eqipSlots)
    player:drawCards(2,ttxenhszjes.name)
    room:handleAddLoseSkills(player, "doeocqpuj")
  end,
})

return ttxenhszjes
