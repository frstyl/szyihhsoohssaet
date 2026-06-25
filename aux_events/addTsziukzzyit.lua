---@class szyih_guos
local szyih_guos = require 'packages/szyihhsoohssaet/_base'

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

-- 不用return

----咒術tsziukzzyit
-- 	conjuring = { -- 咒术系统预定义设置
-- 		-- 负面效果
-- 		poison_jur = "5/-4/75", -- 中毒
-- 		sleep_jur = "2/-1/75", -- 昏睡
-- 		dizzy_jur = "2/-2/75", -- 晕眩
-- 		chaos_jur = "2/-3//75", -- 混乱
-- 		mildew_jur = "2/-4//75", -- 霉运
-- 		blind_jur = "3/-3", -- 盲目
-- 		swear_jur = "3/-5", -- 诅咒
-- 		-- 正面效果
-- --		stealth_jur = "2/5", -- 隐形
-- 		lucky_jur = "2/3//75", -- 幸运
-- 		reflex_jur = "3/3//25", -- 反弹
-- 		purge_jur = "5/1/75", -- 净化
-- 		catamite_jur = "3/0/75", -- 娈化(魅影)
-- 		cure_jur = "5/2//25", -- 自愈
-- 		hit_jur = "2/4/50", -- 命中
-- 		violent_jur = "2/4//50", -- 狂暴
-- 		immune_jur = "5/5", -- 免疫

-- --	格式说明：咒术名 = 持续回合 / 价值 / 附加成功率 / 触发成功率
-- --	价值为正数表示正面效果，负数为负面效果
-- 	},
local tsziukzzyit_table={}  --持續值轉  --function ?  --不能用0

  tsziukzzyit_table["tthxinsdook"] = {5,-3,75,nil}
  tsziukzzyit_table["hsoonqdzzyes"] = {2,-3,75,nil}
  tsziukzzyit_table["qunshzveen"] = {2,-4,75,nil}
  tsziukzzyit_table["mxiqquns"] ={2,-2,100,75}  --100可改 nil不能改
  tsziukzzyit_table["hsoonslvoans"] = {3,-3,100,75}
  tsziukzzyit_table["maacqmiuk"] = {3,-2,100,nil}
  tsziukzzyit_table["tssiostsziuk"] = {3,-5,100,nil}
  tsziukzzyit_table["tsziakszjev"] = {3,-3,100,nil}

  tsziukzzyit_table["hzaechquns"] = {2,2,nil,75}
  tsziukzzyit_table["puanhdoan"] = {2,3,nil,25}
  tsziukzzyit_table["dzjisjuoh"] = {5,2,nil,25}
  tsziukzzyit_table["guacqboavs"] = {2,4,nil,50}
  tsziukzzyit_table["mxenhcioh"] = {5,5,nil,nil}
  tsziukzzyit_table["mracsttiucs"] = {2,4,50,nil}
  tsziukzzyit_table["szyihdoonh"] = {3,3,nil,nil }

  tsziukzzyit_table["dzjecshsfas"] = {5,1,75,nil}  --淨化无skill  負面彊于正面 故淨化算正面
  tsziukzzyit_table["mxishqrach"] = {3,0,75,nil}  --污染池子

  tsziukzzyit_table["hqinhzzeec"] = {2,5,nil,nil}  --隱藏 ??

local debuff={"tthxinsdook", "hsoonqdzzyes","mxiqquns","hsoonslvoans","maacqmiuk","tssiostsziuk","tsziakszjev",
 "qunshzveen",}
local buff ={"hzaechquns", "puanhdoan","dzjisjuoh", "guacqboavs", "mxenhcioh", "mracsttiucs","szyihdoonh",}
local normal={"tthxinsdook", "hsoonqdzzyes","mxiqquns","hsoonslvoans","maacqmiuk","tssiostsziuk","tsziakszjev",
"qunshzveen",
"hzaechquns", "puanhdoan","dzjisjuoh", "guacqboavs", "mxenhcioh", "mracsttiucs","szyihdoonh",
"dzjecshsfas","mxishqrach",
} 

