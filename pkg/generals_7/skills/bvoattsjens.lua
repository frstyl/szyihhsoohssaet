local bvoattsjens = fk.CreateSkill {
  name = "bvoattsjens",
}

Fk:loadTranslationTable{
["bvoattsjens"] = "拔箭",  --誼
[":bvoattsjens"] = "➀當伱受傷後伱可發動.伱體力上限-1,抽3➁伱令1其它角色進入瀕死旹,伱可預弃1裝僃牌發動,伱體力上限+1,抽2",  --瀕死?

["#bvoattsjens-invoke"]="拔箭 是否流失1體力上限 抽3",
["#bvoattsjens-discard"]="拔箭 弃1裝僃加1體力上限",

["$bvoattsjens1"] = "小傷而已",

}


bvoattsjens:addEffect(fk.Damaged, {
  anim_type = "masochism",
  can_trigger = function(self, event, target, player, data)
    return  target==player and player:hasSkill(bvoattsjens.name) 
    -- and data.card and data.card.trueName=="ssaet"
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = bvoattsjens.name,
      prompt = "#bvoattsjens-invoke",
    }) 
  end,
  on_use = function(self, event, target, player, data)
    player.room:changeMaxHp(player,-1)
    if player.dead then return end
    data.to:drawCards(3, bvoattsjens.name)
  end,
})

bvoattsjens:addEffect(fk.EnterDying, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target~=player and player:hasSkill(bvoattsjens.name) and data.killer == player
  end,
  on_cost = function(self, event, target, player, data)
      local cards = player.room:askToDiscard(player,{
          min_num = 1,
          max_num = 1,
          skill_name = bvoattsjens.name,
          include_equip = true,
          cancelable = true,
          pattern = ".|.|.|.|.|equip",
          prompt = "#bvoattsjens-discard",
          skip=true,
        }
      )
      if #cards>0 then 
        event:setCostData(self,{cards=cards})
        return true
      end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:throwCard(event:getCostData(self).cards, bvoattsjens.name, player, player)
    room:changeMaxHp(player, 1)
    if player.dead then return end
    player:drawCards(3, bvoattsjens.name)
  end,
})


return bvoattsjens
