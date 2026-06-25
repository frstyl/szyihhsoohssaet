local card_times = fk.CreateSkill {
  name = "card_times_skill",
}



card_times:addEffect(fk.PreCardUse, {
  -- global=true,
  priority=999, --禁插入結算
  can_trigger = function(self, event, target, player, data)
    return target == player ---and not data.skill:hasTag(Skill.Compulsory)
  end,
  on_trigger = function(self, event, target, player, data)  --addPlayerMark?
    player.room:addPlayerMark(player,data.card.trueName.."-use_times-phase",1)
    player.room:addPlayerMark(player,data.card.trueName.."-use_times-turn",1)

    local t=player:getTableMark("card_times-round")
    t[data.card.trueName]=(t[data.card.trueName] or 0) +1
    player.room:setPlayerMark(player,"card_times-round",t)

    if t[data.card.trueName]==5 
      -- and not table.contains(player.room.disabled_packs, "card_times_round") 
    then
      player.room:addSkill("card_times_prohibit_skill")
      player.room:addTableMark(player,"_card_times_prohibit-round",data.card.trueName)
    end
  end,
})



card_times:addEffect("prohibit", {
  -- global = true,
  prohibit_use = function(self, player, card)
    return player and card and (player:getTableMark("_card_times_prohibit-round")[card.trueName] or 0 )>4
  end,
})


return card_times
