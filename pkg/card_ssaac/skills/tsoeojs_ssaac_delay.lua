local cardSkill = fk.CreateSkill {
  name = "tsoeojs_ssaac_delay",
}


cardSkill:addEffect(fk.HpRecover, {
  -- global=true,
  can_trigger = function(self, event, target, player, data)
  return data.who==player and data.skillName=="tsoeojs_ssaac_skill"  and data.num>0
  -- and not data.prevented
    end,
  on_trigger = function(self, event, target, player, data)
      -- local cards = player.room:askToDiscard(player, {
      --   min_num = data.num,
      --   max_num = data.num,
      --   include_equip = false,
      --   skill_name = "tsoeojs_ssaac_skill" ,
      --   cancelable = false,
      --   prompt = "#tsoeojs_ssaac-discard:::"..data.num,
      -- })
      local room=player.room
      local use_event = player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard)
      if use_event then
        local use = use_event.data
        if use.card == data.card then
          use.extra_data=use.extra_data or {}
          use.extra_data.tsoeojs_ssaac=use.extra_data.tsoeojs_ssaac or {}
          -- use.extra_data.tsoeojs_ssaac[player.id]=data.num
          table.insert(use.extra_data.tsoeojs_ssaac,{player.id,data.num})
        end
      end
  end,
})
return cardSkill
