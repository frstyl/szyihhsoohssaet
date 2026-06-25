local cardSkill = fk.CreateSkill {
  name = "tshjit_skill_check",
}

cardSkill:addEffect(fk.Deathed, {
  -- global=true,
  can_refresh = function(self, event, target, player, data)
      local losehp_event = player.room.logic:getCurrentEvent():findParent(GameEvent.LoseHp)
      local effect_event = player.room.logic:getCurrentEvent():findParent(GameEvent.CardEffect)
      return losehp_event and losehp_event.data.who == target and effect_event and  effect_event.data.extra_data and effect_event.data.extra_data.tshjit
    end,
  on_refresh = function(self, event, target, player, data)
      local effect_event = player.room.logic:getCurrentEvent():findParent(GameEvent.CardEffect)
      if effect_event and effect_event.data and effect_event.data.extra_data and effect_event.data.extra_data.tshjit==true then
        effect_event.data.extra_data.tshjit=false
      end
    end,
})
return cardSkill
