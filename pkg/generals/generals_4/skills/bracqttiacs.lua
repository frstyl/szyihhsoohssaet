local hzaeksvoans = fk.CreateSkill {
  name = "hzaeksvoans",
}

Fk:loadTranslationTable{
  ["hzaeksvoans"] = "核算",
  [":hzaeksvoans"] = "轉限1.一腳色A主段終旹,伱可核算,將A段內起動牌分爲2,點數和相等,若成功伱發動此技能,伱令A執行1額外主段",  --名字數

  ["#hzaeksvoans-invoke"] = "核算： %dest 主段終 是否發動 令𠂇又數值之和相等",

  ["#hzaeksvoans-left"] = "上",
  ["#hzaeksvoans-right"] = "下",
  ["#hzaeksvoans-tip"] = "核算 令上下點數和相等",

  ["@hzaeksvoans-number"] = "",
  ["@hzaeksvoans_rount-phase"] = "核算",  --用牌數
  -- ["hzaeksvoans_record-phase"] = "核算",  --點數記錄

  ["$hzaeksvoans1"] = "今日宴请诸位，有要事相商。",
  ["$hzaeksvoans2"] = "天下未定，请主公以大局为重。",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

hzaeksvoans:addEffect(fk.EventPhaseEnd, {
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(hzaeksvoans.name) 
    -- target.phase == Player.Play 
    -- and  player:usedSkillTimes(hzaeksvoans.name, Player.HistoryTurn) == 0 
    -- and target:getMark("@hzaeksvoans_rount-phase")>0
    and #player.room.logic:getEventsOfScope(GameEvent.UseCard, 1, function (e)
        return e.data.from == target 
    end, Player.HistoryPhase)>0
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    if not room:askToSkillInvoke(player, {
      skill_name = hzaeksvoans.name,
      prompt = "#hzaeksvoans-invoke::"..target.id,
    })  
    then return end
    local t ={}
        room.logic:getEventsOfScope(GameEvent.UseCard, 1, function (e)
      local dat=e.data
        if dat.from == target  then
          table.insert(t,dat.card.number)
        end
    end, Player.HistoryPhase)

    -- local t=target:getTableMark("hzaeksvoans_record-phase")
    local n =#t
    if n ==0 then return true end
    -- local ids= S.getKhouc(n)
    local ids={}
    for i=1, n, 1  do
        local card = room:printCard("khouc", Card.Spade,t[i])
      table.insert(ids,card.id)
      -- room:setCardMark(Fk:getCardById(ids[i]),"@hzaeksvoans-number", t[i])
    end
    local result = room:askToGuanxing(player,{
      cards=ids,
      -- top_limit=,
      -- top_limit=,
      skill_name=hzaeksvoans.name,
      title="#hzaeksvoans-tip",
      skip=true,
      area_names={"#hzaeksvoans-left","#hzaeksvoans-right"},
    })
    local l=0
    local r=0
    for _, id in ipairs(result.top) do
      -- l=l+ Fk:getCardById(id):getMark("@hzaeksvoans-number")
      l=l+Fk:getCardById(id).number
    end
    for _, id in ipairs(result.bottom) do
      -- r=r+Fk:getCardById(id):getMark("@hzaeksvoans-number")
      r=r+Fk:getCardById(id).number
    end
    return l==r 
  end,
  on_use = function(self, event, target, player, data)
    -- target:drawCards(target:getMark("@hzaeksvoans_rount-phase"),hzaeksvoans.name)
    target:gainAnExtraPhase(Player.Play, hzaeksvoans.name)
  end,
})

hzaeksvoans:addEffect(fk.EventPhaseStart, {
  can_refresh = function (self, event, target, player, data)
    return player:hasSkill(hzaeksvoans.name) 
    and target.phase == Player.Play 
    and  player:usedSkillTimes(hzaeksvoans.name, Player.HistoryTurn) == 0
  end,
  on_refresh = function (self, event, target, player, data)
      player.room:setPlayerMark(target,"hzaeksvoans_start-phase",1)
  end,
})

-- hzaeksvoans:addEffect(fk.AfterCardUseDeclared, {
--   can_refresh = function (self, event, target, player, data)
--     return target == player and player:getMark("hzaeksvoans_start-phase")>0
--   end,
--   on_refresh = function (self, event, target, player, data)
--     local room=player.room
--     room:addPlayerMark(player,"@hzaeksvoans_rount-phase", 1)
--     if data.card.number~=0 then --😓️
--     room:addTableMark(player,"hzaeksvoans_record-phase", data.card.number)
--     end
--   end,
-- })


return hzaeksvoans
