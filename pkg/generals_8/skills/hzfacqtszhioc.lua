local hzfacqtszhioc = fk.CreateSkill {
  name = "hzfacqtszhioc",
}

Fk:loadTranslationTable{
["hzfacqtszhioc"] = "橫䡴",
[":hzfacqtszhioc"] = "當伱所使用殺{被閃抵消/對目幖致傷}後,伱可預弃伱或殺目幖1牌發動.若此牌与殺同色,令此殺{反抵消/傷害值+1}.此殺致傷後伱予對目幖角色上家或下家相同傷害",

["#hzfacqtszhioc-invoke"] = "橫䡴 弃伱或 %src 牌, 若爲 %arg  殺生效",
["#hzfacqtszhioc-choose"] = "橫䡴 選擇目幖 予其相同傷害",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

hzfacqtszhioc:addEffect(fk.CardEffectCancelledOut, {
  can_trigger = function(self, event, target, player, data)-- data.isCancellOut  and
    return player:hasSkill(hzfacqtszhioc.name) and data.from == player and data.card.trueName == "ssaet" and not data.to.dead
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room

    local to, cards = room:askToChooseCardsAndPlayers(player, {
      min_card_num = 0,
      max_card_num = 1,
      min_num = 0,
      max_num = not data.to:isNude() and 1 or 0,
      targets = {data.to},
      skill_name = hzfacqtszhioc.name,
      prompt = "#hzfacqtszhioc-invoke:"..data.to.id.."::"..data.card:getSuitString(), 
      will_throw=true,
      cancelable = true,
    })
    if #to > 0 then
     cards = room:askToChooseCards(player, {
       target = to[1],
        min = 1,
        max = 1,
        flag = "he",
        skill_name = hzfacqtszhioc.name,
       })
    end
    if #cards > 0 then
    event:setCostData(self, { cards = cards,who=to[1] or player})  --no tos
    return true
    end
    end,
  on_use = function(self, event, target, player, data)
    local id =event:getCostData(self).cards[1]
    local check=not player:prohibitDiscard(id) and Fk:getCardById(event:getCostData(self).cards[1]):compareSuitWith(data.card)--同色?
    player.room:throwCard({id}, hzfacqtszhioc.name, event:getCostData(self).who, player) --
    if check then
      data.isCancellOut = false

      data.use.extra_data=    data.use.extra_data or {}
      data.use.extra_data.hzfacqtszhioc={
        from=player.id,
        card=data.card.id,
      }
    end
        -- room:addTableMark(player,"@@hzfacqtszhioc-phase", card.use.event.id)
    end,
})

hzfacqtszhioc:addEffect(fk.DamageCaused, {
  can_trigger = function(self, event, target, player, data)-- data.isCancellOut  and
    if player:hasSkill(hzfacqtszhioc.name) and data.from == player and data.card.trueName == "ssaet" and not data.to.dead then
      local use_event = player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true) --插入?? .parent
      if use_event then
        local use = use_event.data
        if  use.card==data.card then
            return not (use.extra_data and use.extra_data.hzfacqtszhioc)

        end
      end

      return true 
    end
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room

    local to, cards = room:askToChooseCardsAndPlayers(player, {
      min_card_num = 0,
      max_card_num = 1,
      min_num = 0,
      max_num = not data.to:isNude() and 1 or 0,
      targets = {data.to},
      skill_name = hzfacqtszhioc.name,
      prompt = "#hzfacqtszhioc-invoke:"..data.to.id.."::"..data.card:getSuitString(), 
      will_throw=true,
      cancelable = true,
    })
    if #to > 0 then
     cards = room:askToChooseCards(player, {
       target = to[1],
        min = 1,
        max = 1,
        flag = "he",
        skill_name = hzfacqtszhioc.name,
       })
    end
    if #cards > 0 then
    event:setCostData(self, { cards = cards,who=to[1] or player})  --no tos
    return true
    end
    end,
  on_use = function(self, event, target, player, data)
    local id =event:getCostData(self).cards[1]
    local check=not player:prohibitDiscard(id) and Fk:getCardById(event:getCostData(self).cards[1]):compareSuitWith(data.card)--同色?
    player.room:throwCard({id}, hzfacqtszhioc.name, event:getCostData(self).who, player) --
    if not check then return end
      S.changeDamage({damageData=data, num=1,skillName=hzfacqtszhioc.name})

      local use_event = player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true) --插入?? .parent
      if use_event then
        local use = use_event.data
        if  use.card==data.card then
            use.extra_data=    use.extra_data or {}
            use.extra_data.hzfacqtszhioc={
              from=player.id,
              card=data.card.id,
            }
          
        end
      end

    end,
})

hzfacqtszhioc:addEffect(fk.Damage, {
  is_delay_effect = true,
  can_trigger = function(self, event, target, player, data)
    if player.seat==1  and data.by_user and player.room.logic:damageByCardEffect() then  --目幖
      local use_event = player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true) --插入?? .parent
      if use_event then
        local use = use_event.data
        if use.extra_data and use.extra_data.hzfacqtszhioc  
            and use.card==data.card 
        then
            event:setCostData(self,{from=player.room:getPlayerById(use.extra_data.hzfacqtszhioc.from)})
            return true

        end
      end
    end
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room
    local from=event:getCostData(self).from
    local targets={}
    table.insert(targets, S.getNextOne(data.to,-1))
    table.insertIfNeed(targets, S.getNextOne(data.to,1))
    local to = room:askToChoosePlayers(from, {
        targets = targets,
        min_num = 1,
        max_num = 1,
        prompt = "#hzfacqtszhioc-choose",
        skill_name = hzfacqtszhioc.name,
        cancelable = false,
      })  
      if #to==1 then 
        room:damage({
          to = to[1],
          from=from,
          damage = data.damage,
          damageType = data.damageType,
          skillName = data.skillName,  --止有一个
          chain = data.chain,
          card = data.card,
        })
      end
  end,
})
return hzfacqtszhioc
