local dzoeonqsyit = fk.CreateSkill {
  name = "dzoeonqsyit",
}

Fk:loadTranslationTable{
["dzoeonqsyit"] = "存恤",
[":dzoeonqsyit"] = "一脚色A回復體力後/進入瀕死旹,(需其存活活)伱可發動,伱抽2,交予A 1牌",

["#dzoeonqsyit-invoke"]="存恤 對 %dest  發動",
["#dzoeonqsyit-give"]="存恤 交予 %dest  1牌",

}
local spec ={
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(dzoeonqsyit.name)
    and  not target.dead
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    if room:askToSkillInvoke(player, {
      skill_name = dzoeonqsyit.name,
      prompt = "#dzoeonqsyit-invoke::"..target.id,
    }) then
      event:setCostData(self, {tos = {target}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    player:drawCards(2, dzoeonqsyit.name)
    if target==player or player.dead or player:isNude() or target.dead then return end
    local card = room:askToCards(player, {
      min_num = 1,
      max_num = 1,
      include_equip = true,
      skill_name = dzoeonqsyit.name,
      prompt = "#dzoeonqsyit-give::"..target.id,
      cancelable = false,
    })
    if #card > 0 then
      room:moveCardTo(card, Card.PlayerHand, target, fk.ReasonGive, dzoeonqsyit.name, nil, false, player)
    end
  end,
}

dzoeonqsyit:addEffect(fk.HpRecover, spec)
dzoeonqsyit:addEffect(fk.EnterDying, spec)

return dzoeonqsyit
