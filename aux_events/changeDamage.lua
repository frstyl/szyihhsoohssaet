---@class szyih_guos
local szyih_guos = require 'packages/szyihhsoohssaet/_base'


--- changeDamageData 改變傷害的数据 --preventDamage
--- reviveData 復活的数据
---@class changeDamageData
---@field public damageData DamageDataSpec @ 
---@field public num int @ 
---@field public skillName str @ 
---@field public prevented bool @ 


---@class szyih_guos.changeDamageData: changeDamageDataSpec, TriggerData
szyih_guos.changeDamageData = TriggerData:subclass("changeDamageData")

--- 改變傷害 TriggerEvent
---@class szyih_guos.changeDamage: TriggerEvent
---@field public data szyih_guos.changeDamageData
szyih_guos.changeDamage = TriggerEvent:subclass("changeDamageEvent")

--- 改變傷害事件始 用于delay效果
---@class szyih_guos.PrechangeDamage: szyih_guos.changeDamage
szyih_guos.PrechangeDamage = szyih_guos.changeDamage:subclass("szyih_guos.PrechangeDamage")

-- --- 改變傷害旹 防止
-- ---@class szyih_guos.BeforechangeDamage: szyih_guos.changeDamage
-- szyih_guos.BeforechangeDamage = szyih_guos.changeDamage:subclass("szyih_guos.BeforechangeDamage")


--- 改變傷害结束后
---@class szyih_guos.AfterChangeDamage: szyih_guos.changeDamage
szyih_guos.AfterChangeDamage = szyih_guos.changeDamage:subclass("szyih_guos.AfterChangeDamage")

---@alias changeDamageTrigFunc fun(self: TriggerSkill, event: szyih_guos.changeDamage,
---  target: ServerPlayer, player: ServerPlayer, data: szyih_guos.changeDamageData):any

---@class SkillSkeleton
---@field public addEffect fun(self: SkillSkeleton, key: szyih_guos.changeDamage,
---  data: TrigSkelSpec<changeDamageTrigFunc>, attr: TrigSkelAttribute?): SkillSkeleton

--
--- 
szyih_guos.preventDamage = TriggerEvent:subclass("preventDamageEvent")

---@class szyih_guos.PrePreventDamage: szyih_guos.preventDamage
szyih_guos.PrePreventDamage = szyih_guos.preventDamage:subclass("szyih_guos.PrePreventDamage")

--
---@class szyih_guos.AfterPreventDamage: szyih_guos.preventDamage
szyih_guos.AfterPreventDamage = szyih_guos.preventDamage:subclass("szyih_guos.AfterPreventDamage")


Fk:loadTranslationTable{
  ["#changeDamageBySkill"] = "由于 %arg 的效果，對 %from 傷害  %arg2",
  ["#PreventDamageBySkill"] = "由于 %arg 效果，%from 所受傷害被防止",
}



szyih_guos.changeDamage = function(ChangeDamageData)
  if  ChangeDamageData ==nil then return end
  local dat =ChangeDamageData ---@class datSpec
  -- local room = self.room ---@type Room
  local room=Fk:currentRoom()
  local logic = room.logic
  local to = dat.damageData.to
  logic:trigger(szyih_guos.PrechangeDamage, to, dat)
  if not dat.prevented then  --增加globle , 增傷加上限
    dat.extra_data=dat.extra_data or {}
    dat.extra_data.changeRecord =dat.extra_data.changeRecord or {}
    table.isnert(dat.extra_data.changeRecord,{dat.skillName,dat.num})
    room:sendLog { type = "#changeDamageBySkill", from = to.id , arg=dat.skillName or "unknown", arg2 = dat.num}

    -- dat.damageData:changeDamage(dat.num)
    dat.damageData.damage = dat.damageData.damage + dat.num
  end 
  logic:trigger(szyih_guos.AfterChangeDamage, to, dat)  --CancellOut

  if dat.damageData.damage <=0 then --breakCheck前
    dat.damageData.damage ==0
    stages = {
      {fk.Damage, "from"},
      {fk.Damaged, "to"},
    }

    for _, struct in ipairs(stages) do
      local event, player = table.unpack(struct)
      logic:trigger(event, dat.damageData[player], dat.damageData)
    end
  end
end

szyih_guos.preventDamage = function(preventDamageData)
  if  preventDamageData ==nil or preventDamageData.damageData.prevented == true  then return end
  local dat =preventDamageData ---@class datSpec
  -- local room = self.room ---@type Room
  local room=Fk:currentRoom()
  local logic = room.logic
  local to = dat.damageData.to
  logic:trigger(szyih_guos.PrePreventDamage, to, dat)
  if not dat.prevented then
    -- local number =dat.num>0 and  "+"..tostring(dat.num) or "-"..tostring(dat.num)
    room:sendLog { type = "#PreventDamageBySkill", from = to.id , arg=dat.skillName or "unknown"}

    dat.damageData.prevented = true  --待改 增傷統一加上限
  end 
  logic:trigger(szyih_guos.AfterPreventDamage, to, dat)  --CancellOut
end
