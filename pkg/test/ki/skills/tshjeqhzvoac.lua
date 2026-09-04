Fk:loadTranslationTable{
  ["tshjeqhzvoac"] = "雌黃",
  [":tshjeqhzvoac"] = "一脚色聲明起動牌A後,伱可打出1牌B發動｡起動牌效改爲B｡A B須卽旹有目幖非應動",

  ["@tshjeqhzvoac-turn"] = "雌黃",

  ["$tshjeqhzvoac1"] = "喝啊！",
  ["$tshjeqhzvoac2"] = "今，必斩汝马下！",
}

local tshjeqhzvoac = fk.CreateSkill{
  name = "tshjeqhzvoac",
  -- tags = { Skill.Compulsory },
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 


tshjeqhzvoac:addEffect(fk.AfterCardUseDeclared, {
  can_trigger= function(self, event, target, player, data)
    return --target ~= player and 
    player:hasSkill(tshjeqhzvoac.name) 
    and S.getCardUsageType(data.card)==1
    and S.isTargetedCard(data.card)
    and not data.card.is_passive
    end,
  on_cost = function(self, event, target, player, data)
    local cards=player.room:askToCards(player, {
        skill_name = tshjeqhzvoac.name,
        min_num = 1,
        max_num = 1,
        prompt = "#tshjeqhzvoac-invoke::"..target.id,
        include_equip = true,
        cancelable = true,
        pattern = tostring(Exppattern{ id = table.filter(player:getHandlyIds(), function (id)
        local card = Fk:getCardById(id)
      return not player:prohibitResponse(card) and 
       S.getCardUsageType(card)==1 
       and   
        S.isTargetedCard(card)
        and not card.is_passive
        -- (card.skill:getMinTargetNum(target)>0) or  
        -- or (card.skill:fixTargets(target, card, {bypass_distances=true,bypass_times=true}) and #card.skill:fixTargets(target, card, {bypass_distances=true,bypass_times=true})>0)
    end)}),
      })
      if #cards>0 then
      event:setCostData(self, {tos = tos, cards = cards})
      return true
      end
  end,
  on_use = function(self, event, target, player, data)
    local card= Fk:getCardById(event:getCostData(self).cards[1])
      S.playCard({card.id},tshjeqhzvoac.name,player)

    -- data:changeCard(card.name, data.card.suit, data.card.number, tshjeqhzvoac.name)

    local newCard = data.card:clone()
    local c = table.simpleClone(data.card)
    for k, v in pairs(c) do
      card[k] = v
    end
    newCard.skill = card.skill
    data.card = newCard

end,
})



return tshjeqhzvoac
