local hzaacqhzeec = fk.CreateSkill {
  name = "hzaacqhzeec",
}

Fk:loadTranslationTable{
["hzaacqhzeec"] = "行刑",
[":hzaacqhzeec"] = "當其他角色進入瀕死旹,若其在伱攻程內,伱可預弃1♠牌發動,其死亾且視爲由伱殺死",  --失去體力?
["#hzaacqhzeec-discard"] = "行刑:  %src 進入瀕死,伱可弃1♠牌 將其拖出去宰掉",
}

hzaacqhzeec:addEffect(fk.EnterDying, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target~=player and player:hasSkill(hzaacqhzeec.name) 
    and player:inMyAttackRange(target)
  end,

  on_cost = function(self, event, target, player, data)
      local cards = player.room:askToDiscard(player, {
        min_num = 1,
        max_num = 1,
        include_equip = true,
        skill_name = hzaacqhzeec.name,
        cancelable = true,
        pattern = ".|.|spade",
        prompt = "#hzaacqhzeec-discard:"..target.id,
        skip = true
      })
      if #cards > 0 then
        event:setCostData(self, { cards = cards,tos={target}})
        return true
      end
  end,
  on_use = function(self, event, target, player, data)
    player.room:throwCard(event:getCostData(self).cards, hzaacqhzeec.name, player, player)
    player.room:killPlayer{
      who = target,
      killer = player,
    }
  end,
  })

  return hzaacqhzeec
