local dzoacqkij = fk.CreateSkill {
  name = "dzoacqkij",
}

Fk:loadTranslationTable{
["dzoacqkij"] = "藏機",
[":dzoacqkij"] = "占卜牌生效前,伱可暗置伱1手牌B發動,占卜牌改爲虛擬B",  --謀奕猜拳眞行

["#dzoacqkij-invoke"] = "藏機 是否對%src 發動",
-- ["#dzoacqkijResult"] = "藏機: %from 于 %to 手牌數 %arg",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

dzoacqkij:addEffect(fk.AskForRetrial, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(dzoacqkij.name)

  end,
  on_cost = function(self, event, target, player, data)
    local cards=player.room:askToCards(player,{
			min_num=1,
			max_num=1,
			include_equip=false,
			pattern=tostring(Exppattern{ id = table.filter(player:getCardIds("h"),function(id)
				return S.canSetVisible(id)
			end
			) }),
      prompt = "#dzoacqkij-card::" .. target.id .. ":" .. data.card:toLogString(),
			cancelable = true,
		})
    if #cards==1 then
    event:setCostData(self, {tos={target},cards = cards})
    return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local card = Fk:getCardById(event:getCostData(self).cards[1])
    player.room:changeJudge{
      card = Fk:cloneCard(card.name,card.suit,card.number),
      player = player,
      data = data,
      skillName = dzoacqkij.name,
      response = false,
    }
    S.setCardsVisible(card)
  end,
})

return dzoacqkij
