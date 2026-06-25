local kxippoavs = fk.CreateSkill{
  name = "kxippoavs",
}

Fk:loadTranslationTable{
["kxippoavs"] = "急報",
[":kxippoavs"] = "轉始旹記彔伱手牌數.任意轉終旹,若伱手牌數与轉始旹相等,伱可預打出1手牌發動,伱獲得1額外轉",

["#kxippoavs-invoke"] = "急報 %src 轉終 是否打出牌執行額外轉",
["@kxippoavs-turn"] = "急報",

["$kxippoavs1"] = "快",
-- ["$kxippoavs2"] = "兄弟,吾先行一步",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

kxippoavs:addEffect(fk.TurnStart, {
  priority=10,
  can_refresh = function(self, event, target, player, data)
    return  player:hasSkill(kxippoavs.name,true,true)
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:setPlayerMark(player,"@kxippoavs-turn", #player:getCardIds("h"))
  end,
})

kxippoavs:addEffect(fk.TurnEnd, {
  anim_type = "drawcard",
  is_delay_effect = true,
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(kxippoavs.name) and player:getMark("@kxippoavs-turn")>0 and player:getMark("@kxippoavs-turn") == #player:getCardIds("h")
  end,
  on_cost = function(self, event, target, player, data)
    local room=player.room
    local cards=player.room:askToCards(player,{
			min_num=1,
			max_num=1,
			include_equip=false,
			pattern=tostring(Exppattern{ id = table.filter(player:getCardIds("h"),function(id)
				return  not player:prohibitResponse(Fk:getCardById(id))
			end
			) }),
      prompt = "#kxippoavs-invoke:" .. target.id,
			cancelable = true,
		})
      if #cards >0 then
        event:setCostData(self, { cards = cards})
        return true
      end
    end,
  on_use = function(self, event, target, player, data)
    local room=player.room

    room:responseCard({
				card=Fk:getCardById(event:getCostData(self).cards[1]),
				from=player,
				attachedSkillAndUser={muteCard=true},
			})
          -- room:throwCard(event:getCostData(self).cards, kxippoavs.name, player, player)
    player:gainAnExtraTurn(true, kxippoavs.name)
  end,
})

return kxippoavs
