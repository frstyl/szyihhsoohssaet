local gianskoot = fk.CreateSkill({
  name = "gianskoot",
  tags = {Skill.Compulsory},
})

Fk:loadTranslationTable{
  ["gianskoot"] = "健骨",
  [":gianskoot"] = "鎖定.伱對一角色傷後,必發.若傷害結算歬,其體力值:不大于伱,伱回x,不小于伱,伱抽x.(x爲傷害值至少爲1)",

  ["$gianskoot1"] = "寶刀未老 壯气猶存",
}

gianskoot:addEffect(fk.Damage, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(gianskoot.name)  and data.extra_data and data.extra_data.gianskoot
  end,
  on_use = function(self, event, target, player, data)
    local n =data.damage
    if n<1 then n=1 end
    if not player.dead and data.extra_data.gianskoot>=2 then
    player.room:recover{
      who = player,
      num = n,
      recoverBy = player,
      skillName = gianskoot.name,
    }
    end
    if not player.dead and data.extra_data.gianskoot<=2  then
      player:drawCards(n,gianskoot.name)
    end
  end,
})

gianskoot:addEffect(fk.PreDamage, {
  can_refresh= function(self, event, target, player, data)
    return data.from == player  and player:hasSkill(gianskoot.name)  and data.to
  end,
  on_refresh = function(self, event, target, player, data)
    local n =data.damage
    data.extra_data=data.extra_data or {}

    if player.hp==data.to.hp then  --轉傷?
        data.extra_data.gianskoot=2
        -- return
    elseif player.hp>data.to.hp then
        data.extra_data.gianskoot=3
        -- return

    elseif player.hp<data.to.hp then
        data.extra_data.gianskoot=1
    end
  end,
})
return gianskoot