Fk:loadTranslationTable{
  ["@tsziukzzyit_puanhdoan"] = "反彈",
  ["@tsziukzzyit_mxenhcioh"] = "免敔",
  ["@tsziukzzyit_guacqboavs"] = "狂虣",
  ["@tsziukzzyit_dzjisjuoh"] = "自愈",
  ["@tsziukzzyit_hzaechquns"] = "吉運",
  ["@tsziukzzyit_mracsttiucs"] = "命中",

  ["@tsziukzzyit_tssiostsziuk"] = "詛咒",
  ["@tsziukzzyit_maacqmiuk"] = "盲目",
  ["@tsziukzzyit_hsoonslvoans"] = "涽亂",
  ["@tsziukzzyit_mxiqquns"] = "楣運",
  ["@tsziukzzyit_hsoonqdzzyes"] = "昏睡",
  ["@tsziukzzyit_tthxinsdook"] = "疢毒",

  ["@tsziukzzyit_qunshzveen"] = "暈眩", --炮

  ["@tsziukzzyit_tsziakszjev"] = "灼燒",
  ["@tsziukzzyit_szyihdoonh"] = "水盾",
  
  ["@tsziukzzyit_dzjecshsfas"] = "淨化",
  ["@tsziukzzyit_mxishqrach"] = "魅影",
  
  ["@tsziukzzyit_hqinhzzeec"] = "𠃊形",
}

Fk:loadTranslationTable{
  ["tsziukzzyit_tsziakszjev"] = "灼燒",
  [":tsziukzzyit_tsziakszjev"] = "伱受到屬性傷害旹,傷害值+1｡附加概率100%,觸發概100%,持續3轉",

  ["tsziukzzyit_szyihdoonh"] = "水盾",
  [":tsziukzzyit_szyihdoonh"] = "伱受到屬性傷害旹,傷害值-1｡附加概率100%,觸發概100%,持續3轉",

  ["tsziukzzyit_puanhdoan"] = "反彈",
  [":tsziukzzyit_puanhdoan"] = "伱受傷旹,若有傷源角色且其存活,觸發,傷害轉移于傷源｡附加概率75%,觸發概率50%,持續3轉.",

  ["tsziukzzyit_mxenhcioh"] = "免敔",
  [":tsziukzzyit_mxenhcioh"] = "伱受傷旹流失體力旹觸發,防止之,迻除免敔,｡附加概率100%,觸發概率100%,持續3轉",

  ["tsziukzzyit_guacqboavs"] = "狂虣",
  [":tsziukzzyit_guacqboavs"] = "伱致傷旹觸發,傷害值+1｡附加概率100%,觸發概率50%,持續3轉",

  ["tsziukzzyit_dzjisjuoh"] = "自愈",
  [":tsziukzzyit_dzjisjuoh"] = "伱末段始旹觸發,伱回1｡附加概率100%,觸發概25%,持續3轉 ",

  ["tsziukzzyit_mracsttiucs"] = "命中",
  [":tsziukzzyit_mracsttiucs"] = "伱使用殺旹觸發,此殺不可被閃響應｡附加概率100%,觸發概100%,持續3轉",

  ["tsziukzzyit_hzaechquns"] = "𡴘運",
  [":tsziukzzyit_hzaechquns"] = "伱額定抽牌歬觸發,抽牌數+1｡附加概率75%,觸發概率50%,持續3轉.",

  ["tsziukzzyit_mxiqquns"] = "楣運",
  [":tsziukzzyit_mxiqquns"] = "伱額定抽牌歬觸發,抽牌數-1｡附加概率75%,觸發概率50%,持續3轉.",

  ["tsziukzzyit_tthxinsdook"] = "疢毒",
  [":tsziukzzyit_tthxinsdook"] = "預段始旹,伱隨機弃1牌, 无牌則流失1體力｡附加概率100%,觸發概100%,持續5轉",

  ["tsziukzzyit_maacqmiuk"] = "盲目",
  [":tsziukzzyit_maacqmiuk"] = "恆續,若伱至目幖距離大于1,伱不能選擇其爲牌目幖｡附加概率100%,觸發概100%,持續3轉",

  ["tsziukzzyit_hsoonqdzzyes"] = "昏睡",
  [":tsziukzzyit_hsoonqdzzyes"] = "➀恆續,伱轉外不可使用牌｡➁伱主段始歬觸發,越過｡附加概率100%,觸發概100%,持續3轉",

  ["tsziukzzyit_tssiostsziuk"] = "阻咒",
  [":tsziukzzyit_tssiostsziuk"] = "恆續,伱不是酒肉藥合理目幖｡附加概率100%,觸發概100%,持續3轉",

  ["tsziukzzyit_qunshzveen"] = "暈眩",
  [":tsziukzzyit_qunshzveen"] = "恆續,伱全部角色技能失效｡附加概率100%,觸發概100%,持續3轉",

  ["tsziukzzyit_dzjecshsfas"] = "淨化",
  [":tsziukzzyit_dzjecshsfas"] = "伱附加其它咒術歬觸發,附加概率-50%｡附加概率100%,觸發概100%,持續3轉",

  ["tsziukzzyit_mxishqrach"] = "魅影",
  [":tsziukzzyit_mxishqrach"] = "恆續,伱視爲女｡附加概率100%,觸發概100%,持續3轉",
}

