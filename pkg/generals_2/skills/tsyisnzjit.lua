local tsyisnzjit = fk.CreateSkill {
  name = "tsyisnzjit",
}

Fk:loadTranslationTable{
["tsyisnzjit"] = "醉日",
[":tsyisnzjit"] = "當一角色體力改變旹,若伱至其距離不大于1且其體力值不大于其上限一半(上整),伱可發動,伱抽1", --改變體力旹?

["$tsyisnzjit1"] = "海棠花開陣陣香",
["$tsyisnzjit2"] = "伱等都是綠葉",

}

--DamageInflicted
tsyisnzjit:addEffect(fk.BeforeHpChanged, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(tsyisnzjit.name) 
    and  player:distanceTo(target)<2
    and target.hp<=(1+target.maxHp)//2   --?
  end,
  on_use = function(self, event, target, player, data)
    player:drawCards(1, tsyisnzjit.name)
  end,
})

return tsyisnzjit
