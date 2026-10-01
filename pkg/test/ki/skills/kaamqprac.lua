local kaamqprac = fk.CreateSkill {
  name = "kaamqprac",
}

Fk:loadTranslationTable{
  ["kaamqprac"] = "監兵",
  [":kaamqprac"] = "一脚色A起動牌旹,伱可明置1{紅/黑}牌發動.A｢殺｣段次數限制計數設爲{0/上限}",

  ["#kaamqprac-invoke"] = "監兵：伱可以投出一紅/黑牌令 %dest ｢杀｣次數爲 0/上限",

  ["$kaamqprac1"] = "破阵杀敌，愿献犬马之劳！",
  ["$kaamqprac2"] = "虎啸既响，監兵当附！",
}
local S = require "packages/szyihhsoohssaet/szyih_guos"

kaamqprac:addEffect(fk.CardUsing, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(kaamqprac.name) 
    and target == player.room:getCurrent()
    and not player:isNude()
  end,
  on_cost= function(self, event, target, player, data)
    local cards=player.room:askToCards(player,{
			min_num=1,
			max_num=1,
			include_equip=false,
			pattern=tostring(Exppattern{ id = table.filter(player:getCardIds("h"),function(id)
				return Fk:getCardById(id).color ~= Card.NoColor and S.canSetVisible(id,1) --and not player:prohibitResponse(Fk:getCardById(id))
			end
			) }),
      prompt = "#kaamqprac-invoke::" .. target.id .. ":" .. data.card:toLogString(),
			cancelable = true,
		})
      if #cards==1 then
      local  color= Fk:getCardById(cards[1]).color
      event:setCostData(self, {tos={target},cards = cards,choice=color})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    S.setCardsVisible(event:getCostData(self).cards,1)

    if event:getCostData(self).choice==Card.Red then
      target:setCardUseHistory("ssaet", 0,Player.HistoryPhase )
    else
      local max = card.skill:getMaxUseTime(target,Player.HistoryPhase,Fk:cloneCard("ssaet"))  --无通用上限
      target:addCardUseHistory("ssaet", max- player:usedCardTimes("ssaet",Player.HistoryPhas))
    end
  end,
})

return kaamqprac
