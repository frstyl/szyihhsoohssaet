local muoqtoojs = fk.CreateSkill {
  name = "muoqtoojs",
  tags={Skill.Compulsory},
}

Fk:loadTranslationTable{
["muoqtoojs"] = "无對",
[":muoqtoojs"] = "伱起動牌旹,若當轉已用牌數爲耦數,必發,其它脚色不可起動打出牌至轉終或伱起動牌｡",

["@@muoqtoojs-turn"] = "无對",

}


muoqtoojs:addEffect(fk.CardUsing, {
  anim_type = "drawcard",
  can_refresh = function(self, event, target, player, data)
    return target==player and player:hasSkill(muoqtoojs.name,true,true)
  end,
  on_refresh = function(self, event, target, player, data)
    local room=player.room
    for _, p in ipairs(room:getOtherPlayers(player)) do
      room:removeTableMark(p,"@@muoqtoojs-turn", 1)
    end
  end,
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(muoqtoojs.name) or target~=player then return end

    local check = false
    -- local n = 0
    player.room.logic:getEventsOfScope(GameEvent.UseCard, 1, function (e)
      check = not check
      -- n=n+1
    end, Player.HistoryTurn)
    -- player:drawCards(n)
    return check
    -- if n%2==1 then return true end
    end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    for _, p in ipairs(room:getOtherPlayers(player)) do
      room:addTableMark(p,"@@muoqtoojs-turn", 1)
    end
  end,
})

muoqtoojs:addEffect("prohibit", {
  prohibit_use = function(self, player, card)
    if player:getMark("@@muoqtoojs-turn")~=0 then return true end
  end,
  prohibit_response = function(self, player, card)
    if player:getMark("@@muoqtoojs-turn")~=0 then return true end
  end,
})

return muoqtoojs
