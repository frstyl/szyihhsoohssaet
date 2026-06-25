local khoonstous = fk.CreateSkill {
  name = "khoonstous",
}

Fk:loadTranslationTable{
  ["khoonstous"] = "困鬥",
  [":khoonstous"] = "伱受傷後至多傷害值次,伱可預弃1牌指定傷源A攻程內1除伱与A外角色B發動.視爲A對B使用鬥將(目幖不合理則迻除)",

  ["#khoonstous-discard"] = "困鬥：伱受到殺伤害，你可以弃置一牌令 %src 鬥將 一角色",

  ["$khoonstous1"] = "今兩虎而鬥小者必死大者必傷",
  ["$khoonstous2"] = "縱使身処險境也要鬥上一鬥",
}

khoonstous:addEffect(fk.Damaged, {
  anim_type = "masochism",
  can_trigger = function(self, event, target, player, data)
    return target== player and player:hasSkill(khoonstous.name) 
    and not data.from.dead
    and #table.filter(player.room:getOtherPlayers(data.from, false), function (p)
          return data.from:inMyAttackRange(p)
        end) >0
  end,
  trigger_times = function(self, event, target, player, data)
    return data.damage
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
      local to, cards = room:askToChooseCardsAndPlayers(player, {
        min_card_num = 1,
        max_card_num = 1,
        min_num = 1,
        max_num = 1,
        targets = table.filter(room:getOtherPlayers(data.from, false), function (p)
          return data.from:inMyAttackRange(p)
        end),
        skill_name = khoonstous.name,
        prompt = "#khoonstous-discard:"..data.from.id,
        cancelable = true,
        will_throw = true,
      })
      if #to > 0 and #cards > 0 then
        event:setCostData(self, {tos = to, cards = cards })
        return true
      end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:throwCard(event:getCostData(self).cards, khoonstous.name, player, player)
    local tous_tsiacs = Fk:cloneCard("tous_tsiacs")
    tous_tsiacs.skillName = khoonstous.name
    local new_use = { ---@type UseCardDataSpec
      from = data.from,
      tos = event:getCostData(self).tos,
      card = tous_tsiacs,
      prohibitedCardNames = { "buac_hzfan_mujs_nzjen" ,"tsiac_keejs_dzius_keejs"},
    }
    room:useCard(new_use)
  end,
})

return khoonstous