--

szyih_guos.setTsziukzzyit = function(to,name)  --player id --咒名
  -- local player = type(playerid)=="number" and Fk:currentRoom():getPlayerById(playerid) or playerid
  -- if not name then 
  --   return nil
  -- end
  szyih_guos.removeTsziukzzyit(to)  --?id
  
  to.room:addSkill("tsziukzzyit_rule")
  to.room:addSkill("tsziukzzyit_"..name)
  -- if szyih_guos.AddTsziukzzyit(to,name,from, card) then
  to.room:setPlayerMark(to,"@tsziukzzyit_"..name, tsziukzzyit_table[name][1])
  -- end
  -- player.room.logic:trigger(fk.AddTsziukzzyit, player, name)
  return true
end

--- TsziukzzyitAddData 附加咒術的数据
---@class TsziukzzyitAddDataSpec
---@field public name string @ 咒術名  --class?
---@field public to ServerPlayer @ 目幖 單个
---@field public from ServerPlayer @源角色 可能nil
---@field public skill string @ 來源技能名
---@field public card card @ 來源牌 牌名同旹有技能名 可能nil
---@field public value int @ 咒術價值 正零負
---@field public probability {skill,value}[] @ 附加咒術槪率修正 ?第一組爲初概率? 0~100整數,作百分比之分子  ---若无(nil)則爲必附加 概率不可改
---@field public baseProbability int @ 附加咒術槪率 爲0 或100 不可改
---@field public turns int @ 咒術持續轉數
---@field public result bool @ 附加咒術结果 成否
---@field public nullified bool @ 附加咒術被阻止


---@class szyih_guos.TsziukzzyitAddData: TsziukzzyitAddDataSpec, TriggerData
szyih_guos.TsziukzzyitAddData = TriggerData:subclass("TsziukzzyitAddData")

--- 附加咒術 TriggerEvent
---@class szyih_guos.TsziukzzyitAdd: TriggerEvent
---@field public data szyih_guos.TsziukzzyitAddData
szyih_guos.TsziukzzyitAdd = TriggerEvent:subclass("TsziukzzyitAddEvent")

--- 附加咒術事件始 用于delay效果
---@class szyih_guos.PreTsziukzzyitAdd: szyih_guos.TsziukzzyitAdd
szyih_guos.PreTsziukzzyitAdd = szyih_guos.TsziukzzyitAdd:subclass("szyih_guos.PreTsziukzzyitAdd")
--- 附加咒術旹 防止
---@class szyih_guos.BeforeTsziukzzyitAdd: szyih_guos.TsziukzzyitAdd
szyih_guos.BeforeTsziukzzyitAdd = szyih_guos.TsziukzzyitAdd:subclass("szyih_guos.BeforeTsziukzzyitAdd")

-- --- 附加咒術歬 from ,与上區別止在from to, Damage Aim 應合併
-- ---@class szyih_guos.BeforeTsziukzzyitAddFrom: szyih_guos.TsziukzzyitAdd
-- szyih_guos.BeforeTsziukzzyitAddFrom = szyih_guos.TsziukzzyitAdd:subclass("szyih_guos.BeforeTsziukzzyitAddFrom")


