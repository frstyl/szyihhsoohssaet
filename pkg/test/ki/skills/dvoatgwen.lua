
local dvoatgwen = fk.CreateSkill{
  name = "dvoatgwen",
}

Fk:loadTranslationTable{
  ["dvoatgwen"] = "奪權",
  [":dvoatgwen"] = "其它腳色死亾旹,若傷源不爲伱,伱可發動｡伱取得其全部牌,選擇其1技能獲得",

  ["#dvoatgwen-skill"] = "師眾 選擇 %src 技能",

  ["$dvoatgwen1"] = "",
  ["$dvoatgwen2"] = "",
}

dvoatgwen:addEffect(fk.Death, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(dvoatgwen.name)
    and not (data.damage and data.damage.from==player)
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    if not target:isNude() then
      room:obtainCard(player, target:getCardIds("he"), false, fk.ReasonPrey, player, dvoatgwen.name)
      if player.dead then return end
    end
    local    skills=table.filter(target:getSkillNameList(),function(skill_name)
    return Fk.skills[skill_name] 
    and not  Fk.skills[skill_name]:hasTag(Skill.Proprietary) 
    and not table.contains(player:getSkillNameList()) 
    end)
    if #skills==0 then return end
     local choice = room:askToChoice(player, {
      choices = skills,
      skill_name = dvoatgwen.name,
      prompt = "#dvoatgwen-skill::" .. to.id,
      detailed = true,
      cancelable=false,
    })
    room:handleAddLoseSkills(target, "-"..choice, nil, true, false)
    room:handleAddLoseSkills(player, choice, nil, true, false)
  end,
})


return dvoatgwen
