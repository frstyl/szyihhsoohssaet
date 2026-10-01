local koucqloojs = fk.CreateSkill {
  name = "koucqloojs",
}

Fk:loadTranslationTable{
["koucqloojs"] = "攻擂",
[":koucqloojs"] = "主旹,与1其它各色賭鬥發動.若伱贏,1轉內,伱至其距離爲1,伱對其致旹傷害值次,伱可令1脚色回1;若伱未贏,其与伱1傷",

["@@koucqloojs_win-turn"]="攻擂",
["#koucqloojs"]="攻擂 選擇一脚色賭鬥",
["#koucqloojs-recover"]="攻擂 令1脚色回1",
}


koucqloojs:addEffect("active", {
  anim_type = "offensive",
  prompt = "#koucqloojs",
  max_phase_use_time = 1,
  min_card_num = 0,
  max_card_num = 1,
  target_num = 1,
  can_use = function(self, player)
    return not player:isKongcheng() and player:usedSkillTimes(koucqloojs.name, Player.HistoryPhase) == 0
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
    local pindian = player:pindian({target}, koucqloojs.name,effect.cards[1] and Fk:getCardById(effect.cards[1]) or nil)
    if player.dead then return end
    if pindian.results[target].winner == player then
      room:addTableMark(player, "@@koucqloojs_win-turn", effect.tos[1].id) --num
    else
    room:damage{
      from= effect.tos[1],
      to= effect.from,
      damage = 1,
      damageType = 1,
      skillName = koucqloojs.name,
    }
    end
  end,
})

koucqloojs:addEffect(fk.DamageInflicted, {
  anim_type = "support",
  is_delay_effect=true,
  can_trigger = function (self, event, target, player, data)
    return data.from == player and table.contains(player:getTableMark("@@koucqloojs_win-turn"), data.to.id)
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
      prompt = "#koucqloojs-recover",
      skill_name = koucqloojs.name,
      cancelable = true,
    })
    if #to>0 then 
    room:recover({
      who = to[1],
      num = 1,
      recoverBy = player,
      skillName = koucqloojs.name,
    })
  end
  end,
})

koucqloojs:addEffect("distance", {
  fixed_func = function(self, from, to)
    if table.contains(from:getTableMark("@@koucqloojs_win-turn"), to.id) then
      return 1
    end
  end,
})

return koucqloojs
