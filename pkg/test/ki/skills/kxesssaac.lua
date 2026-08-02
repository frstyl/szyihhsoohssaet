local kxesssaac = fk.CreateSkill({
  name = "kxesssaac",
})

Fk:loadTranslationTable{
  ["kxesssaac"] = "寄生",
  [":kxesssaac"] = "其它脚色A轉始旹,伱可預打出1手牌發動,當轉內,A起動牌旹,伱抽1",


  ["#kxesssaac-invoke"] = "寄生:%dest 轉始,發動",

  ["$kxesssaac1"] = "伱昰太乙三才陣何足爲奇",
  ["$kxesssaac2"] = "九宮八卦已无敵,河洛四像眞堪奇",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"


kxesssaac:addEffect(fk.TurnStart, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return
      player:hasSkill(kxesssaac.name) 
      and target ~= player 
  end,
  on_cost = function(self, event, target, player, data)
    local room = room

    local cards=player.room:askToCards(player,{
			min_num=1,
			max_num=1,
			include_equip=false,
			pattern=tostring(Exppattern{ id = table.filter(player:getCardIds("h"),function(id)
				return  not player:prohibitResponse(Fk:getCardById(id))
			end
			) }),
      prompt = "#kxesssaac-invoke::" .. target.id ,
			cancelable = true,
		})
      if #cards==1 then
      event:setCostData(self, {tos={target},cards = cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room

    local cards=event:getCostData(self).cards
    room:addTableMarkIfNeed(player,"kxesssaac",target.id)
    S.playCard(player,cards,kxesssaac.name)
    
    room.logic:getCurrentEvent():findParent(GameEvent.Turn, true):addCleaner(function()
      local t= player:getTableMark("kxesssaac")
      table.removeOne(t, target.id)
      room:setPlayerMark(player,"kxesssaac",t)
    end)

  end,
})

kxesssaac:addEffect(fk.CardUsing, {
  anim_type = "drawcard",
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    return 
      table.contains(player:getTableMark("kxesssaac"),target.id)
  end,
  on_use = function(self, event, target, player, data)
    player:drawCards(1,kxesssaac.name)
  end,
})
return kxesssaac
