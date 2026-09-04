local khoonstous = fk.CreateSkill {
  name = "khoonstous",
}

Fk:loadTranslationTable{
  ["khoonstous"] = "困鬥",
  [":khoonstous"] = "伱受傷後至多傷害值次,若有傷源A且其存活,伱可預打出1牌指定脚色B(在傷源A攻程內)發動.A對B起動虛擬｢鬥將｣",

  ["#khoonstous-discard"] = "困鬥：伱受到殺伤害，你可以弃置一牌令 %src 鬥將 一脚色",

  ["$khoonstous1"] = "今兩虎而鬥小者必死大者必傷",
  ["$khoonstous2"] = "縱使身処險境也要鬥上一鬥",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

khoonstous:addEffect(fk.Damaged, {
  anim_type = "masochism",
  can_trigger = function(self, event, target, player, data)
    return target== player and player:hasSkill(khoonstous.name)
    and data.from
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
        pattern==tostring(Exppattern{ id = table.filter(player:getCardIds("he"),function(id)
				return  not player:prohibitResponse(Fk:getCardById(id))
			end
			) }),
        skill_name = khoonstous.name,
        prompt = "#khoonstous-discard:"..data.from.id,
        cancelable = true,
        -- will_throw = false,
      })
      if #to > 0 and #cards > 0 then
        event:setCostData(self, {tos = to, cards = cards })
        return true
      end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    S.playCard(event:getCostData(self).cards,khoonstous.name,player)
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
