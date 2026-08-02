local tsziuqzyen = fk.CreateSkill{
  name = "tsziuqzyen",
}

Fk:loadTranslationTable{
  ["tsziuqzyen"] = "周旋",
  [":tsziuqzyen"] = "印牌:起動演練弃牌堆中當轉進入者",

  ["#tsziuqzyen"] = "周旋：你可以起動或打出其中你需要的基本牌",

  ["$tsziuqzyen1"] = "哼，易如反掌。",
  ["$tsziuqzyen2"] = "吾主圣明，泽披臣属。",
}

tsziuqzyen:addEffect("viewas", {
  anim_type = "special",
  pattern = ".|.|.|.|.|.",  --
  prompt = "#tsziuqzyen",
  expand_pile = function(self, player)
    return Fk:currentRoom():getBanner("DiscardPile-turn") or {}
  end,
  filter_pattern = {
    min_num = 1,
    max_num = 1,
    pattern = ".",
  },
  card_filter = function(self, player, to_select, selected)
    if #selected == 0 and table.contains(Fk:currentRoom().draw_pile, to_select) then
      local card = Fk:getCardById(to_select)
        if Fk.currentResponsePattern == nil then
          return player:canUse(card) and not player:prohibitUse(card)
        else
          return Exppattern:Parse(Fk.currentResponsePattern):match(card)
        end
    end
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then return end
    return Fk:getCardById(cards[1])
  end,
  enabled_at_play = Util.FalseFunc,
  enabled_at_response = function(self, player, response)
    return Fk:currentRoom().current ~= player
  end,
})

tsziuqzyen:addAcquireEffect(function (self, player, is_start)
  local room = player.room
  room:addSkill("discardPileInCurrentTurn")
  if room:getBanner("DiscardPile-turn")~=nil then return end
  local ids = {}
  room.logic:getEventsOfScope(GameEvent.MoveCards, 1, function(e)
    for _, move in ipairs(e.data) do
      if move.toArea == Card.DiscardPile then
        for _, info in ipairs(move.moveInfo) do
          if table.contains(room.discard_pile, info.cardId) then
            table.insertIfNeed(ids, info.cardId)
          end
        end
      end
    end
  end, Player.HistoryTurn)
  room:setBanner("discardPileInCurrentTurn-turn", ids)
end)

return tsziuqzyen
