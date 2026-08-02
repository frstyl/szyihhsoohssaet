local puosljemh = fk.CreateSkill{
  name = "puosljemh",
}

Fk:loadTranslationTable{
  ["puosljemh"] = "賦斂",
  [":puosljemh"] = "預段始旹,伱可發動.全部存活脚色選擇1項執行➀將1牌置入府庫➁流失1體力",  --輪始旹?

  ["#puosljemh-input"] = "賦斂  將1牌置入府庫,否則失去體力",
}

local  Getpuohkhoos = function(room)
  local cards = room:getBanner("@$puohkhoos")
  if cards == nil then
    room:setBanner("@$puohkhoos", cards)
    return {}
  end
  return table.simpleClone(cards)
end


--- 将一些牌加入仁区
---@param player ServerPlayer @ 移动操作者
---@param cards integer|integer[]|Card|Card[] @ 要加入仁区的牌
---@param skillName? string @ 移动的技能名
local  AddTopuohkhoos = function(player, cards, skillName)
  local room = player.room
  skillName = skillName or ""
  room:addSkill(Fk.skills["#puohkhoos$"])
  local ids = Card:getIdList(cards)

  local movesSplitedByOwner = {}
  for _, cardId in ipairs(ids) do
    local moveFound = table.find(movesSplitedByOwner, function(move)
      return move.from == room.owner_map[cardId]
    end)

    if moveFound then
      table.insert(moveFound.ids, cardId)
    else
      table.insert(movesSplitedByOwner, {
        ids = { cardId },
        from = room.owner_map[cardId],
        toArea = Card.Void,
        moveReason = fk.ReasonPut,
        skillName = skillName,
        moveVisible = true,
        proposer = player,
        extra_data = { addtopuohkhoos = true},
      })
    end
  end

  room:moveCards(table.unpack(movesSplitedByOwner))
end

puosljemh:addAcquireEffect (function (self, player)
  local room=player.room
  room:setBanner("puohkhoos", {})
  room:setBanner("@$puohkhoos", {})
  room:addSkill("#puohkhoos&")
end)

local puosljemh_on_use=function(self, event, target, player, data)
    local room=player.room
    for _, p in ipairs(room.alive_players) do
      local  card = room:askToCards(p, {
          min_num = 1,
          max_num = 1,
          include_equip = true,
          skill_name = puosljemh.name,
          cancelable = true,
          prompt = "#puosljemh-input",
        })
      if #card==1 then
        AddTopuohkhoos(p,card, puosljemh.name)
      else
        room:loseHp(p,1,puosljemh.name)
      end
    end
end


--RoundStart
puosljemh:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(puosljemh.name) and player.phase == Player.Start
  end,
  on_use = puosljemh_on_use,
})



return puosljemh
