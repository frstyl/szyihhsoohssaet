local paakmoach = fk.CreateSkill {
  name = "paakmoach",
  tags = { Skill.Compulsory },
}
Fk:loadTranslationTable{
  ["paakmoach"] = "白蟒",
  [":paakmoach"] = "伱有1額外武器欄｡伱起動殺指定目幖後必發,目幖抵消所需｢閃｣數爲x(x爲數此殺目幖數)",  --失效旹機
--.➀恆續,伱攻程+2.➁若伱攻程內其它存活脚色數不大于2,
  -- ["#paakmoach-choose"] = "白蟒 選擇額外目幖",

  ["$paakmoach1"] = "匹夫受死",
  ["$paakmoach2"] = "董一撞在此",
}


paakmoach:addAcquireEffect(function (self, player)
    player.room:addPlayerEquipSlots(player,Player.WeaponSlot)
end)

paakmoach:addLoseEffect (function (self, player)
    player.room:removePlayerEquipSlots(player,Player.WeaponSlot)
    local cards =  player:getEquipments(Card.SubtypeWeapon) --編號是進入敘
    local n = #player:getAvailableEquipSlots(Card.SubtypeWeapon) - #cards   --裝僃欄需編號
    if n>=0 then return end
      local t={}
      for i=1,-n,1 do
        table.insert(t,cards[#cards+1-i])
      end
      player.room:moveCards(
        {
          ids = t,
          from = player,
          toArea = Card.DiscardPile,
          moveReason = fk.ReasonPutIntoDiscardPile,
        })
    
end)

paakmoach:addEffect(fk.TargetSpecified, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return data.from == player and player:hasSkill(paakmoach.name) 
	and data.card.trueName=="ssaet"
  end,
  on_use = function(self, event, target, player, data)
  -- local x=(1 + #table.filter(player.room:getOtherPlayers(player), function (p)
  --       return player:inMyAttackRange(p) 
  --     end) ) //2
    local x = data.use and data.use.tos and #data.use.tos or 1
    data:setResponseTimes(x, data.to)  --1?
  end,
})

-- paakmoach:addEffect("atkrange", {
  -- correct_func = function(self, from, to)
    -- if from:hasSkill(paakmoach.name) then
      -- return 2
    -- end
  -- end,
-- })
-- paakmoach:addEffect("targetmod", {
  -- extra_target_func = function(self, player, skill, card)
    -- if card and card.trueName=="ssaet"  
      -- and  player:hasSkill(paakmoach.name)
    -- then
      -- return 1
    -- end
  -- end,
-- })

return paakmoach
