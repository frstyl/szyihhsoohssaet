local ljettseet = fk.CreateSkill {
  name = "ljettseet",
}

Fk:loadTranslationTable{
["ljettseet"] = "烈節",  --誼
[":ljettseet"] = "伱受傷旹,若有傷源且不爲伱,伱可預与傷源拼點發動.伱防止此傷害.且若伱沒贏,伱流失1體力令傷源弃1手牌",

["#ljettseet-invoke"]="烈節  与%src拼點 防止此傷害",

["#ljettseet-discard"]="烈節  弃1手牌",

["$ljettseet1"] = "怎可是般无禮",

}


ljettseet:addEffect(fk.Damaged, {
  anim_type = "masochism",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(ljettseet.name) 
    and data.to==player
    and data.from
    and data.from~=player
    and player:canPindian(data.from)
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = ljettseet.name,
      prompt = "#ljettseet-invoke:"..data.to.id,
    }) 
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local pindian = player:pindian({data.from}, ljettseet.name)
    S.preventDamage({damageData=data,skillName=ljettseet.name})
    if pindian.results[data.from].winner == player then return end
      if  not player.dead then
        room:loseHp(player,1,ljettseet.name,player)
      end
       room:askToDiscard(player, {
          min_num = 1,
          max_num = 1,
          include_equip = false,
          skill_name = ljettseet.name,
          cancelable = false,
          prompt = "#ljettseet-discard",
          skip=false,
        })   
    end,
})



return ljettseet
