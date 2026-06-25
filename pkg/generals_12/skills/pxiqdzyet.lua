local pxiqdzyet = fk.CreateSkill({
  name = "pxiqdzyet",
  tags={Skill.Compulsory},
})

Fk:loadTranslationTable{
  ["pxiqdzyet"] = "悲絕",
  [":pxiqdzyet"] = "鎖定｡➀伱進入瀕死旹必發,伱不可對伱使用｢肉｣至瀕死結算終｡➁伱使用｢肉｣｢藥｣旹必發,其回復值+1",

  ["$pxiqdzyet1"] = "请助我一臂之力！",
  ["$pxiqdzyet2"] = "我当要替天行道！",
}

pxiqdzyet:addEffect(fk.CardUsing, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    return
      target == player
      and
      player:hasSkill(pxiqdzyet.name) 
      and table.contains({"nziuk", "jiak"}, data.card.trueName)
  end,
  on_use = function(self, event, target, player, data)
    data.additionalRecover = (data.additionalRecover or 0) +1
  end,
})

pxiqdzyet:addEffect(fk.EnterDying, {
  anim_type = "negative",
  can_trigger = function(self, event, target, player, data)
    return
      target == player and player:hasSkill(pxiqdzyet.name) 
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    room:addPlayerMark(player,"pxiqdzyet-phase",1)
    room.logic:getCurrentEvent():findParent(GameEvent.Dying, true):addCleaner(function()
      room:removePlayerMark(player,"pxiqdzyet-phase",1)
    end)
  end,
})

pxiqdzyet:addEffect("prohibit", {
  is_prohibited = function(self, from, to, card)
    if from:getMark("pxiqdzyet-phase")~=0 and from==to 
     and card and card.trueName == "nziuk" then
      return true
    end
  end,
    -- is_prohibited = function(self, from, to, card)
  --   if from:hasSkill(pxiqdzyet.name) and from==to and from.dying
  --    and card and card.trueName == "nziuk" then
  --     return true
  --   end
  -- end,
  -- prohibit_use = function(self, player, card)
  --   return player:hasSkill(pxiqdzyet.name) and player.dying and card.trueName == "slash"
  -- end,
})



return pxiqdzyet
