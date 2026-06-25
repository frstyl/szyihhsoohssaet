---@class szyih_guos
local szyih_guos = require 'packages/szyihhsoohssaet/_base'


--- UseNullifyData 使用无效的数据

---@class szyih_guos.UseNullifyData: UseNullifyDataSpec, TriggerData
szyih_guos.UseNullifyData = TriggerData:subclass("UseNullifyData")

--- 使用无效 TriggerEvent
---@class szyih_guos.UseNullify: TriggerEvent
---@field public data szyih_guos.UseNullifyData
szyih_guos.UseNullify = TriggerEvent:subclass("UseNullifyEvent")

--- 使用无效事件始 用于delay效果
---@class szyih_guos.PreUseNullify: szyih_guos.UseNullify
szyih_guos.PreUseNullify = szyih_guos.UseNullify:subclass("szyih_guos.PreUseNullify")

--- 使用无效旹 防止
---@class szyih_guos.BeforeUseNullify: szyih_guos.UseNullify
szyih_guos.BeforeUseNullify = szyih_guos.UseNullify:subclass("szyih_guos.BeforeUseNullify")


--- 使用无效结束后
---@class szyih_guos.UseNullifyFinished: szyih_guos.UseNullify
szyih_guos.AfterUseNullify = szyih_guos.UseNullify:subclass("szyih_guos.AfterUseNullify")

---@alias UseNullifyTrigFunc fun(self: TriggerSkill, event: szyih_guos.UseNullify,
---  target: ServerPlayer, player: ServerPlayer, data: szyih_guos.UseNullifyData):any

---@class SkillSkeleton
---@field public addEffect fun(self: SkillSkeleton, key: szyih_guos.UseNullify,
---  data: TrigSkelSpec<UseNullifyTrigFunc>, attr: TrigSkelAttribute?): SkillSkeleton

--- 使用无效 GameEvent
-- szyih_guos.UseNullifyEvent = "UseNullify"

-- Fk:addGameEvent(szyih_guos.UseNullifyEvent, nil, --prepare function
-- function (self)
--   local useCardData = self.data ---@class useCardDataSpec
--   local room = self.room ---@type Room
--   local logic = room.logic
--   local from = useCardData.from

--   logic:trigger(szyih_guos.PreUseNullify, from, useCardData)
--   logic:trigger(szyih_guos.BeforeUseNullify, from, useCardData)
--   if not useCardData.extra_data or not useCardData.extra_data.antiNullify then
--     useCardData.nullified=true
--     logic:trigger(szyih_guos.AfterUseNullify, from, useCardData)
--     if useCardData.nullified==true  then
--       room:sendLog{
--         type = "#UseNullify",
--         from = from.id,
--         -- to=useCardData.tos,
--         arg = useCardData.card:toLogString(),
--       }
--       useCardData:removeAllTargets()

--     end
--   end
-- end , 
-- function (self) --cleaner function

-- end,
--  nil)--exit function




Fk:loadTranslationTable{
  ["#UseNullify"] = "%from 所使用 %arg 无效",
  ["#AntiUseNullifyed"] = "%from 所使用 %arg 反无效",
}


-- szyih_guos.useNullify = function(UseCardData,player,skillName)
--   local event = GameEvent[szyih_guos.UseNullifyEvent]:create(UseCardData)
--   local _, ret = event:exec()
--   return UseCardData
-- end


szyih_guos.useNullify = function(UseCardData,player,skillName)
  local useCardData = UseCardData ---@class useCardDataSpec
  if  useCardData.nullified or ( useCardData.extra_data  and useCardData.extra_data.nullified) then return end
  local room = Fk:currentRoom()
  local logic = room.logic
  local from = useCardData.from

  logic:trigger(szyih_guos.PreUseNullify, from, useCardData)
  logic:trigger(szyih_guos.BeforeUseNullify, from, useCardData)
  useCardData.nullified=true
  useCardData.extra_data=useCardData.extra_data or {}
  useCardData.extra_data.nullified=true
      room:sendLog{
      type = "#UseNullify",
      from = from.id,
      -- to=useCardData.tos,
      arg = useCardData.card:toLogString(),
    }

  logic:trigger(szyih_guos.AfterUseNullify, from, useCardData)
  if  useCardData.extra_data and useCardData.extra_data.antiNullify then
    useCardData.nullified=false
    useCardData.extra_data.nullified=false
  end

  if useCardData.nullified or ( useCardData.extra_data  and useCardData.extra_data.nullified)  then

    useCardData:removeAllTargets()--實際
  else
    room:sendLog { type = "#AntiUseNullifyed", from = from.id ,arg = useCardData.card:toLogString(),}
  end
end

szyih_guos.nullifyTo = function(UseCardData,players,skillName)

    UseCardData.extra_data=UseCardData.extra_data or {}
    UseCardData.extra_data.ssaethsooh= UseCardData.extra_data.ssaethsooh or {}
    table.insertTable(UseCardData.extra_data.ssaethsooh, players[1] and players or {players})

end