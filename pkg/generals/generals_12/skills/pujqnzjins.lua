local hqrachtoav = fk.CreateSkill {
  name = "hqrachtoav",
}

Fk:loadTranslationTable{
["hqrachtoav"] = "影刀",
[":hqrachtoav"] = "伱起動一實殺旹,伱可選1其它腳色發動,伱對其起動虛擬｢殺｣,此殺致傷旹目幖減1體力上限",

["#hqrachtoav-invoke"] = "影刀 選擇目幖",
}


hqrachtoav:addEffect(fk.CardUsing, {

  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(hqrachtoav.name) 
    and data.card.trueName=="ssaet"
    and #Card:getIdList(data.card)>0
  end,
  on_cost = function(self, event, target, player, data)
    local room=player.room
    --   local targets = table.filter(room:getOtherPlayers(player, false), function (p)
    --   return player:canUseTo(Fk:cloneCard("ssaet"), p, {bypass_distances = true, bypass_times = true})
    -- end)
      local tos = room:askToChoosePlayers(player, {
    --       targets = table.filter(room:getOtherPlayers(player, false), function (p)
    --   return player:inMyAttackRange(p)
    -- end),
          targets=room:getOtherPlayers(player, false),
          min_num = 1,
          max_num = 1,
          prompt = "#hqrachtoav-invoke",
          skill_name = hqrachtoav.name,
          cancelable = true,
        })
    if #tos>0 then
        event:setCostData(self, {tos = tos, cards = cards})
        return true
    end
    end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:useVirtualCard("ssaet", nil, player, event:getCostData(self).tos, hqrachtoav.name, true)  --zzin souk
  end,
})

hqrachtoav:addEffect(fk.DamageInflicted, {
  is_delay_effect=true,
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return player==data.to
    and
      data.card and table.contains(data.card.skillNames, hqrachtoav.name)
  end,
  on_trigger = function(self, event, target, player, data)
    player.room:changeMaxHp(data.to, -1, hqrachtoav.name)
  end,
})

-- hqrachtoav:addEffect(fk.PreDamage, {
--   is_delay_effect=true,
--   anim_type = "offensive",
--   can_trigger = function(self, event, target, player, data)
--     return
--     target=player  --一次
--     and
--       data.card and table.contains(data.card.skillNames, hqrachtoav.name)
--   end,
--   on_use = function(self, event, target, player, data)
--     local n = data.damage
--     -- data:preventDamage()  --无旹機
--     data.prevented=true  --无旹機
--     player.room:changeMaxHp(data.to, -n, hqrachtoav.name)
--   end,
-- })

return hqrachtoav
