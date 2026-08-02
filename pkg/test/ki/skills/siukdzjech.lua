local siukdzjech = fk.CreateSkill {
  name = "siukdzjech",
  -- tags={Skill.Compulsory}
}

Fk:loadTranslationTable{
  ["siukdzjech"] = "肅靜",
  [":siukdzjech"] = "此技能外,一腳色不發動技能旹,伱可發動,其弃x",


  ["$siukdzjech"] = "好一匹棗紅馬",
}
--
siukdzjech:addEffect(fk.SkillEffect, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(siukdzjech.name)
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local end_event = room.logic:getCurrentEvent():findParent(GameEvent.Turn, true)
    if not end_event then end_event = room.logic.event_recorder[eventType][#room.logic.event_recorder[eventType]] end
    if not end_event then end_event= room.logic:getCurrentEvent():findParent(GameEvent.Phase, true) end

      local n = #player.room.logic:getEventsByRule(GameEvent.UseCard, 1, function (e)
          return data.who == e.data.who and e.data.skill.name~=siukdzjech.name
      end, 999,end_event,nil)
      local result = player.room:askToDiscard(data.who, {
        min_num = n,
        max_num = n,
        include_equip = false,
        skill_name = siukdzjech.name,
        cancelable = true,
        prompt = "#siukdzjech-invoke:"..player.id,
        skip=false,
      })
      if #result < n then room:loseHp(data.who,1,siukdzjech.name,player) end
  end,
})
return siukdzjech
