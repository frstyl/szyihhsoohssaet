local pujqnzjins = fk.CreateSkill {
  name = "pujqnzjins",
}

Fk:loadTranslationTable{
["pujqnzjins"] = "飛刃",
[":pujqnzjins"] = "當伱使用一實殺旹,伱可發動,視爲對伱對1其它角色使用殺,此殺致傷旹目幖流失1體力上限",

["#pujqnzjins-invoke"] = "飛刃 選擇目幖",
}


pujqnzjins:addEffect(fk.CardUsing, {

  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(pujqnzjins.name) 
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
          prompt = "#pujqnzjins-invoke",
          skill_name = pujqnzjins.name,
          cancelable = true,
        })
    if #tos>0 then
        event:setCostData(self, {tos = tos, cards = cards})
        return true
    end
    end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:useVirtualCard("ssaet", nil, player, event:getCostData(self).tos, pujqnzjins.name, true)  --zzin souk
  end,
})

pujqnzjins:addEffect(fk.DamageCaused, {
  is_delay_effect=true,
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return
    target==player  --一次
    and
      data.card and table.contains(data.card.skillNames, pujqnzjins.name)
  end,
  on_trigger = function(self, event, target, player, data)
    player.room:changeMaxHp(data.to, -1, pujqnzjins.name)
  end,
})

-- pujqnzjins:addEffect(fk.PreDamage, {
--   is_delay_effect=true,
--   anim_type = "offensive",
--   can_trigger = function(self, event, target, player, data)
--     return
--     target=player  --一次
--     and
--       data.card and table.contains(data.card.skillNames, pujqnzjins.name)
--   end,
--   on_use = function(self, event, target, player, data)
--     local n = data.damage
--     -- data:preventDamage()  --无旹機
--     data.prevented=true  --无旹機
--     player.room:changeMaxHp(data.to, -n, pujqnzjins.name)
--   end,
-- })

return pujqnzjins
