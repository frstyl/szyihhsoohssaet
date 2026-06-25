local ljeqhzoon = fk.CreateSkill {
  name = "ljeqhzoon",
}

Fk:loadTranslationTable{
  ["ljeqhzoon"] = "離䰟",
  [":ljeqhzoon"] = "➀伱受傷後,若傷源有牌,伱可發動,伱獲得傷源1牌➁當伱進入瀕死旹,伱可選1其它角色發動,伱觀看其全部牌,獲取其2,肰後伱可分配2牌", --挩離

  ["#ljeqhzoon-choose"] = "離䰟 選擇角色",
  ["#ljeqhzoon-discard"] = "離䰟 選擇弃牌",

  ["$ljeqhzoon1"] = "涌金門外水滔滔一點離䰟何処漂",
}

ljeqhzoon:addEffect(fk.Damaged, {
  anim_type = "masochism",
  can_trigger = function(self, event, target, player, data)
    if not (target == player and player:hasSkill(ljeqhzoon.name)) then return end
    if data.from and not data.from.dead then
      if data.from == player then
        return #player:getCardIds("e") > 0
      else
        return not data.from:isNude()
      end
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local flag = data.from == player and "e" or "he"
    local card = room:askToChooseCard(player, {
      target = data.from,
      flag = flag,
      skill_name = ljeqhzoon.name,
    })
    room:obtainCard(player, card, false, fk.ReasonPrey, player, ljeqhzoon.name)
  end
})

ljeqhzoon:addEffect(fk.EnterDying, {
  anim_type = "masochism",
  can_trigger = function(self, event, target, player, data)
    return  target==player and player:hasSkill(ljeqhzoon.name) 
    -- and
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
		local tos = room:askToChoosePlayers(player,{
      targets=room:getOtherPlayers(player),
      min_num=1,
      max_num=1,
      cancelable=true,
      prompt = "#ljeqhzoon-choose",
    })
    if #tos ~= 0 then
      event:setCostData(self, {tos = tos})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local target =event:getCostData(self).tos[1]
    local cards = room:askToChooseCards(player, {
        target = target,
        min = 2,
        max = 2,
        -- flag = "he",
        flag = { card_data = {{ "$Hand", target:getCardIds("h") },{"$Equip", target:getCardIds("e")}} },  --可見
        skill_name = ljeqhzoon.name,
        prompt = "#ljeqhzoon-discard",
      })
    room:moveCardTo(cards, Player.Hand, player, fk.ReasonPre, ljeqhzoon.name, nil, true, player)
    if player.dead then return end
    player.room:askToYiji(player,{
      targets=room.players,
      cards=player:getCardIds("he"),
      -- expand_pile=event:getCostData(self).ids,
      skip=false,
    })
    -- player.room:doYiji(event:getCostData(self).t, player, dzzjenqhqyen.name)

end,
})

return ljeqhzoon
