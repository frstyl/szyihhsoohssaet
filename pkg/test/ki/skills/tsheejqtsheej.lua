local tsheejqtsheej = fk.CreateSkill {
  name = "tsheejqtsheej",
}

Fk:loadTranslationTable{

["tsheejqtsheej"] = "悽悽",
[":tsheejqtsheej"] = "其它脚色轉終旹,若其{手牌數/裝僃區牌數}小于伱之,伱可選1{非裝僃/裝僃}發動.將此牌置入其區域,伱抽1",--<br/>"..

["#tsheejqtsheej-choose"] = "悽悽 是否將1牌置入 %src 區域",
}

tsheejqtsheej:addEffect(fk.TurnEnd, {
  can_trigger= function(self, event, target, player, data)
    return target~=player and player:hasSkill(tsheejqtsheej.name) 
    and  ( 
        #target:getCardIds("h")< #player:getCardIds("h")  
      or  #target:getCardIds("e")< #player:getCardIds("e")
        )
  end,
  on_cost = function(self, event, target, player, data)
    local include_equip = #target:getCardIds("e")< #player:getCardIds("e") 
    local cards =player.room:askToCards(player,{
      min_num=1,
      max_num=1,
      include_equip= include_equip ,
      pattern=".",  --?
      prompt="#tsheejqtsheej-choose:"..target.id,
      cancelable=true,
    })
    if #cards>0 then 
      event:setCostData(self,{ cards=cards})
      return true
    end
  end,

  on_use = function(self, event, target, player, data)
    local room=player.room
    local cards=event:getCostData(self).cards
    if room:getCardArea(cards[1]) ==Card.PlayerEquip then
      room:moveCardIntoEquip(target, cards[1], tsheejqtsheej.name, true, player)
    else
      player.room:moveCardTo(cards, Player.Hand, target, fk.ReasonPut, tsheejqtsheej.name, nil, false, player)
    end
    if player.dead then return end
    player:drawCard(1,tsheejqtsheej.name)
  end,
})

return tsheejqtsheej
