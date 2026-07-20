local hzfacqtszhioc = fk.CreateSkill {
  name = "hzfacqtszhioc",
}

Fk:loadTranslationTable{
["hzfacqtszhioc"] = "橫䡴",
[":hzfacqtszhioc"] = "一｢殺｣被閃抵消後,若此｢殺｣在伱攻程內,伱可預打出伱1牌与｢殺｣同色者發動.此殺反抵消,且伱可令此｢殺｣額外對目幖上下或下加生效1次",

["#hzfacqtszhioc-invoke"] = "橫䡴 伱可打出同花牌, 令 %arg 對 %dest 生效",
["#hzfacqtszhioc-choose"] = "橫䡴 選擇目幖 殺對其生效1次",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

hzfacqtszhioc:addEffect(fk.CardEffectCancelledOut, {
  can_trigger = function(self, event, target, player, data)-- data.isCancellOut  and
    return player:hasSkill(hzfacqtszhioc.name) 
    -- and data.from == player 
    and data.to==player or player:inMyAttackRange(data.to)
    and data.card.trueName == "ssaet" 
    and not player:isNude()
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
		local cards = S.askToPlayCard(player, {
		  min_num = 1,
		  max_num = 1,
		  include_equip = true,
		  skill_name = hzfacqtszhioc.name,
		  cancelable = true,
      pattern = ".|.|"..data.card:getSuitString(),
      prompt = "#hzfacqtszhioc-invoke::"..data.card:toLogString().."::"..data.to.id,
		  skip = true,
		})
    if #cards > 0 then
      event:setCostData(self, { cards = cards,tos={data.to}})  --no tos
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    S.playCard(player,event:getCostData(self).cards, hzfacqtszhioc.name)
    data.isCancellOut = false
    if player.dead then return end
    if not data.use then return end
    local tos ={}
    table.insert(tos,S.getNextOne(data.to,1))
    table.insertIfNeed(tos,S.getNextOne(data.to,-1))

    local to = player.room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = tos,
      skill_name = hzfacqtszhioc.name,
      prompt = "#hzfacqtszhioc-choose",
      cancelable = true,
    })
    if to[1] then
      player:drawCards(2)
      data.extra_data=data.extra_data or {}
      data.extra_data.hzfacqtszhioc=to[1].id
      -- data.use.additionalEffectToPlayer = data.use.additionalEffectToPlayer or {}
      -- data.use.additionalEffectToPlayer[to[1]] =(data.use.additionalEffectToPlayer[to[1]] or 0) +1
    
      -- local cardEffectData=table.simpleClone(data)

      local cardEffectData={
          card=data.card,
          tos=data.tos,
          to=to[1], 
          from=data.from,
          subTos = data.subTos,
          card = data.card,
          toCard = data.toCard,
          use = data,
          responseToEvent = data.responseToEvent,
          additionalDamage = data.additionalDamage,
          additionalRecover = data.additionalRecover,
          cardsResponded = data.cardsResponded,
          prohibitedCardNames = data.prohibitedCardNames,
          extra_data = data.extra_data,
          event_data=data.event_data,
        }
      local curCardEffectEvent = CardEffectData:new(cardEffectData)
      player.room:doCardEffect(curCardEffectEvent)

    end
    
  end,
})

-- hzfacqtszhioc:addEffect(fk.CardEffectFinished, {
--   can_trigger = function(self, event, target, player, data)
--     return data.extra_data 
--     and data.extra_data.hzfacqtszhioc 
--     and not player.room:getPlayerById(data.extra_data.hzfacqtszhioc).dead
--   end,
--   can_trigger = function(self, event, target, player, data)

--   end
-- })
return hzfacqtszhioc
