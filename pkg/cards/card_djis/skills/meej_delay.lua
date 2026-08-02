local skill = fk.CreateSkill {
  name = "meej_delay",
}

Fk:loadTranslationTable{
["@@meej-turn"] = "迷",
["meej_delay"] = "迷",
}

skill:addEffect(fk.Damaged, {
  -- global = true,
  late_refresh = true,
  can_refresh = function(self, event, target, player, data)
    return  player:getMark("@@meej-turn") > 0
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:setPlayerMark(player,"@@meej-turn",0) 
    -- player.room:broadcastProperty(player, "hsoon")
  end,
})


skill:addEffect("prohibit", {
  -- global = true,
  prohibit_use = function(self, player, card)
    return 
      player:getMark("@@meej-turn") > 0  and card and 
      -- (card.trueName =="ssaet" or card.name == "szjemh")
      table.contains({  "ssaet", "szjemh", "nziuk" }, card.trueName) 
  end, 
  prohibit_response = function(self, player, card)
    return player:getMark("@@meej-turn") > 0  and card and 
    table.contains({  "ssaet", "szjemh", "nziuk" }, card.trueName) 
  end,
})


return skill
