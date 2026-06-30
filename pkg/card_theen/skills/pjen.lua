local equipSkill = fk.CreateSkill {
  name = "#pjen_skill",
  attached_equip = "pjen",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

equipSkill:addEffect(fk.TargetSpecified, {
  can_trigger = function(self, event, target, player, data)
    if target == player and player:hasSkill(equipSkill.name)  and data.card.trueName=="ssaet"  and data.card.suit~=player.NoSuit then
      return true    
    end
  end,
  on_cost = function(self, event, target, player, data)
    local suit =data.card.suit
      local cards = player.room:askToCards(data.from, {
        min_num = 1,
        max_num = 1,
        include_equip = false,
        skill_name = equipSkill.name,
        cancelable = true,
        prompt = "#pjen-discard::"..data.to.id..":"..data.card:toLogString(),
			  pattern=tostring(Exppattern{ id = table.filter(player:getCardIds("he"),function(id)
        local c = Fk:getCardById(id)
				return c.suit==suit and not player:prohibitResponse(c)
			end
			) }),
        skip = true
      })  
      if #cards>0 then
        event:setCostData(self,{cards=cards})
        return true
      end
  end,
  on_use = function(self, event, target, player, data)
    S.playCard(player,carevent:getCostData(self).cards,equipSkill.name)
    data.additionalDamage = (data.additionalDamage or 0) + 1
  end,

})

return equipSkill
