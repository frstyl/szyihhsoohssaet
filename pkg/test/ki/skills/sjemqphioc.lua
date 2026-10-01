local sjemqphioc = fk.CreateSkill {
  name = "sjemqphioc",
}


Fk:loadTranslationTable{ --拆解
  ["sjemqphioc"] = "銛鋒",
  [":sjemqphioc"] = "腳色A起動行動牌旹,若伱与其對位伱可發動,伱占卜,若占卜牌与起動牌:同色,伱對A虛擬起動｢殺｣;異色,伱弃置A 1牌",

  ["#sjemqphioc-invoke"] = "銛鋒 對 %src 發動",


  ["$sjemqphioc1"] = "賊子伱往若里去",
  ["$sjemqphioc2"] = "",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

sjemqphioc:addEffect(fk.CardUsing, {  -- --PreCardEffect
  anim_type = "offensive",
  prompt = "#sjemqphioc",
  can_trigger = function(self, event, target, player, data)
		if   player:hasSkill(sjemqphioc.name)
    and S.getCardTypeByName(data.card.trueName)==1
    then
      local seat = S.getSeats(player)
      return data.from==seat[1+#seat//2] or  data.from==seat[1+#seat//2+#seat%2]
    end

	end,
  on_cost = function(self, event, target, player, data)
    local room = player.room

    if room:askToSkillInvoke(player, { skill_name = sjemqphioc.name ,prompt="#sjemqphioc-invoke:"..data.from.id}) then
      event:setCostData(self, {tos = {data.from}})
      return true
    end
  end,
	on_use = function(self, event, target, player, data)
    local room=player.room
    local to=event:getCostData(self).tos[1]
    local judgeData = {
      who = player,
      reason = sjemqphioc.name,
      pattern = ".|.|"..data.card:getColorString(),
    }
    room:judge(judgeData)
    if judgeData.card.color==Card.NoColor or data.card.color==Card.NoColor then return end
    if  judgeData:matchPattern() then 
        room:useVirtualCard("ssaet", nil, player, to, sjemqphioc.name, true)
    elseif not data.from:isNude() then
      local cid = room:askToChooseCard(player, { target = to, flag = "he", skill_name = sjemqphioc.name })
      room:throwCard({cid}, sjemqphioc.name, to, player)
    end
  end,
})

return sjemqphioc
