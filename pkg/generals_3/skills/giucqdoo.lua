local giucqdoo = fk.CreateSkill{
  name = "giucqdoo",
}

Fk:loadTranslationTable{
  ["giucqdoo"] = "窮途",
  [":giucqdoo"] = "其它角色轉終旹,若其體力值或手牌數不大于1,伱可選擇其1牌發動,伱獲取此牌",  --彊度

  ["#giucqdoo-invoke"] = "窮途 %src轉終 是否獲取其牌",

  ["$giucqdoo1"] = "昰里就是張家店客官裏邊請",
  ["$giucqdoo2"] = "伱昰窮鬼還要昰些作甚",
}


giucqdoo:addEffect(fk.TurnEnd, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target~=player and player:hasSkill(giucqdoo.name) 
    and (target.hp<2 or target:getHandcardNum()<2)
    and not target:isNude()
  end,
  on_cost = function(self, event, target, player, data)
    local room=player.room
    if room:askToSkillInvoke(player, {
      skill_name = giucqdoo.name,
      prompt = "#giucqdoo-invoke:"..target.id,
    }) then
    event:setCostData(self,{tos={target}, card= room:askToChooseCard(player, { target = target, flag = "he", skill_name = giucqdoo.name })}) 
    return true
    end
  end,
  on_use = function(self, event, target, player, data)
    player.room:obtainCard(player, event:getCostData(self).card, false, fk.ReasonPrey, player, giucqdoo.name)
  end,
})

return giucqdoo
