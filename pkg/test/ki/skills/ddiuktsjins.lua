local ddiuktsjins = fk.CreateSkill {
  name = "ddiuktsjins",
}

Fk:loadTranslationTable{
  ["ddiuktsjins"] = "逐進",
  [":ddiuktsjins"] = "伱轉內紅牌進入弃牌堆後,伱可發動.伱抽1,1轉內｢殺｣次數上限+1。",  --獲得殺?

  -- ["ssaet_times-turn"] = "殺數",

  ["$ddiuktsjins1"] = "百步之內,取汝性命",
  ["$ddiuktsjins2"] = "著我玄天混元逐進",
  ["$ddiuktsjins3"] = "逐進破空",
}

local spec={
  on_use = function(self, event, target, player, data)
    local room = player.room
    player:drawCards(1,ddiuktsjins.name)
    if player.dead then return end
    room:addSkill("ssaet_times")
    room:addPlayerMark(player, "ssaet_times",1)
    room.logic:getCurrentEvent():findParent(GameEvent.Turn):addCleaner(function()
      room:removePlayerMark(player, "ssaet_times",1)
  end)
end,
}
ddiuktsjins:addEffect(fk.AfterCardsMove, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)  --每个player 緟數ids? 
    if  player~=player.room:getCurrent() or not player:hasSkill(ddiuktsjins.name) then return end

      for _, move in ipairs(data) do  --data move info
        if 
           move.toArea == Card.DiscardPile  --元 Area不爲 DiscardPile
        then  

          for _, info in ipairs(move.moveInfo) do
            if  Fk:getCardById(info.cardId).color == Card.Red then
              return true
            end
          end

        end

      end

  end,
  on_use=spec.on_use,
})

-- ddiuktsjins:addEffect(fk.TurnStart, {
--   -- on_cost=
--   on_use=spec.on_use,
-- })



return ddiuktsjins
