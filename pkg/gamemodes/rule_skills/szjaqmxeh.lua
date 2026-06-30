local szjaqmxeh = fk.CreateSkill {
  name = "#szjaqmxeh",
}

Fk:loadTranslationTable{
  ["szjaqmxeh"] = "奢靡",
  [":szjaqmxeh"] = "伱使用基本牌旹,預弃1手牌發動,此牌數值+1",  --限1次
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

szjaqmxeh:addEffect(fk.CardUsing, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(szjaqmxeh.name) and data.card.type == Card.TypeBasic
    and not player:isKongcheng()
    and player:usedEffectTimes(szjaqmxeh.name, Player.HistoryPhase)<1
  end,
  on_cost = function(self, event, target, player, data)
      local card =  S.askToPlayCard(target, {
        min_num = 1,
        max_num = 1,
        include_equip = false,
        skill_name = loeoksoak.name,
        cancelable = false,
        prompt = "#loeoksoak-discard",
        skip = true,
        cancelable=true,
      })   
      if #card>0 then 
        event:setCostData(self,{cards=card})
        return true
      end
  end,
  on_use = function(self, event, target, player, data)
    S.playCard(player,event:getCostData(self).cards,szjaqmxeh.name)
      if data.card.is_damage_card then
        data.additionalDamage = (data.additionalDamage or 0) + 1
      elseif data.card.name == "nziuk" then
        data.additionalRecover = (data.additionalRecover or 0) + 1
      elseif data.card.name == "tsiuh" then
        if data.extra_data and data.extra_data.analepticRecover then
          data.additionalRecover = (data.additionalRecover or 0) + 1
        else
          data.extra_data = data.extra_data or {}
          data.extra_data.additionalDrank = (data.extra_data.additionalDrank or 0) + 1
        end
      end

  end,
})


return szjaqmxeh
