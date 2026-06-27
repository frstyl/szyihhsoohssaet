local bracqttiacs = fk.CreateSkill {
  name = "bracqttiacs",
}

Fk:loadTranslationTable{
  ["bracqttiacs"] = "平賬",
  [":bracqttiacs"] = "記錄A于其主段所用牌之點數,无點數不記錄.轉限1.當段終旹,若x>0,伱可作平賬游戲,若成功伱發動此技能,伱令A抽x執行1額外主段.平賬游戲:將所記錄點數爲2組,2組點數爲成.x爲A所用牌數",

  ["#bracqttiacs-invoke"] = "平賬： %dest 主段終 是否發動 令𠂇又數值之和相等",

  ["#bracqttiacs-left"] = "𠂇",
  ["#bracqttiacs-right"] = "又",
  ["#bracqttiacs-tip"] = "平賬 令𠂇又數值之和相等",

  ["@bracqttiacs-number"] = "",
  ["@bracqttiacs_rount-phase"] = "平賬",  --用牌數
  -- ["bracqttiacs_record-phase"] = "平賬",  --點數記錄

  ["$bracqttiacs1"] = "今日宴请诸位，有要事相商。",
  ["$bracqttiacs2"] = "天下未定，请主公以大局为重。",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

bracqttiacs:addEffect(fk.EventPhaseEnd, {
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(bracqttiacs.name) 
    -- target.phase == Player.Play 
    -- and  player:usedSkillTimes(bracqttiacs.name, Player.HistoryTurn) == 0 
    and target:getMark("@bracqttiacs_rount-phase")>0
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    if not room:askToSkillInvoke(player, {
      skill_name = bracqttiacs.name,
      prompt = "#bracqttiacs-invoke::"..target.id,
    })  then return end
    local t=target:getTableMark("bracqttiacs_record-phase")
    local n =#t
    if n ==0 then return true end
    local ids= S.getKhouc(room,n)
    for i=1, n, 1  do
      room:setCardMark(Fk:getCardById(ids[i]),"@bracqttiacs-number", t[i])
    end
    local result = room:askToGuanxing(player,{
      cards=ids,
      -- top_limit=,
      -- top_limit=,
      skill_name=bracqttiacs.name,
      title="#bracqttiacs-tip",
      skip=true,
      area_names={"#bracqttiacs-left","#bracqttiacs-right"},
    })
    local l=0
    local r=0
    for _, id in ipairs(result.top) do
      l=l+ Fk:getCardById(id):getMark("@bracqttiacs-number")
    end
    for _, id in ipairs(result.bottom) do
      r=r+Fk:getCardById(id):getMark("@bracqttiacs-number")
    end
    return l==r 
  end,
  on_use = function(self, event, target, player, data)
    target:drawCards(target:getMark("@bracqttiacs_rount-phase"),bracqttiacs.name)
    target:gainAnExtraPhase(Player.Play, bracqttiacs.name)
  end,
})

bracqttiacs:addEffect(fk.EventPhaseStart, {
  can_refresh = function (self, event, target, player, data)
    return player:hasSkill(bracqttiacs.name) 
    and target.phase == Player.Play 
    and  player:usedSkillTimes(bracqttiacs.name, Player.HistoryTurn) == 0
  end,
  on_refresh = function (self, event, target, player, data)
      player.room:setPlayerMark(target,"bracqttiacs_start-phase",1)
  end,
})

bracqttiacs:addEffect(fk.AfterCardUseDeclared, {
  can_refresh = function (self, event, target, player, data)
    return target == player and player:getMark("bracqttiacs_start-phase")>0
  end,
  on_refresh = function (self, event, target, player, data)
    local room=player.room
    room:addPlayerMark(player,"@bracqttiacs_rount-phase", 1)
    if data.card.number~=0 then --😓️
    room:addTableMark(player,"bracqttiacs_record-phase", data.card.number)
    end
  end,
})


return bracqttiacs
