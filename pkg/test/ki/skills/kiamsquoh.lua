local kiamsquoh = fk.CreateSkill {
  name = "kiamsquoh",
}

Fk:loadTranslationTable{
  ["kiamsquoh"] = "劍雨",
  [":kiamsquoh"] = "伱可將1牌与伱上一所起動牌同花者轉化爲｢殺｣(越過次數限制)起動發動.",

  ["@kiamsquoh"] = "劍雨",

  ["#kiamsquoh"] = "劍雨 %arg 當殺",
  ["#kiamsquoh-no"] = "劍雨 不可用",

}
kiamsquoh:addAcquireEffect(function (self, player)
  local room=player.room
      local use_event = player.room.logic:getEventsByRule(GameEvent.UseCard, 1, function (e)
        if e.id < player.room.logic:getCurrentEvent().id then
          return e.data.from == player
        end
      end, 1)
      if #use_event == 1 then
        local use = use_event[1].data
        player.room:setPlayerMark(player,"@kiamsquoh",use.card:getSuitString(true)) 
        player.room:setPlayerMark(player,"kiamsquoh",use.card.suit) 
      end
end)

kiamsquoh:addLoseEffect (function (self, player)
    player.room:setPlayerMark(player,"@kiamsquoh",0) 
    player.room:setPlayerMark(player,"kiamsquoh",0) 
end)

kiamsquoh:addEffect(fk.AfterCardUseDeclared,{
  can_refresh= function(self, event, target, player, data)
    if  target == player and player:hasSkill(kiamsquoh.name) then
      return true
    end
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:setPlayerMark(player,"@kiamsquoh",data.card:getSuitString(true)) 
    player.room:setPlayerMark(player,"kiamsquoh",data.card.suit) 
  end,
})
kiamsquoh:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "ssaet",
  prompt = function(self,player)
    local n=player:getMark("kiamsquoh")
    if n~=0 and n~=5 then
    local map={"log_spade","log_club","log_heart","log_diamond"}
    return "#kiamsquoh:::"..map[n]
    else 
      return "#kiamsquoh-no"
    end
  end,
  mute_card = true,
  handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and Fk:getCardById(to_select).suit == player:getMark("kiamsquoh")
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then return end
    local c = Fk:cloneCard("ssaet")
    c.skillName = kiamsquoh.name
    c:addSubcard(cards[1])
    return c
  end,
  enabled_at_play = function(self, player) 
    return  player:getMark("kiamsquoh")~=0 and player:getMark("kiamsquoh")~=5
  end,
  enabled_at_response = function(self, player, response) 
    return  not response and player:getMark("kiamsquoh")~=0 and player:getMark("kiamsquoh")~=5
  end,
})

kiamsquoh:addEffect("targetmod", {
  bypass_times = function(self, player, skill, scope, card)
    if card and table.contains(card.skillNames,kiamsquoh.name) and scope == Player.HistoryPhase then
      return true
    end
  end,
})
return kiamsquoh
