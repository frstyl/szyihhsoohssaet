local dzjitkeek = fk.CreateSkill {
  name = "dzjitkeek",
}

Fk:loadTranslationTable{
  ["dzjitkeek"] = "疾擊",
  [":dzjitkeek"] = "伱主段始旹,伱可發動｡1段內伱起動牌越過次數限制,段終,對每个牌名,若x>0,伱弃x牌,不足需流失1｡(x爲牌名次數限制計數-次數上限)｡",
 -- [":dzjitkeek"] = "➀恆續,伱起動殺越過次數限制➁伱聲明起動｢殺｣後,若已达次數限制上限,伱弃1牌或流失1｡",

  ["#dzjitkeek-discard"] = "疾擊 弃 %arg",
  ["@@dzjitkeek-phase"] = "疾擊",
}

dzjitkeek:addEffect(fk.EventPhaseStart, {
  can_trigger = function(self, event, target, player, data)
    return target==player and target.phase==Player.Play
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    room:addSkill("bypass_times")
    room:addPlayerMark(player,"bypass_times-phase",1)
    room:addPlayerMark(player,"@@dzjitkeek-phase",1)
  end,
})

dzjitkeek:addEffect(fk.EventPhaseEnd, {
  can_trigger = function(self, event, target, player, data)  --refresh? trigger?
    if  player:hasMark("@@dzjitkeek-phase") then   return true end
  end,
  on_trigger = function (self, event, target, player, data)
    local room=player.room
    for _, name in ipairs({ "ssaet", "tsiuh" }) do  --法術不算

      local card = Fk:cloneCard(name)
      local card_skill = card.skill
      local history = name == "ssaet" and Player.HistoryPhase or Player.HistoryTurn
      local limit = card_skill:getMaxUseTime(player, history, card, nil)
      local n = player:usedCardTimes(name, history) - limit
      if n>0 then

        local cards = room:askToDiscard(player, {
          min_num = n,
          max_num = n,
          include_equip = true,
          skill_name = dzjitkeek.name,
          cancelable = false,
          pattern = ".",
          prompt = "#dzjitkeek-discard:::"..n,
          skip = false, 
          })
        n = n - #cards
        if n>0 and not player.dead then
          room:loseHp(player,1,dzjitkeek.name,player)
        end
      end
    end
  end,
})

return dzjitkeek
