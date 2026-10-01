local tthaakddxins = fk.CreateSkill{
  name = "tthaakddxins",
}

Fk:loadTranslationTable{
  ["tthaakddxins"] = "坼陣",
  [":tthaakddxins"] = "應動｡A起動牌對目幖生效前(每次起動限1次),若伱至A距離等于1,伱可弃置A 1牌發動｡若所弃牌与B同花,B對目幖起動无效",

  ["#tthaakddxins-ask"] = "坼陣 是否對 %src 發動",
  ["#tthaakddxins-choose"] = "坼陣 選擇1牌",

  ["$tthaakddxins1"] = "且慢",  --
  -- ["$tthaakddxins1"] = "慢著,不要輕動",  --
  ["$tthaakddxins2"] = "待俺尋思尋思",
  ["$tthaakddxins3"] = "緟新開始夫",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 


-- Fk:addPoxiMethod{
--   name = "tthaakddxins_discard",
--   prompt = "#tthaakddxins-ask",
--   card_filter = function(to_select, selected, data)

--     return not (Self:prohibitDiscard(Fk:getCardById(to_select)) and table.contains(data[1][2], to_select))
--   end,
--   feasible = function(selected)
--     return #selected == 1
--   end,
-- }
tthaakddxins:addEffect(fk.PreCardEffect, {  --TargetSpecifying TargetConfirming
  anim_type = "defensive", 
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(tthaakddxins.name)
    and data.from
    -- and data.from~=player
    and player:compareDistance(data.from,1,"==")
    and not (data.use and data.use.extra_data and  data.use.extra_data.tthaakddxins and table.contains(data.use.extra_data.tthaakddxins ,player.id))
	  and not data.from:isNude()
    -- and S.getCardTypeByName(data.card.name)==2
  end,
  on_cost = function(self, event, target, player, data)
    local ids = player.room:askToChooseCards(player, {
      min=0,
      max=1,
      target = data.from,
      flag = "he",
      skill_name = tthaakddxins.name,
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
      data.use.extra_data.tthaakddxins=data.use.extra_data.tthaakddxins or {}
      table.insert(data.use.extra_data.tthaakddxins,player.id)
    end
    local cards= event:getCostData(self).cards
    room:throwCard(cards, tthaakddxins.name, data.from, player)
    if data.card:compareSuitWith(Fk:getCardById(cards[1])) then
      S.effectNullify(data,player,tthaakddxins.name,true)
    end

    -- return true
  end,
})



return tthaakddxins
