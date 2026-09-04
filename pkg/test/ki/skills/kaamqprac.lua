local kaamqprac = fk.CreateSkill {
  name = "kaamqprac",
}

Fk:loadTranslationTable{
  ["kaamqprac"] = "監兵",
  [":kaamqprac"] = "轉脚色起動牌旹,伱可打出1紅{黑/牌}發動.1轉脚色｢殺｣每段次數限制計數設爲{0/上限}",

  ["#kaamqprac-invoke"] = "監兵：伱可以打出一紅/黑牌令 %dest ｢杀｣次數爲 0/上限",

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
				return Fk:getCardById(id).color ~= Card.NoColor and not player:prohibitResponse(Fk:getCardById(id))
			end
			) }),
      prompt = "#kaamqprac-invoke::" .. target.id .. ":" .. data.card:toLogString(),
			cancelable = true,
		})
      if #cards==1 then
      local  color= Fk:getCardById(cards[1]).color
      event:setCostData(self, {tos={target},cards = cards,color=color})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    S.playCard(event:getCostData(self).cards,kaamqprac.name,player)
    local card =Fk:cloneCard("ssaet")  --setVSPattern neg
    -- card:setVSPattern(nil,target,"ssaet|z|z|z")
    if event:getCostData(self).color==Card.Red then
      target:setCardUseHistory(card.trueName, 0,Player.HistoryPhase )
    else
        local max = card.skill:getMaxUseTime(target,Player.HistoryPhase,card)
        target:addCardUseHistory(card.trueName, max- player:usedCardTimes(card.trueName,Player.HistoryPhas))
    end
  end,
})

return kaamqprac
