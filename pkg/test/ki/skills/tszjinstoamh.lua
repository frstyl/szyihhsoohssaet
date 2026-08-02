local tszjinstoamh = fk.CreateSkill {
  name = "tszjinstoamh",
}
Fk:loadTranslationTable{
  ["tszjinstoamh"] = "震膽",
  [":tszjinstoamh"] = "伱致傷後,若受傷脚色不爲伱且攻程大于0,伱可發動.伱敓取其1攻程,則其對伱致傷後,伱敓回1攻程",

  ["#tszjinstoamh-invoke"] = "震膽 敓取 %src 攻程",
  -- ["@tszjinstoamh"] = "攻程",

  ["$tszjinstoamh1"] = "愿逐長風破萬里浪",
}
tszjinstoamh:addEffect(fk.Damage, {
  can_trigger = function(self, event, target, player, data)
    return data.from==player and player:hasSkill(tszjinstoamh.name) and data.to~=player and data.to:getAttackRange()>0
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = tszjinstoamh.name,
      prompt = "#tszjinstoamh-invoke:".. data.to.id,
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
  room:setPlayerMark(data.to,"@add_attack_range",-1+data.to:getMark("@add_attack_range"))
  room:addPlayerMark(player,"@add_attack_range",1)

    room:addTableMark(player,"tszjinstoamh",data.to.id)  -- -+?
    -- local t=player:getTableMark("tszjinstoamh")
    -- t[data.to.id]=(t[data.to.id] or 0) +1
    -- room:setPlayerMark(player,"tszjinstoamh",t)
  end,
})

tszjinstoamh:addEffect(fk.Damage, {
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    return data.from==player 
    -- and (data.to:getTableMark("tszjinstoamh")[data.from.id] or 0 >0)
    and table.contains(data.to:getTableMark("tszjinstoamh"),data.from.id)
  end,
  on_trigger = function(self, event, target, player, data)
    local room = player.room
    -- room:removePlayerMark("@tszjinstoamh",data.to,1)  -- -+?
    -- local t=player:getTableMark("tszjinstoamh")
    -- t[data.to.id]=(t[data.to.id] or 0) -1
    room:removeTableMark(data.to,"tszjinstoamh",player.id)  --removeOne
	  room:setPlayerMark(data.to,"@add_attack_range",-1+data.to:getMark("@add_attack_range"))
	  room:addPlayerMark(player,"@add_attack_range",1)

  end,
})

-- tszjinstoamh:addEffect("atkrange", {
  -- correct_func = function(self, player)
    -- if player:getMark("@tszjinstoamh") ~=0 then
      -- return   player:getMark("@tszjinstoamh")
    -- end
  -- end
-- })
return tszjinstoamh
