

local maanqhzfacs= fk.CreateSkill({
  name = "maanqhzfacs",
  tags={Skill.Compulsory}
})

Fk:loadTranslationTable{
["maanqhzfacs"] = "蠻橫",
[":maanqhzfacs"] = "鎖｡伱錦囊牌視爲殺.伱使用殺旹,傷害基數+x,指定目幖後,无效其防具至當本終｡(x=(殺子牌牌名字數之合)/2,下取整)",
}


local S = require "packages/szyihhsoohssaet/szyih_guos" 

maanqhzfacs:addEffect("filter", {
  card_filter = function(self, to_select, player)
    return player:hasSkill(maanqhzfacs.name) and S.getCardTypeByName(to_select.name)==2 and
      table.contains(player:getCardIds("h"), to_select.id)
  end,
  view_as = function(self, player, to_select)
    local card = Fk:cloneCard("ssaet", to_select.suit, to_select.number)
    card.skillName = maanqhzfacs.name
    return card
  end,
})


-- maanqhzfacs:addEffect(fk.PreCardEffect, {
--   can_refresh = function(self, event, target, player, data)
--     return target==player and  data.card  --問一次
--   and table.contains(data.card.skillNames, maanqhzfacs.name) 
--   end,
--   on_refresh = function (self, event, target, player, data)
      -- data.extra_data=data.extra_data or {}
      -- data.extra_data.ignoreArmorTo=table.simpleClone(player.room.players)
--   end,
-- })

-- maanqhzfacs:addEffect(fk.CardUseNullified, {
--   can_refresh = function(self, event, target, player, data)
--     return target==player and  data.card  --問一次
--   and table.contains(data.card.skillNames, maanqhzfacs.name) 
--   end,
--   on_refresh = function (self, event, target, player, data)
--     -- player:drawCards(10,maanqhzfacs.name)
--     data.nullified=false
--   end,
-- })

-- maanqhzfacs:addEffect(fk.CardEffectNullified, {
--   can_refresh = function(self, event, target, player, data)
--     return target==player and  data.card  --問一次
--   and table.contains(data.card.skillNames, maanqhzfacs.name) 
--   end,
--   on_refresh = function (self, event, target, player, data)
--     data:antiNullify()
--   end,
-- })
-- maanqhzfacs:addEffect(fk.PreCardEffect, {
--   priority= 0, 
--   can_refresh = function(self, event, target, player, data)
--     if  data.card  
--   and table.contains(data.card.skillNames, maanqhzfacs.name) then
--         player:drawCards(1,maanqhzfacs.name)
--         return true
--   end
--   -- and data:isNullified()==true
--   end,
--   on_refresh = function(self, event, target, player, data)
--       player:drawCards(10,maanqhzfacs.name)
--     data.nullified=false
--     if  data.use and data.use.nullifiedTargets  then
--       table.remove(data.use.nullifiedTargets,data.to)
--     end
--   end,
-- })



-- maanqhzfacs:addEffect(fk.PreCardUse, {  --PreCardUse 无旹機
--   can_refresh = function(self, event, target, player, data)
--     return target==player and data.card
--     and table.contains(data.card.skillNames, maanqhzfacs.name)
--   end,
--   on_refresh = function(self, event, target, player, data)
--     data.additionalDamage = (data.additionalDamage or 0) + 1
--     data.extra_data=  data.extra_data or {}
--     data.extra_data.antiNullify=true
--   end,
-- })

maanqhzfacs:addEffect(fk.CardUsing, {  --PreCardUse 无旹機
  can_trigger = function(self, event, target, player, data)
    return target==player and data.card and data.card.trueName=="ssaet" 
    --and #data.card.subcards>0
  end,
  on_use = function(self, event, target, player, data)
    local n=0
    if data.card:isVirtual() then
      for _, id in ipairs(data.card.subcards or {}) do
        n = n + S.getCardNameLength(id)
      end
    elseif data.card.trueName~=Fk:getCardById(data.card.id,true).trueName then
        n = n + S.getCardNameLength(data.card)
    end
    data.additionalDamage = (data.additionalDamage or 0) + (n)//2
    data.extra_data=  data.extra_data or {}
    data.extra_data.antiNullify=true
  end,
})

-- maanqhzfacs:addEffect(fk.TargetSpecified, {  --不算發動技能
--   can_trigger = function (self, event, target, player, data)
--     return  data.from==player --問一次
--     -- and table.contains(data.card.skillNames, maanqhzfacs.name)
    
--   end,
--   on_trigger = function (self, event, target, player, data)
--     player.room:setPlayerMark(data.to, "@@MarkArmorNullified-round",1)  --同旹清理
--   end
-- })

return maanqhzfacs
