local hzoanscioh = fk.CreateSkill {
  name = "hzoanscioh",
}

Fk:loadTranslationTable{
["hzoanscioh"] = "扞敔",
[":hzoanscioh"] = "牌被起動旹,伱記錄其花色｡殺被起動旹,伱可預打出1牌(此牌花色含于記錄)發動,伱令此｢殺｣起動无效",

["#hzoanscioh-invoke"] = "扞敔: %dest 起動 %arg 伱可打出1同花色牌發令其无效",

}

local S = require "packages/szyihhsoohssaet/szyih_guos"


hzoanscioh:addEffect(fk.CardUsing, {
  can_refresh = function(self, event, target, player, data)
    return player:hasSkill(hzoanscioh.name,true)
    and data.card and data.card.suit~=Card.NoSuit
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:addTableMarkIfNeed(player,"@hzoanscioh-turn",data.card:getSuitString(true))
  end,
  can_trigger = function(self, event, target, player, data)
    return target == player and  player:hasSkill(hzoanscioh.name) 
    and data.card.trueName == "ssaet" 
    and data.card.suit~=Card.NoSuit
    and not  player:isNude()
  end,
  on_cost = function(self, event, target, player, data)
    local suits=player:getTableMark("@hzoanscioh-turn")
    local cards=player.room:askToCards(player,{
			min_num=1,
			max_num=1,
			include_equip=false,
			pattern=tostring(Exppattern{ id = table.filter(player:getCardIds("he"),function(id)
        local card = Fk:getCardById(id)
				return not player:prohibitResponse(card)
        and table.contains(suits, card:getSuitString(true)) 
			end
			) }),
      prompt = "#hzoanscioh-invoke::" .. target.id .. ":" .. data.card:toLogString(),
			cancelable = true,
		})
      if #cards==1 then
      event:setCostData(self, {tos={target},cards = cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    S.playCard(cards,hzoanscioh.name,player)
    S.useNullify(data,player,hzoanscioh.name)
  end,
})

return hzoanscioh
