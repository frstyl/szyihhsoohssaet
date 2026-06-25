local cardSkill = fk.CreateSkill {
  name = "tsiac_keejs_dzius_keejs_skill",
}

Fk:loadTranslationTable{
  ["tsiac_keejs_dzius_keejs_skill"] = "將計就計",
  ["#tsiac_keejs_dzius_keejs-use_to"] = "%desc 對%src 使用%arg，是否使用【將計就計】抵消 獲得%arg？",
  ["#tsiac_keejs_dzius_keejs-use"] = "%desc  使用%arg，是否使用【將計就計】抵消 獲得%arg？",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  can_use = Util.FalseFunc,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    if effect.responseToEvent then
        effect.responseToEvent.isCancellOut = true

      effect.responseToEvent.extra_data=effect.responseToEvent.extra_data or {}
      effect.responseToEvent.extra_data.tsiac_keejs_dzius_keejs =effect.from.id --一次使用事件止有一將計就計
    end
  end,
})

cardSkill:addEffect(fk.CardEffectCancelledOut, {--CardUseFinished
  global = true,
  mute = true,
  is_delay_effect = true,
  can_trigger = function (self, event, target, player, data)
    if 
    data.extra_data 
    and data.extra_data.tsiac_keejs_dzius_keejs 
    and data.extra_data.tsiac_keejs_dzius_keejs==player.id
    and not player.dead   
    and player.room:getCardArea(data.card) == Card.Processing
    then
      -- player:drawCards(10,cardSkill.name)
      return true
    end
  end,
  on_trigger= function (self, event, target, player, data)
    -- player:drawCards(10,cardSkill.name)
     player.room:moveCardTo(data.card, Card.PlayerHand, player, fk.ReasonJustMove, cardSkill.name, nil, true, player)
  end,
})

-- local spec = {
--   global = true,
--   priority = 0,  --旣爲0 return true
--   can_trigger =  function(self, event, target, player, data) --trigger逐个詢問 改爲ask--抵消爲何寫于流程 不可能不生成旹機--中斷旹機 技能用不了--瀕死正用旹機 --p return true data.asked   priority = 0,
--     if player.seat==1
--       --  S.getCardTypeByName(data.card) == 2
--       and data.card.type==Card.TypeTrick
--       and (not data.tos or #data.tos<=1)
--       and not data.isCancellOut
--       and not data.nullified
--       -- and (not data.prohibitedCardNames or not table.contains(data.prohibitedCardNames,"tsiac_keejs_dzius_keejs") )
--       -- and  (not data.use.prohibitedCardNamesList or not data.use.prohibitedCardNamesList[player] or not table.contains(data.use.prohibitedCardNamesList[player],"tsiac_keejs_dzius_keejs")) 
--       then
--           local players= S.getHolders("tsiac_keejs_dzius_keejs") 
--           if #players==0 then return end
--           players=table.filter(players,function(p)
--             return not data:isUnoffsetable(p)  and not data:isDisresponsive(p) 
--           end)
--             event:setCostData(self,{players=players})
--             return true
          
--       end
--   end,
--   on_trigger = function (self, event, target, player, data)
--     local room=player.room
--     local players=event:getCostData(self).players
--     -- local loopTimes = data:getResponseTimes()
--     Fk.currentResponsePattern = "tsiac_keejs_dzius_keejs"

--     -- for i = 1, loopTimes do
--     local to = data.to
--     local prompt = ""
--     if data.to then
--       prompt = "#tsiac_keejs_dzius_keejs-use_to::" .. data.from.id.."::"..data.to.id .. ":" .. data.card.name
--     elseif data.from then
--       prompt = "#tsiac_keejs_dzius_keejs-use::" .. data.from.id .. "::" .. data.card.name
--     end
--       local params = { ---@type AskToUseCardParams
--         pattern = "tsiac_keejs_dzius_keejs",
--         skill_name = "tsiac_keejs_dzius_keejs",
--         prompt = "tsiac",
--         cancelable = true,
--         extra_data = extra_data,
--         event_data = data
--       }

--     local extra_data
--     if #data.tos > 1 then
--       if data.use then  --一般會有
--         extra_data = { useEventId = data.use.id, effectTo = data.to.id }
--       end
--     end

--     if #players > 0 and data.card.trueName == "tsiac_keejs_dzius_keejs" then
--       room:animDelay(2)
--     end
--       local use = room:askToNullification(players, params)
--       if use then
--         use.toCard = data.card
--         use.responseToEvent = data
--         room:useCard(use)
--       end

--       -- if not data.isCancellOut then
--       --   break
--       -- end

--       -- data.isCancellOut = i == loopTimes
--     -- end
--   end,
-- }

--闪前
-- cardSkill:addEffect(fk.PreCardEffect, spec)

--无懈后
-- cardSkill:addEffect(fk.BeforeCardEffect, spec)


return cardSkill

