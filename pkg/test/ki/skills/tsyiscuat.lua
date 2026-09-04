local tsyiscuat = fk.CreateSkill {
  name = "tsyiscuat",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{
  ["tsyiscuat"] = "醉月",
  [":tsyiscuat"] = "伱起動｢殺/酒｣旹可發動:伱選擇➀獲得1｢殺/酒｣➁下起動殺或酒无視距離次數限制➂此起動額外生效1次,",--➃打出全部手牌(含酒),与1腳色等量傷害

  ["#tsyiscuat-invoke"] = "醉月 選擇",

  ["tsyiscuat-get"] = "醉月 獲得酒或殺",
  ["tsyiscuat-ignore"] = "醉月 无視距離次數限制",
  ["tsyiscuat-addtion"] = "醉月 額外生效",
  -- ["tsyiscuat-damage"] = "醉月 選擇",

  ["$tsyiscuat1"] = "紅頭賊將竟敢如此无禮",
  ["$tsyiscuat2"] = "速起軍馬拿了昰廝",
}

tsyiscuat:addEffect(fk.CardUsing, {
  anim_type = "offensive",
	can_trigger = function(self, event, target, player, data)
		return target==player and player:hasSkill(tsyiscuat.name)
    and (data.card.trueName=="ssaet" or data.card.trueName=="tsiuh" )
	end,
	on_cost = function(self, event, target, player, data)
    local choice=player.room:askToChoice(player,{
      cancelable=true,
      skill_name=tsyiscuat.name,
      prompt="#tsyiscuat-invoke",
      choices={
        "tsyiscuat-get",
      "tsyiscuat-ignore",
      "tsyiscuat-addtion",
      }
    })
    if choice~="Cancel" then
      event:setCostData(self,{choice=choice})
      return true
    end
  end,
	on_use = function(self, event, target, player, data)
    local choice=event:getCostData(self).choice
    if choice=="tsyiscuat-get" then
      S.printKhoucTo(player,1, tsyiscuat.name, data.card.trueName=="ssaet" and "tsiuh" or "ssaet")
    elseif  choice=="tsyiscuat-ignore" then
      local room=player.room
        -- room:addPlayerMark(player,"bypass_distances",1)
        -- room:addPlayerMark(player,"bypass_times",1)
        room:addPlayerMark(player,"tsyiscuat",1)
    elseif    "tsyiscuat-addtion" then
      data.additionalEffect=(data.additionalEffect or 0) +1
    elseif   "tsyiscuat-damage"then
      local cards= event:getCostData(self).cards,
        S.playCard(cards, tsyiscuat.name, player )
        room:damage({
          from = player,
          to = event:getCostData(self).tos[1],
          damage = #cards,
          damageType = fk.NormalDamage,
          skillName = tsyiscuat.name,
        })
    end
  end,
})


tsyiscuat:addEffect(fk.PreCardUse, {
	can_refresh = function(self, event, target, player, data)
		return target==player and player:hasMark("tsyiscuat")
    and (data.card.trueName=="ssaet" or data.card.trueName=="tsiuh" )
	end,
	on_refresh = function(self, event, target, player, data)
    data.extraUse=true
    player.room:setPlayerMark(player,"tsyiscuat",0)
  end,
})

tsyiscuat:addEffect("targetmod", {
  bypass_times = function(self, player, skill, scope, card, to)
    if player and card and player:hasMark("tsyiscuat")
    and (card.trueName=="ssaet" or card.trueName=="tsiuh" ) then
      return true 
    end
  end,
  bypass_distances = function(self, player, skill, card, to)
    if player and card and player:hasMark("tsyiscuat")
    and (card.trueName=="ssaet" or card.trueName=="tsiuh" ) then
      return true 
    end
  end,
})

return tsyiscuat
