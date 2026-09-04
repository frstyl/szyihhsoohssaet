local hzaavscxes = fk.CreateSkill {
  name = "hzaavscxes",
}

Fk:loadTranslationTable{
["hzaavscxes"] = "効義",
[":hzaavscxes"] = "伱受傷後可發動,伱抽x(x爲伱已損體力數)",


["#hzaavscxes-draw"]="効義 抽 %arg",

["$hzaavscxes1"] = "大丈夫爲國䀆忠 死而无憾",

}

hzaavscxes:addEffect(fk.Damaged, {
  anim_type = "masochism",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(hzaavscxes.name) 
  end,
  on_cost= function(self, event, target, player, data)
     return 
     player.room:askToSkillInvoke(player, {
      skill_name = hzaavscxes.name,
      prompt = "#hzaavscxes-draw:::"..player:getLostHp()
    }) 
  end,
  on_use = function(self, event, target, player, data)
    player:drawCards(player:getLostHp(), hzaavscxes.name)
  end,
})

return hzaavscxes
