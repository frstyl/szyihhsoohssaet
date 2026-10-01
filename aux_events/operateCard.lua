---@class szyih_guos
local szyih_guos = require 'packages/szyihhsoohssaet/_base'


--- OperateCardData 操作牌的数据

-- fk.ReasonJustMove = 1
-- fk.ReasonDraw = 2
-- fk.ReasonDiscard = 3
-- fk.ReasonGive = 4
-- fk.ReasonPut = 5
-- fk.ReasonPutIntoDiscardPile = 6
-- fk.ReasonPrey = 7
-- fk.ReasonExchange = 8
-- fk.ReasonUse = 9
-- fk.ReasonResponse = 10
-- fk.ReasonJudge = 11
-- fk.ReasonRecast = 12
-- fk.ReasonPindian = 13
---@class OperateCardDataSpec @ 
---@field public who? player @執行者
---@field public type? moveReason @ 移動類型 操作元因
---@field public prevented? bool @ 是否防止
---@field public move? MoveCardsData @



---@class szyih_guos.OperateCardData: OperateCardDataSpec, TriggerData
szyih_guos.OperateCardData = TriggerData:subclass("OperateCardData")

--- 操作牌 TriggerEvent
---@class szyih_guos.OperateCard: TriggerEvent
---@field public data szyih_guos.OperateCardData
szyih_guos.OperateCard = TriggerEvent:subclass("OperateCardEvent")

--- 操作牌事件前 
-- ---@class szyih_guos.PreOperateCard: szyih_guos.OperateCard
-- szyih_guos.PreOperateCard = szyih_guos.OperateCard:subclass("szyih_guos.PreOperateCard")

--- 操作牌前 
---@class szyih_guos.BeforeOperateCard: szyih_guos.OperateCard
szyih_guos.BeforeOperateCard = szyih_guos.OperateCard:subclass("szyih_guos.BeforeOperateCard")


--- 操作牌结束后
---@class szyih_guos.OperateCardFinished: szyih_guos.OperateCard
szyih_guos.AfterOperateCard = szyih_guos.OperateCard:subclass("szyih_guos.AfterOperateCard")





