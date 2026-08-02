local lvoansddxins = fk.CreateSkill{
  name = "lvoansddxins",
}

Fk:loadTranslationTable{
  ["lvoansddxins"] = "亂陳",
  [":lvoansddxins"] = "A起動牌對目幖生效前(每次起動限1次),若伱至A距離等于1,伱可弃置A 1牌發動｡若弃牌与B同花,B對目幖无效",

  ["#lvoansddxins-ask"] = "龍濳 是否對 %src 發動",
  ["#lvoansddxins-choose"] = "龍濳 選擇1手牌",

  ["$lvoansddxins1"] = "且慢",  --
  -- ["$lvoansddxins1"] = "慢著,不要輕動",  --
  ["$lvoansddxins2"] = "待俺尋思尋思",
  ["$lvoansddxins3"] = "緟新開始夫",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 


-- Fk:addPoxiMethod{
--   name = "lvoansddxins_discard",
--   prompt = "#lvoansddxins-ask",
--   card_filter = function(to_select, selected, data)

--     return not (Self:prohibitDiscard(Fk:getCardById(to_select)) and table.contains(data[1][2], to_select))
--   end,
--   feasible = function(selected)
--     return #selected == 1
--   end,
-- }
lvoansddxins:addEffect(fk.PreCardEffect, {  --TargetSpecifying TargetConfirming
  anim_type = "defensive", 
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(lvoansddxins.name)
    and data.from
    -- and data.from~=player
    and player:compareDistance(data.from,1,"==")
    and not (data.use and data.use.extra_data and  data.use.extra_data.lvoansddxins and table.contains(data.use.extra_data.lvoansddxins ,player.id))
	  and not data.from:isNude()
    -- and S.getCardTypeByName(data.card.name)==2
  end,
  on_cost = function(self, event, target, player, data)
    local ids = player.room:askToChooseCards(player, {
      min=0,
      max=1,
      target = data.from,
      flag = "he",
      skill_name = lvoansddxins.name,
      cancelable=true,
    })
    if  #ids>0 then
      event:setCostData(self,{cards=ids})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    if data.use then 
      data.use.extra_data=data.use.extra_data or {}
      data.use.extra_data.lvoansddxins=data.use.extra_data.lvoansddxins or {}
      table.insert(data.use.extra_data.lvoansddxins,player.id)
    end
    local cards= event:getCostData(self).cards
    room:throwCard(cards, lvoansddxins.name, data.from, player)
    if data.card:compareSuitWith(Fk:getCardById(cards[1])) then
      S.effectNullify(data,player,lvoansddxins.name)
    end

    -- return true
  end,
})



return lvoansddxins
