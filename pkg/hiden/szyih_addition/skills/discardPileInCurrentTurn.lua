local discard_pile_in_current_turn = fk.CreateSkill{
  name = "discard_pile_in_current_turn",
}

Fk:loadTranslationTable{

  ["@$DiscardPile-turn"]="弃牌堆-轉",
}


discard_pile_in_current_turn:addEffect(fk.AfterCardsMove, {
  -- global = true,
  can_refresh = function(self, event, target, player, data)
    if player.seat==1 then
      return true
      -- for _, move in ipairs(data) do
      --   if move.toArea == Card.DiscardPile then
      --     for _, info in ipairs(move.moveInfo) do
      --       if table.contains(player.room.discard_pile, info.cardId) then
      --         return true
      --       end
      --     end
      --   end
      --   for _, info in ipairs(move.moveInfo) do
      --     if info.fromArea == Card.DiscardPile and not table.contains(player.room.discard_pile, info.cardId) then
      --       return true
      --     end
      --   end
      -- end
    end
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    local ids  = room:getBanner("DiscardPile-turn") or {}
    for _, move in ipairs(data) do
      if move.toArea == Card.DiscardPile then
        for _, info in ipairs(move.moveInfo) do
          if table.contains(room.discard_pile, info.cardId) then
            table.insertIfNeed(ids, info.cardId)
          end
        end
      end
      for _, info in ipairs(move.moveInfo) do
        if info.fromArea == Card.DiscardPile and not table.contains(room.discard_pile, info.cardId) then
          table.removeOne(ids, info.cardId)
        end
      end
    end
    room:setBanner("@$DiscardPile-turn", ids) --@$
  end,
})

discard_pile_in_current_turn:addEffect(fk.AfterDrawPileShuffle, {
  mute = true,
  can_refresh = function(self, event, target, player, data)
    return true
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    room:setBanner("@$DiscardPile-turn", nil)
  end
})

return discard_pile_in_current_turn