--- 附加咒術旹 改變 如附加概率
---@class szyih_guos.TsziukzzyitAdding: szyih_guos.TsziukzzyitAdd
szyih_guos.TsziukzzyitAdding = szyih_guos.TsziukzzyitAdd:subclass("szyih_guos.TsziukzzyitAdding")

-- --- 附加咒術旹From 
-- ---@class szyih_guos.TsziukzzyitAddingFrom: szyih_guos.TsziukzzyitAdd
-- szyih_guos.TsziukzzyitAddingFrom = szyih_guos.TsziukzzyitAdd:subclass("szyih_guos.TsziukzzyitAddingFrom")

--- 附加咒術结束后
---@class szyih_guos.TsziukzzyitAddFinished: szyih_guos.TsziukzzyitAdd
szyih_guos.TsziukzzyitAddFinished = szyih_guos.TsziukzzyitAdd:subclass("szyih_guos.TsziukzzyitAddFinished")

---@alias TsziukzzyitAddTrigFunc fun(self: TriggerSkill, event: szyih_guos.TsziukzzyitAdd,
---  target: ServerPlayer, player: ServerPlayer, data: szyih_guos.TsziukzzyitAddData):any

---@class SkillSkeleton
---@field public addEffect fun(self: SkillSkeleton, key: szyih_guos.TsziukzzyitAdd,
---  data: TrigSkelSpec<TsziukzzyitAddTrigFunc>, attr: TrigSkelAttribute?): SkillSkeleton

--- 附加咒術 GameEvent
szyih_guos.TsziukzzyitAddEvent = "TsziukzzyitAdd"

Fk:addGameEvent(szyih_guos.TsziukzzyitAddEvent, nil, --prepare function
function (self)
  local TsziukzzyitAddData = self.data ---@class TsziukzzyitAddDataSpec
  local room = self.room ---@type Room
  local logic = room.logic
  local from = TsziukzzyitAddData.from
  local to = TsziukzzyitAddData.to
  local card = TsziukzzyitAddData.card
  local argname="@tsziukzzyit_"..TsziukzzyitAddData.name
  logic:trigger(szyih_guos.PreTsziukzzyitAdd, to, TsziukzzyitAddData)  --必有to
  -- from:drawCards(3,"s")

  room:sendLog{
    type = TsziukzzyitAddData.from and "#StartTsziukzzyitAddFrom" or "#StartTsziukzzyitAdd",
    from = TsziukzzyitAddData.from  and from.id or nil,
    to={to.id},
    arg = argname,
  }


  logic:trigger(szyih_guos.BeforeTsziukzzyitAdd, to, TsziukzzyitAddData)


  if TsziukzzyitAddData.nullified then 
    -- goto finish 
  end

  logic:trigger(szyih_guos.TsziukzzyitAdding, to, TsziukzzyitAddData)
  local probability=TsziukzzyitAddData.baseProbability
  local yes=false
  if probability==nil then yes=true
  else
    for name, v in ipairs(TsziukzzyitAddData.probability) do
      probability=probability+v
    end
    yes=math.random(1,100)<= probability
  end
  if  yes then
    szyih_guos.setTsziukzzyit(to,TsziukzzyitAddData.name)
    room:sendLog{
      type =  "#TsziukzzyitAdded",
      -- from = TsziukzzyitAddData.from  and from.id or nil,
      to={to.id},
      arg = argname,
    }
  else
    room:sendLog{
      type =  "#TsziukzzyitFailed",
      -- from = TsziukzzyitAddData.from  and from.id or nil,
      to={to.id},
      arg = argname,
    }
  end
  -- ::finish::

end , 
function (self) --cleaner function
    self.room.logic:trigger(szyih_guos.TsziukzzyitAddFinished, self.to, self.data)  --self?
end,
 nil)--exit function




