
local pjecskrak = fk.CreateSkill {
  name = "pjecskrak",
}

Fk:loadTranslationTable{
["pjecskrak"] = "并戟",
[":pjecskrak"] = "印牌:以伱2同大類牌轉化起動「殺」.此「殺」无視距離限制目幖上限+x(x爲伱已損體力値),且若子牌類爲:行動,此「殺」需抵消數+1;奇,越過次數限制;實體,此「殺」指定目幖後无效其防具技能1段",
--區分伱已此法所起動 与 此牌?
["#pjecskrak"] = "2同類牌轉化爲殺",

["$pjecskrak1"] = "來一个,殺一个.來一對,殺一雙",
["$pjecskrak2"] = "絳霞影裏,卷一道凍地仌霜",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

pjecskrak:addEffect("viewas", {
  anim_type = "offensive",
  prompt = "#pjecskrak",
  pattern = "ssaet",
  card_filter = function(self, player, to_select, selected)
    return  #selected == 0 or 
      (#selected == 1 
      and 
		S.compareCardType(Fk:getCardById(to_select).name,Fk:getCardById(selected[1]).name, 3)

    )
    -- if to_select.getTypeString() ==selected[1].getTypeString

  end,
  include_equip=true,
  view_as = function(self, player, cards)
    if #cards ~= 2 then return  end
    local card = Fk:cloneCard("ssaet")
    card:addSubcards(cards)
    card.skillName = pjecskrak.name
    S.mixCard(card)
    return card
  end,
 
  -- before_use = function(self, player, use)
  -- if Fk:getCardById(use.card.subcards[1]).type==Card.TypeTrick then
  --   use.extraUse =true
  --   end
  -- end,
  enabled_at_response = function(self, player, response)
    return  not response
  end,
})

pjecskrak:addEffect("targetmod", {
  bypass_times = function(self, player, skill, scope, card)
    return card --and scope == Player.HistoryPhase 
    and table.contains(card.skillNames, pjecskrak.name)
    -- and Fk:getCardById().type==Card.TypeTrick
    and (not card.subcards[1] or S.getCardSuptypeByName(Fk:getCardById(card.subcards[1])) == 2)  --bug
  end,
  bypass_distances = function(self, player, skill, card)
    return card and card.skillNames and table.contains(card.skillNames, pjecskrak.name)
  end,
  extra_target_func = function(self, player, skill, card)
    if card and card.skillNames and table.contains(card.skillNames, pjecskrak.name) then
      return player:getLostHp()
    end
  end,
})

pjecskrak:addEffect(fk.TargetConfirmed, {
  can_trigger = function(self, event, target, player, data)
    return data.from == player  
    and data.card  --問一次
    and data.card.skillNames  and table.contains(data.card.skillNames, pjecskrak.name) 
    and S.getCardSuptypeByName(Fk:getCardById(data.card.subcards[1]).trueName) ~=2
    -- and S.getCardTypeByName(Fk:getCardById(card.subcards[1])) == 3
    and not data.to.dead 
  end,
  on_trigger= function(self, event, target, player, data)
    if S.getCardSuptypeByName(Fk:getCardById(data.card.subcards[1]).trueName) ==1 then
      data:setResponseTimes(1+data:getResponseTimes(data.to), data.to) 
    else
      player.room:addPlayerMark(data.to, "@@MarkArmorNullified-phase",1)
    end
  end,
})


return pjecskrak

