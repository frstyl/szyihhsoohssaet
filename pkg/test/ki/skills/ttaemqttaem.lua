local ttaemqttaem = fk.CreateSkill {
  name = "ttaemqttaem",
}

Fk:loadTranslationTable{
  ["ttaemqttaem"] = "詀詀",
  [":ttaemqttaem"] = "其它腳色A主旹,若伱可与A賭鬥,伱可選擇伱1手牌B未暗置者發動,伱暗置1輪B,以虛擬B与A賭鬥",

  ["#ttaemqttaem-card"] = "詀詀 %dest",
  -- ["$jjeqdzius1"] = "",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

ttaemqttaem:addEffect(fk.BeforePlayCard, {
  anim_type = "control",
  can_trigger = function (self, event, target, player, data)
    return target ~= player
    and player:hasSkill(ttaemqttaem.name)
    and player:canPindian(target)
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
      prompt = "#ttaemqttaem-card::" .. target.id ,
			cancelable = true,
		})
    if #cards==1 then
    event:setCostData(self, {tos={target},cards = cards})
    return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local old =  Fk:getCardById(event:getCostData(self).cards[1])
    local card = Fk:cloneCard(old.name,old.suit,old.number)
    S.setCardsVisible(old,-1, "-round")
    local pindian = player:pindian({target},ttaemqttaem.name,card)

  end,
})




return ttaemqttaem