Fk:loadTranslationTable{
  ["#StartTsziukzzyitAddFrom"] = "%to 將被 %from 附加咒術 %arg",
  ["#StartTsziukzzyitAdd"] = "%to 將被附加咒術 %arg",
  ["#TsziukzzyitAdded"] = "%to 被附加咒術 %arg",
  ["#TsziukzzyitFailed"] = "%to 被附加咒術 %arg 失敗",

  -- ["#askForTsziukzzyitAdd"] = "请展示一张手牌进行附加咒術",
  -- ["AskForTsziukzzyitAdd"] = "附加咒術",
  -- ["#SendTsziukzzyitAddOpinion"] = "%from 的意见为 %arg",
  -- ["noresult"] = "无结果",
  -- ["#ShowTsziukzzyitAddResult"] = "%from 的附加咒術结果为 %arg",
}

--- 进行附加咒術
---@param to ServerPlayer @ 
---@param name string? @ 附加咒術技能名
---@param from ServerPlayer? @ 
---@param card card @ 
---@return szyih_guos.TsziukzzyitAddData
szyih_guos.AddTsziukzzyit = function(to, name, from, card)
  if tsziukzzyit_table[name]==nil then return end
  local TsziukzzyitAddData = szyih_guos.TsziukzzyitAddData:new{
    to = to,
    name=name,
    from=from or nil,
    card=card or nil,
    probability={},
    baseProbability=tsziukzzyit_table[name][3],
    value=tsziukzzyit_table[name][2],
    turns=tsziukzzyit_table[name][1],
  }
  local event = GameEvent[szyih_guos.TsziukzzyitAddEvent]:create(TsziukzzyitAddData)
  local _, ret = event:exec()
  return TsziukzzyitAddData
end


--外部用

szyih_guos.hasTsziukzzyit = function(playerid,name)  --player id --咒名 若无則全
  local player = type(playerid)=="number" and Fk:currentRoom():getPlayerById(playerid) or playerid
  local n
  if not name then 
    n="@tsziukzzyit_"
  elseif name=="buff" or name=="debuff" then  --pernicious
    local names= name=="debuff" and debuff or buff


    names = table.map(names,function(n)
      return "@tsziukzzyit_"..n
    end)

    for m, _ in pairs(player.mark) do  --鍵name值number ??
        if table.contains(names, m) then  --m str
          -- return {player.mark[m], m} --
          return m --全名
        end
    end
    return false
  else
    n="@tsziukzzyit_"..name
  end
  for m, _ in pairs(player.mark) do  --鍵name值number ??
      if m:startsWith(n) then  --m str
        -- return {player.mark[m], m} --
        return m --全名
      end
  end
  return nil
end

szyih_guos.removeTsziukzzyit = function(playerid,name)  --player id --咒名 若无則全
  local player = type(playerid)=="number" and Fk:currentRoom():getPlayerById(playerid) or playerid
  local n
  if not name then 
    n="@tsziukzzyit_"
  else
    n="@tsziukzzyit_"..name
  end
  for m, _ in pairs(player.mark) do  --鍵name值number ??
      if m:startsWith(n) then
        player.room:setPlayerMark(player,m,0)
        -- player.room.logic:trigger(fk.RemoveTsziukzzyit, player, name)
        return m
      end
  end
  return nil
end



-- szyih_guos.addTsziukzzyit= function(to,name,from,card)
--   local player = type(to)=="number" and Fk:currentRoom():getPlayerById(to) or to
--   -- local sourse = from
--   szyih_guos.AddTsziukzzyit(to,table.random(normal,1)[1],from,card)
-- end

szyih_guos.addTsziukzzyitBuff= function(to,name, from, card) 
  -- local player = type(to)=="number" and Fk:currentRoom():getPlayerById(to) or to
  if  name==nil then
    szyih_guos.AddTsziukzzyit(to,table.random(normal,1)[1],from,card)
  elseif  type(name)=="table" and name[1]then
    szyih_guos.AddTsziukzzyit(to,table.random(name,1)[1],from,card)
  elseif  name=="debuff" then
    szyih_guos.AddTsziukzzyit(to, table.random(debuff,1)[1],from, card)
  elseif  name=="buff" then
    szyih_guos.AddTsziukzzyit(to, table.random(buff,1)[1],from, card )
  elseif type(name)=="string" then
    szyih_guos.AddTsziukzzyit(to, name,from, card )
  end
end

----
----

