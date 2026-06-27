local tshjeqhsooh = fk.CreateSkill{
  name = "tshjeqhsooh",
}


Fk:loadTranslationTable{
["tshjeqhsooh"] = "雌虎",
[":tshjeqhsooh"] = "一女角色A受到傷害後,若有傷源且不爲伱或A,伱可預打出x牌發動.伱与傷源1傷,令A回1｡x爲體力一半,下整",

["#tshjeqhsooh-choose"] = "雌虎 選擇一角色 視爲對其使用殺",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

tshjeqhsooh:addEffect(fk.Damaged, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(tshjeqhsooh.name) and target:isFemale() and data.from and data.from~=target and data.from~=player
  end,
  on_cost = function(self, event, target, player, data)
    local n =data.to.hp//2
    local cards=player.room:askToCards(player,{
			min_num=n,
			max_num=n,
			include_equip=false,
			pattern=tostring(Exppattern{ id = table.filter(player:getCardIds("h"),function(id)
				return not player:prohibitResponse(Fk:getCardById(id))
			end
			) }),
      prompt = "#tshjeqhsooh-card::" .. target.id .. ":" .. data.card:toLogString(),
			cancelable = true,
		})
      if #cards==1 then
      event:setCostData(self, {tos={target},cards = cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    S.playCard(player,event:getCostData(self).cards,tshjeqhsooh.name)
    if not player.dead and not data.from.dead then
    room:damage{
      from = player,
      to = data.from,
      damage = 1,
      skillName = tshjeqhsooh.name,
    }
    end
    if not player.dead and not target.dead and target:isWound() then
      room:recover{
        who = data.to,
        num = 1,
        recoverBy = player,
        skillName = tshjeqhsooh.name,
      }
    end
  end,
})

return tshjeqhsooh
