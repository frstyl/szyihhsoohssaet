local hqximhquoh = fk.CreateSkill {
  name = "hqximhquoh",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
["hqximhquoh"] = "飮羽",
[":hqximhquoh"] = "鎖定.➀恆續,伱基礎攻程(无視武器)爲0➁伱使用殺指定目幖後必發,若x≤y,目幖不可響應此牌.若x≥y,此殺對目幖傷害基數+1(x爲伱至目幖距離,y爲伱攻程)",

}


hqximhquoh:addEffect(fk.TargetSpecified, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(hqximhquoh.name) 
      and data.card.trueName == "ssaet"
     -- and player:distanceTo(data.to) <= player:getAttackRange()
  end,
  on_use = function(self, event, target, player, data)
    -- player:broadcastSkillInvoke(hqximhquoh.name)
    -- player.room:notifySkillInvoked(player, hqximhquoh.name, "defensive")
	if player:distanceTo(data.to) <= player:getAttackRange() then
    data.disresponsive = true
	end
	if player:distanceTo(data.to) >= player:getAttackRange() then
      data.additionalDamage =(data.additionalDamage or 0) +1
	end
  end,
})


-- hqximhquoh:addEffect(fk.DamageCaused, {
  -- can_trigger = function(self, event, target, player, data)
    -- return target == player and player:hasSkill(hqximhquoh.name) 
    -- and data.card and data.card.trueName == "ssaet" 
    -- and data.by_user
    -- and player:distanceTo(data.to) >= player:getAttackRange()  --
  -- end,
  -- on_trigger = function(self, event, target, player, data)
    -- player:broadcastSkillInvoke(hqximhquoh.name)
    -- player.room:notifySkillInvoked(player, hqximhquoh.name, "defensive")
    -- data:changeDamage(1)
  -- end,
-- })

hqximhquoh:addEffect("atkrange", {
  fixed_func = function (self, player)  --final_func
    if player:hasSkill(hqximhquoh.name) then  --覆蓋武器?
      return 0
    end
  end
})

return hqximhquoh