--- TsziukzzyitTriggerData 咒術觸發 修正記錄
---@class TsziukzzyitTriggerDataSpec
---@field public name string @ 咒術名  --class?
---@field public who ServerPlayer @ 
---@field public value int @ 咒術價值 正零負
---@field public probability {skill,value}[] @ 咒術觸發槪率修正 ?第一組爲初概率? 0~100整數,作百分比之分子  ---若无(nil)則爲必附加 概率不可改
---@field public baseProbability int @ 咒術觸發槪率 爲0 或100 不可改
---@field public result bool @ 咒術觸發结果 成否
---@field public nullified bool @ 咒術觸發被阻止


---@class szyih_guos.TsziukzzyitTriggerData: TsziukzzyitTriggerDataSpec, TriggerData
szyih_guos.TsziukzzyitTriggerData = TriggerData:subclass("TsziukzzyitTriggerData")

--- 咒術觸發 TriggerEvent
---@class szyih_guos.TsziukzzyitTrigger: TriggerEvent
---@field public data szyih_guos.TsziukzzyitTriggerData
szyih_guos.TsziukzzyitTrigger = TriggerEvent:subclass("TsziukzzyitTriggerEvent")

--- 咒術觸發事件始 用于delay效果
---@class szyih_guos.PreTsziukzzyitTrigger: szyih_guos.TsziukzzyitTrigger
szyih_guos.PreTsziukzzyitTrigger = szyih_guos.TsziukzzyitTrigger:subclass("szyih_guos.PreTsziukzzyitTrigger")
--- 咒術觸發旹 防止
---@class szyih_guos.BeforeTsziukzzyitTrigger: szyih_guos.TsziukzzyitTrigger
szyih_guos.BeforeTsziukzzyitTrigger = szyih_guos.TsziukzzyitTrigger:subclass("szyih_guos.BeforeTsziukzzyitTrigger")


--- 咒術觸發旹 改變 如附加概率
---@class szyih_guos.TsziukzzyitTriggering: szyih_guos.TsziukzzyitTrigger
szyih_guos.TsziukzzyitTriggering = szyih_guos.TsziukzzyitTrigger:subclass("szyih_guos.TsziukzzyitTriggering")


--- 咒術觸發事件结束后
---@class szyih_guos.TsziukzzyitTriggerFinished: szyih_guos.TsziukzzyitTrigger
szyih_guos.TsziukzzyitTriggerFinished = szyih_guos.TsziukzzyitTrigger:subclass("szyih_guos.TsziukzzyitTriggerFinished")

---@alias TsziukzzyitTriggerTrigFunc fun(self: TriggerSkill, event: szyih_guos.TsziukzzyitTrigger,
---  target: ServerPlayer, player: ServerPlayer, data: szyih_guos.TsziukzzyitTriggerData):any

---@class SkillSkeleton
---@field public addEffect fun(self: SkillSkeleton, key: szyih_guos.TsziukzzyitTrigger,
---  data: TrigSkelSpec<TsziukzzyitTriggerTrigFunc>, attr: TrigSkelAttribute?): SkillSkeleton

--- 咒術觸發 GameEvent
szyih_guos.TsziukzzyitTriggerEvent = "TsziukzzyitTrigger"

szyih_guos.tsziukzzyitTrigger= function(who, tsziukzzyitName) 
  if not szyih_guos.hasTsziukzzyit(who,tsziukzzyitName) then return end

  local baseProbability =tsziukzzyit_table[tsziukzzyitName][4]
  if baseProbability==nil then return true end

  local room = Fk:currentRoom()
  local logic = room.logic
  local dat={
    who=who,
    name=tsziukzzyitName,
    baseProbability = baseProbability,  --nil爲必肰
    probability={},
    result=nil,
  }
  logic:trigger(szyih_guos.PreTsziukzzyitTrigger, who, dat)
  logic:trigger(szyih_guos.BeforeTsziukzzyitTrigger, who, dat)
  
  local p=dat.baseProbability
  local yes=false
  if dat.probability==nil then 
    yes=true
  else
    for k, v in ipairs(dat.probability) do
      p=p+v
    end
    yes=math.random(1,100)<= p
  end


  if yes then 
    dat.result=true 
    logic:trigger(szyih_guos.TsziukzzyitTriggerFinished, who, dat)  --成?敗
  end

  return yes

end
