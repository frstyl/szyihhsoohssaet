---@class szyih_guos
local szyih_guos = require 'packages/szyihhsoohssaet/_base'


--- ReviveData 復活的数据
---@class ReviveDataSpec
---@field public who ServerPlayer @ 
---@field public recoverHp int @ hp
---@field public drawN int @ 抽牌數
---@field public skill string @ 來源技能名
---@field public from ServerPlayer @源角色 可能nil
---@field public fixMaxHp bool @ 若體力上限爲0 改爲1
---@field public prevented bool @ 阻止


---@class szyih_guos.ReviveData: ReviveDataSpec, TriggerData
szyih_guos.ReviveData = TriggerData:subclass("ReviveData")

--- 復活 TriggerEvent
---@class szyih_guos.Revive: TriggerEvent
---@field public data szyih_guos.ReviveData
szyih_guos.Revive = TriggerEvent:subclass("ReviveEvent")

--- 復活事件始 用于delay效果
---@class szyih_guos.PreRevive: szyih_guos.Revive
szyih_guos.PreRevive = szyih_guos.Revive:subclass("szyih_guos.PreRevive")

--- 復活旹 防止
---@class szyih_guos.BeforeRevive: szyih_guos.Revive
-- szyih_guos.BeforeRevive = szyih_guos.Revive:subclass("szyih_guos.BeforeRevive")


--- 復活结束后
---@class szyih_guos.ReviveFinished: szyih_guos.Revive
szyih_guos.AfterRevive = szyih_guos.Revive:subclass("szyih_guos.ReviveFinished")

---@alias ReviveTrigFunc fun(self: TriggerSkill, event: szyih_guos.Revive,
---  target: ServerPlayer, player: ServerPlayer, data: szyih_guos.ReviveData):any

---@class SkillSkeleton
---@field public addEffect fun(self: SkillSkeleton, key: szyih_guos.Revive,
---  data: TrigSkelSpec<ReviveTrigFunc>, attr: TrigSkelAttribute?): SkillSkeleton

--- 復活 GameEvent
szyih_guos.ReviveEvent = "Revive"

Fk:addGameEvent(szyih_guos.ReviveEvent, nil, --prepare function
function (self)
  local reviveData = self.data ---@class ReviveDataSpec
  local room = self.room ---@type Room
  local logic = room.logic
  local who = reviveData.who

  if not who.dead then return end
  room:sendLog { type = "#ToRevived", from = who.id ,arg=reviveData.skill or "unknown"}
  logic:trigger(szyih_guos.PreRevive, who, reviveData)
  -- logic:trigger(szyih_guos.BeforeRevive, from, reviveData)
  if reviveData.prevented then 
    room:sendLog { type = "#ReviveFailed", from = who.id ,arg=reviveData.skill or "unknown"}
    return 
  end
    if reviveData.drawN then who:drawCards(reviveData.drawN) end
    room:setPlayerProperty(who, "dead", false)
    who._splayer:setDied(false)
    room:setPlayerProperty(who, "dying", false)
    local n  = reviveData.recoverHp or 1
    if who.maxHp<n then     room:setPlayerProperty(who, "maxHp", n) end
    room:setPlayerProperty(who, "hp", n)
    table.insertIfNeed(room.alive_players, who)
    room:updateAllLimitSkillUI(who)

  room:sendLog { type = "#Revived", from = who.id ,arg=reviveData.skill or "unknown"}
  logic:trigger(szyih_guos.AfterRevive, who, reviveData)  --CancellOut
  
end , 
function (self) --cleaner function

end,
 nil)--exit function




Fk:loadTranslationTable{

  ["#ToRevived"] = "%from 將因 %arg 復活詐屍",
  ["#ReviveFailed"] = "%from  復活失敗",
  ["#Revived"] = "%from 因 %arg 復活",

}


szyih_guos.revive = function(reviveData)
  if not reviveData.who then return end
  if type(reviveData.who)=="number" then reviveData.who=Fk:currentRoom():getPlayerBySeat(reviveData.who) end
  local event = GameEvent[szyih_guos.ReviveEvent]:create(reviveData)
  local _, ret = event:exec()
  return reviveData
end

