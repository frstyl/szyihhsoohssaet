local tszjeqttwit = fk.CreateSkill {
  name = "tszjeqttwit",
}

Fk:loadTranslationTable{
  ["tszjeqttwit"] = "支絀",
  [":tszjeqttwit"] = "伱起動牌旹,伱可{減1存牌數/打出1牌}發動,伱{抽1,存牌數+1} ",

  ["#tszjeqttwit-invoke"] = "支絀 打出1牌存牌數+1 或減1存牌數抽1",
  -- ["$tszjeqttwit1"] = "将为军魂，需以身作则。",
  -- ["$tszjeqttwit2"] = "整肃三军，可育虎贲。",
}
local S = require "packages/szyihhsoohssaet/szyih_guos"

tszjeqttwit:addEffect(fk.CardUsing, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(tszjeqttwit.name) 
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local yes, ret = room:askToUseActiveSkill(player, {
      skill_name = "choose_cards_skill", 
      prompt = "#tszjeqttwit-invoke", 
      cancelable = true, 
      extra_data = {
        num = 1,
        min_num =S.getMaxCards(player)>0 and 0 or 1 ,
        include_equip = true,
        skillName = tszjeqttwit.name,
        pattern = tostring(Exppattern{ id = table.filter(player:getCardIds("he"), function (id)
      return not player:prohibitResponse(Fk:getCardById(id))
     end)}),
      }, 
      no_indicate = false,
      skip=true,

    })
    if yes then 
      local  choice = #ret.cards == 0 and "draw" or "discard"
      event:setCostData(self, {cards = ret.cards,choice=choice})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local cards =event:getCostData(self).cards
    if #cards == 0 then
      player:drawCards(1,tszjeqttwit.name)
      player.room:addPlayerMark(target, MarkEnum.MinusMaxCards, 1)
    else
      S.playCard(cards,tszjeqttwit.name,player)
      player.room:addPlayerMark(target, MarkEnum.AddMaxCards, 1)
    end
  end,
})

return tszjeqttwit
