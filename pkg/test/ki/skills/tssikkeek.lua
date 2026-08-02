local tssikkeek = fk.CreateSkill{
  name = "tssikkeek",
}

Fk:loadTranslationTable{
  ["tssikkeek"] = "側擊",
  [":tssikkeek"] = "一脚色起動殺對目幖生效前,若目幖非伱且在伱攻程內,伱可預選1手牌發動.伱將此牌暗置于目幖脚色將牌㫄.此殺{被抵消/生效}旹,迻除{紅/黑}側擊牌,{反抵消/傷害值+1}.生效結算終,迻除側殘餘擊牌",

  ["#tssikkeek-invoke"] = "側擊：%arg 將對 %dest 生效 ",-- %src

  ["$tssikkeek1"] = "狄获悬野，秋风扫之！",
  ["$tssikkeek2"] = "戎狄作乱，岂能坐视！",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

tssikkeek:addEffect(fk.PreCardEffect, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return 
    -- data.to~=player 
    player:inMyAttackRange(data.to)
    and 
    player:hasSkill(tssikkeek.name) and
      data.card.trueName == "ssaet" 
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local cards = room:askToCards(player, {
      min_num = 1,
      max_num = 1,
      skill_name = tssikkeek.name,
      include_equip = false,
      pattern = ".",--tostring(Exppattern{ id = ids })
      prompt = "#tssikkeek-invoke::"..data.to.id..":"..data.card:toLogString(),
      cancelable = true,
    })
    if #cards > 0 then
      event:setCostData(self, {cards = cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local cards = event:getCostData(self).cards
    data.to:addToPile("$tssikkeek", cards, false, tssikkeek.name,player,player)
    data.extra_data=data.extra_data or {}
    data.extra_data.tssikkeek=data.extra_data.tssikkeek or {}  --允許多个
    -- table.insert(data.extra_data.tssikkeek, {from=player,cid=cards[1],color = Fk:getCardById(cards[1]).color })
    table.insert(data.extra_data.tssikkeek, cards[1])
  end,
})


tssikkeek:addEffect(fk.CardEffectCancelledOut, {
  anim_type = "offensive",
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    if target==player  and data.extra_data and data.extra_data.tssikkeek then
      player:drawCards(6)
      return true
    end
  end,
  on_trigger = function(self, event, target, player, data)
   local room = player.room
   for _, t in ipairs(data.extra_data.tssikkeek) do
    -- if t[color]==Card.Red then
    if Fk:getCardById(t).color==Card.Red then
      room:moveCardTo(t, Card.DiscardPile, nil, fk.ReasonPutIntoDiscardPile, tssikkeek.name, nil, true, player)
      data.isCancellOut = false
      table.removeOne(data.extra_data.tssikkeek, t)
    end
   end
  end,
})

tssikkeek:addEffect(fk.CardEffecting, {
  anim_type = "offensive",
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    return target==player and  data.extra_data and data.extra_data.tssikkeek
  end,
  on_trigger = function(self, event, target, player, data)
   local room = player.room
   for _, t in ipairs(data.extra_data.tssikkeek) do
    -- if t[color]==Card.Red then
    if Fk:getCardById(t).color==Card.Black then
      room:moveCardTo(t, Card.DiscardPile, nil, fk.ReasonPutIntoDiscardPile, tssikkeek.name, nil, true, player)
      data.additionalDamage = (data.additionalDamage or 0)+1
      table.removeOne(data.extra_data.tssikkeek, t)
    end
   end
  end,
})

tssikkeek:addEffect(fk.CardEffectFinished, {
  anim_type = "offensive",
  is_delay_effect=true,
  can_refresh = function(self, event, target, player, data)
    return data.use and data.extra_data and data.extra_data.tssikkeek
  end,
  on_refresh = function(self, event, target, player, data)
   local room = player.room
   for _, t in ipairs(data.extra_data.tssikkeek) do

      room:moveCardTo(t, Card.DiscardPile, nil, fk.ReasonPutIntoDiscardPile, tssikkeek.name, nil, true, player)
      data.additionalDamage = (data.additionalDamage or 0)+1

   end
  end,
})

tssikkeek:addEffect("visibility", {
  card_visible = function(self, player, card)
    if player:getPileNameOfId(card.id) == "$tssikkeek" then
      return false
    end
  end
})
return tssikkeek
