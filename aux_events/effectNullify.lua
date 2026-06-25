---@class szyih_guos
local szyih_guos = require 'packages/szyihhsoohssaet/_base'


--- effectNullifyData 使用无效的数据 

---@class szyih_guos.effectNullifyData: effectNullifyDataSpec, TriggerData
szyih_guos.effectNullifyData = TriggerData:subclass("effectNullifyData")

--- 使用无效 TriggerEvent
---@class szyih_guos.effectNullify: TriggerEvent
---@field public data szyih_guos.effectNullifyData
szyih_guos.effectNullify = TriggerEvent:subclass("effectNullifyEvent")

--- 使用无效事件始 用于delay效果
---@class szyih_guos.PreffectNullify: szyih_guos.effectNullify
szyih_guos.PreffectNullify = szyih_guos.effectNullify:subclass("szyih_guos.PreffectNullify")

--- 使用无效旹 防止
---@class szyih_guos.BeforeeffectNullify: szyih_guos.effectNullify
szyih_guos.BeforeeffectNullify = szyih_guos.effectNullify:subclass("szyih_guos.BeforeeffectNullify")


--- 使用无效结束后
---@class szyih_guos.effectNullifyFinished: szyih_guos.effectNullify
szyih_guos.AftereffectNullify = szyih_guos.effectNullify:subclass("szyih_guos.AftereffectNullify")

---@alias effectNullifyTrigFunc fun(self: TriggerSkill, event: szyih_guos.effectNullify,
---  target: ServerPlayer, player: ServerPlayer, data: szyih_guos.effectNullifyData):any

---@class SkillSkeleton
---@field public addEffect fun(self: SkillSkeleton, key: szyih_guos.effectNullify,
---  data: TrigSkelSpec<effectNullifyTrigFunc>, attr: TrigSkelAttribute?): SkillSkeleton

--- 使用无效 GameEvent
-- szyih_guos.effectNullifyEvent = "effectNullify"

-- Fk:addGameEvent(szyih_guos.effectNullifyEvent, nil, --prepare function
-- function (self)
--   local cardEffectData = self.data ---@class cardEffectDataSpec
--   local room = self.room ---@type Room
--   local logic = room.logic
--   local from = cardEffectData.from

--   logic:trigger(szyih_guos.PreffectNullify, from, cardEffectData)
--   logic:trigger(szyih_guos.BeforeeffectNullify, from, cardEffectData)
--   if not cardEffectData.extra_data or not cardEffectData.extra_data.antiNullify then
--     if cardEffectData.to then 
--       room:sendLog { type = "#EffectNullifyedTo", from = from.id ,to={cardEffectData.to.id}, arg=cardEffectData.card:toLogString()}
--     else
--       room:sendLog { type = "#EffectNullifyed", from = from.id , arg=cardEffectData.card:toLogString()}
--     end
--     cardEffectData.nullified = true
--     logic:trigger(szyih_guos.AftereffectNullify, from, cardEffectData)  --CancellOut
--   else
--     room:sendLog { type = "#AntiEffectNullifyed", from = from.id ,arg=cardEffectData.card:toLogString()}
--   end
-- end , 
-- function (self) --cleaner function

-- end,
--  nil)--exit function




Fk:loadTranslationTable{
  ["#EffectNullifyedTo"] = " %from 所用 %arg 對 %to 无效 ",
  ["#EffectNullifyed"] = " %from 所用 %arg无效 ",
  ["#AntiEffectNullifyed"] = " %from 所用 %arg 反无效 ",
}


-- szyih_guos.effectNullify = function(CardEffectData,player,skillName)
--   local event = GameEvent[szyih_guos.effectNullifyEvent]:create(CardEffectData)
--   local _, ret = event:exec()
--   return CardEffectData
-- end

szyih_guos.effectNullify = function(CardEffectData,player,skillName)
  if CardEffectData==nil then return end
  local cardEffectData =CardEffectData ---@class cardEffectDataSpec
  if  cardEffectData.nullified then return end
  -- local room = self.room ---@type Room
  local room=Fk:currentRoom()
  local logic = room.logic
  local from = cardEffectData.from or "unknown"

  logic:trigger(szyih_guos.PreffectNullify, from, cardEffectData)  --无抵消前
  logic:trigger(szyih_guos.BeforeeffectNullify, from, cardEffectData)
  cardEffectData.nullified = true
  if cardEffectData.to then 
    room:sendLog { type = "#EffectNullifyedTo", from = from.id ,to={cardEffectData.to.id}, arg=cardEffectData.card:toLogString()}
  else
    room:sendLog { type = "#EffectNullifyed", from = from.id , arg=cardEffectData.card:toLogString()}
  end

  logic:trigger(szyih_guos.AftereffectNullify, from, cardEffectData)  --CancellOut?
  if  cardEffectData.extra_data and cardEffectData.extra_data.antiNullify then
      cardEffectData.nullified = false
  end
  
  if cardEffectData.nullified == true then

  else
    room:sendLog { type = "#AntiEffectNullifyed", from = from.id ,arg=cardEffectData.card:toLogString()}
  end
end
