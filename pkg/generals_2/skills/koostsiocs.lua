
local koostsiocs = fk.CreateSkill {
  name = "koostsiocs",
}

Fk:loadTranslationTable{
["koostsiocs"] = "故縱",
[":koostsiocs"] = "當其它角色A可使用打出閃旹,若其可因此使用/打出虛擬閃,伱可打出閃,若伱打出,發動.視爲A元旹機使用/打出虛閃.此閃結算後,伱可執行:伱弃置A區域1牌2次,伱抽1",

["#koostsiocs-invoke"] = "故縱: 代替 %src 使用打出閃",
["#koostsiocs-discard"] = "故縱: 是否弃 %src 牌",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

-- local koostsiocs_on_cost= function(self, event, target, player, data)
--   local cards = player.room:askToCards(player, {
--       min_num = 1,
--       max_num = 1,
--       skill_name = koostsiocs.name,
--       pattern = tostring(Exppattern{ id = table.filter(player:getHandlyIds(), function (id)  --handly?
--         local card = Fk:getCardById(id)
--       return not player:prohibitResponse(card) and S.getCardTypeByName(card.trueName)~= 1
--     end)}),
--       prompt = "#koostsiocs-invoke:"..target.id,
--       cancelable = true,
--     })
--       if #cards == 1 then
--       event:setCostData(self,{cards=cards})
--       return  true
--     end
-- end

-- local koostsiocs_on_cost= function(self, event, target, player, data)
--     local yes, dat = player.room:askToUseActiveSkill(player, {  --askToChooseCardsAndPlayers 等實調用此 askToUseActiveSkill
--       skill_name = "tszjinshzaek",
--       prompt = "#koostsiocs-invoke:"..target.id,
--       cancelable = true,
--       skip = true,  --不執行
--       -- extra_data = {
--       --   expand_pile = temp,
--       --   skillName = pujqkiams.name,
--       -- },
--       --  = {ids=ids},
--     })
--     if yes and dat then
--       event:setCostData(self,{cards=dat.cards})
--       return  true
--     end
-- end
local koostsiocs_on_cost= function(self, event, target, player, data)
    local respond = room:askToResponse(p, params)
    if respond then
      respond.skipDrop = true
      room:responseCard(respond)

      event:setCostData(self,{cards=dat.cards})
      return  true
    end
end
local koostsiocs_on_use = function(self, event, target, player, data)
    local room = player.room
    local respond={
      card=Fk:getCardById(event:getCostData(self).cards[1]),
      from=player,
      attachedSkillAndUser={muteCard=true},
    }
    room:responseCard(respond)
    local new_card = Fk:cloneCard('szjemh')
    new_card.skillName = koostsiocs.name
    local result={            
      from = target,
      card = new_card,
      responseToEvent=data.event,
    }
    if event == fk.AskForCardUse then
      result.tos = {}
    end

    result.extra_data=result.extra_data or {}
    local koostsiocs=result.extra_data.koostsiocs or {}
    table.insertIfNeed(koostsiocs,player.id)
    result.extra_data.koostsiocs=koostsiocs
    data.result = result

    return true
end

local koostsiocs_delay_spec ={
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    return data.extra_data and data.extra_data.koostsiocs and table.contains(data.extra_data.koostsiocs, player.id) 
    and player.room:askToSkillInvoke(player,{
          skill_name=koostsiocs.name,
          prompt ="#koostsiocs-discard:"..data.from.id
        }) 
      end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room
    for i=1,2,1 do
      if player.dead or data.from.dead or data.from:isAllNude() then return end
      local cid = room:askToChooseCard(player, { target = data.from, flag = "hej", skill_name = koostsiocs.name })
      room:throwCard({cid}, koostsiocs.name, data.from, player)
    end
    player:drawCards(1,koostsiocs.name)
  end,
}

koostsiocs:addEffect(fk.AskForCardUse, {
  can_trigger = function(self, event, target, player, data)
    return  target and target ~= player and
    player:hasSkill(koostsiocs.name) 
    and Exppattern:Parse(data.pattern):matchExp("szjemh|0|nosuit|none") 
    -- and not player:prohibitUse(Fk:cloneCard("szjemh"))
    and not target:prohibitUse(Fk:cloneCard("szjemh"))
    and not player:prohibitResponse(Fk:cloneCard("szjemh"))
  end,
  -- on_cost = function(self, event, target, player, data)
  --   local response = player.room:askToUseCard(player,{ ---@type AskToUseCardParams
  --       skill_name = koostsiocs.name,
  --       pattern = 'szjemh',  --待
  --       prompt = "#koostsiocs-ask:" .. target.id,
  --       cancelable = true,
  --       -- event_data = effect
  --     })
  --   if response then
  --     event:setCostData(self, {responses = response})
  --     return true
  --   end
  -- end,
  on_cost = koostsiocs_on_cost,
  on_use = koostsiocs_on_use,
})

koostsiocs:addEffect(fk.AskForCardResponse, {
  can_trigger = function(self, event, target, player, data)
    return  target ~= player and player:hasSkill(koostsiocs.name) 
    and Exppattern:Parse(data.pattern):matchExp("szjemh|0|nosuit|none") 
    -- and not player:prohibitResponse(Fk:cloneCard("szjemh"))
    and not target:prohibitResponse(Fk:cloneCard("szjemh"))
    and not player:prohibitResponse(Fk:cloneCard("szjemh"))
  end,
  -- on_cost = function(self, event, target, player, data)
  --   local response = player.room:askToResponse(player,{ ---@type AskToUseCardParams
  --       skill_name = koostsiocs.name,
  --       pattern = 'szjemh',  --待
  --       prompt = "#koostsiocs-ask:" .. target.id,
  --       cancelable = true,
  --       -- event_data = effect
  --     })
  --   if response then
  --     event:setCostData(self, {responses = response})
  --     return true
  --   end
  -- end,
  on_cost = koostsiocs_on_cost,
  on_use = koostsiocs_on_use,
})

--- AfterAskForCardUse CardRespondFinished CardResponding
koostsiocs:addEffect(fk.CardRespondFinished, koostsiocs_delay_spec)  --不是清理
koostsiocs:addEffect(fk.CardUseFinished, koostsiocs_delay_spec)
-- koostsiocs:addEffect(fk.CardUsing, koostsiocs_delay_spec)
-- koostsiocs:addEffect(fk.CardResponding, koostsiocs_delay_spec)
return koostsiocs
