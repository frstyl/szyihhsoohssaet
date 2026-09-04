local siacqphouk = fk.CreateSkill {
  name = "siacqphouk",
}

Fk:loadTranslationTable{
["siacqphouk"] = "相撲",
[":siacqphouk"] = "主旹,与1其它各色賭鬥發動.若伱贏,1轉內,伱至其距離爲1,伱對其致旹傷害值次,伱可令1脚色回1;若伱未贏,其与伱1傷",

["@@siacqphouk_win-turn"]="相撲",
["#siacqphouk"]="相撲 選擇一脚色賭鬥",
["#siacqphouk-recover"]="相撲 令1脚色回1",
}


siacqphouk:addEffect("active", {
  anim_type = "offensive",
  prompt = "#siacqphouk",
  max_phase_use_time = 1,
  min_card_num = 0,
  max_card_num = 1,
  target_num = 1,
  can_use = function(self, player)
    return not player:isKongcheng() and player:usedSkillTimes(siacqphouk.name, Player.HistoryPhase) == 0
  end,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and table.contains(player:getCardIds("h"), to_select)
  end,
  target_filter = function(self, player, to_select, selected, selected_cards)
    return #selected == 0 and to_select ~= player and player:canPindian(to_select)
  end,
  on_use = function(self, room, effect)
    local player = effect.from
    local target = effect.tos[1]
    local pindian = player:pindian({target}, siacqphouk.name,effect.cards[1] and Fk:getCardById(effect.cards[1]) or nil)
    if player.dead then return end
    if pindian.results[target].winner == player then
      room:addTableMark(player, "@@siacqphouk_win-turn", effect.tos[1].id) --num
    else
    room:damage{
      from= effect.tos[1],
      to= effect.from,
      damage = 1,
      damageType = 1,
      skillName = siacqphouk.name,
    }
    end
  end,
})

siacqphouk:addEffect(fk.DamageInflicted, {
  anim_type = "support",
  is_delay_effect=true,
  can_trigger = function (self, event, target, player, data)
    return data.from == player and table.contains(player:getTableMark("@@siacqphouk_win-turn"), data.to.id)
  end,
  trigger_times = function(self, event, target, player, data)
    return data.damage
  end,
  on_trigger = function (self, event, target, player, data)
    local room=  player.room
    local to = room:askToChoosePlayers(player,{
      targets = room.alive_players,
      min_num=1,
      max_num=1,
      prompt = "#siacqphouk-recover",
      skill_name = siacqphouk.name,
      cancelable = true,
    })
    if #to>0 then 
    room:recover({
      who = to[1],
      num = 1,
      recoverBy = player,
      skillName = siacqphouk.name,
    })
  end
  end,
})

siacqphouk:addEffect("distance", {
  fixed_func = function(self, from, to)
    if table.contains(from:getTableMark("@@siacqphouk_win-turn"), to.id) then
      return 1
    end
  end,
})

return siacqphouk
