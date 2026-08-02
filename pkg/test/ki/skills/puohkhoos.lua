local puohkhoos = fk.CreateSkill {
  name = "#puohkhoos&",  --puohkhoos_rule?
}

Fk:loadTranslationTable{
  ["@$puohkhoos"] = "府庫",

  ["#AddTopuohkhoos"] = "%card 因 %arg 被置入府庫",
}

puohkhoos:addEffect(fk.AfterCardsMove, {
  can_refresh = function(self, event, target, player, data)
    if player.seat == 1 then
      for _, move in ipairs(data) do
        for _, info in ipairs(move.moveInfo) do
          if player.room:getBanner("puohkhoos") and
            table.contains(player.room:getBanner("puohkhoos"), info.cardId) then  --出
            return true
          end
          if move.toArea == Card.Void and move.extra_data and move.extra_data.addtopuohkhoos then  --出
            return true
         end
        end
      end
    end
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    local puohkhoos = room:getBanner("@$puohkhoos") or {}
    for _, move in ipairs(data) do
      local removed
      for _, info in ipairs(move.moveInfo) do
        if table.contains(puohkhoos, info.cardId) then
          table.removeOne(puohkhoos, info.cardId)
          removed = true
        end
      end
      if removed then
        move.extra_data = move.extra_data or {}
        move.extra_data.removefrompuohkhoos = true
      end
      if move.toArea == Card.Void and move.extra_data and move.extra_data.addtopuohkhoos then
        local add = {}
        for _, info in ipairs(move.moveInfo) do
          if room:getCardArea(info.cardId) == Card.Void then
            table.insert(add, info.cardId)
          end
        end
        if #add > 0 then
          room:sendLog{
            type = "#AddTopuohkhoos",
            arg = move.skillName,
            card = add,
          }
          table.insertTableIfNeed(puohkhoos, add)
        end
      end
    end
    room:setBanner("@$puohkhoos", puohkhoos)  end,
})

return puohkhoos
