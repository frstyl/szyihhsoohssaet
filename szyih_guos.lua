-- 階段 轉 越過
--getNextOne
--setSquad
-- 印空 getKhouc
-- 葢伏操作 koarbiuk
-- 用牌 用葢牌 檢測 getHolders
-- 牌類 getCardType 類合成規則 mixCard
-- virtualEquip
-- not_equip 非裝僃置入裝僃區
--handleAddLoseSkills
-- 咒術 hasTsziukzzyit

-- 改requst usecard能使用額外牌

--改damage流程
--改hpchange流程

--改usecard流程 PreCardUse 歬增 modtarget 旹機 用于fixtarget 改爲无目幖可生效
--改BeforeCardUseEffect 流程 以trigger 依cardtype 執行效果,效果書于card  --AG兩種效果如何判定旹機?
-- virtualEquip getAttackRange有誤
--无效旹antiNullify
--addLoseSkill

-- local szyih_guos = {}
local szyih_guos = require 'packages/szyihhsoohssaet/_base'

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

szyih_guos.setLoav = function (playerid, num)
  local player = type(playerid)=="number" and Fk:currentRoom():getPlayerById(playerid) or playerid
  local room=player.room
  room:setPlayerMark(player,"@loav",num)
end

szyih_guos.changeLoav = function (playerid, num)  --skipNextTurn
  local player = type(playerid)=="number" and Fk:currentRoom():getPlayerById(playerid) or playerid
  local room=player.room
  room:setPlayerMark(player,"@loav",player:getMark("@loav")+num)
end

szyih_guos.skipTurn = function (playerid,skill_name ,TurnData)
  if TurnData==nil or TurnData.turn_end==true then return end
  local player = type(playerid)=="number" and Fk:currentRoom():getPlayerById(playerid) or playerid
  local room=player.room
  local data = {
      who = player,
      reason = skill_name or room.logic:getCurrentSkillName() or "game_rule",
    }
  room.logic:trigger(fk.BeforeTurnOver, player, data)  --TurnOver==TurnOver
  if  data.prevented then return end
  room.logic:trigger(fk.TurnedOver, player, data)
  TurnData.turn_end=true 
end

szyih_guos.getPhaseString = function (phase)  --class
  if not type(phaseString)=="number" then return phaseString end
 local t ={
  [Player.RoundStart] = "輪始",
  [Player.Start]="預段",
  [Player.Judge]="伏段",
  [Player.Draw]="補段",
  [Player.Play]="主段",
  [Player.Discard]="撤段",
  [Player.Finish]="末段",
  [Player.NotActive] = "轉外",
  [Player.PhaseNone] = "未知",
}
return t[phase]
end

szyih_guos.getPhaseClass = function (phaseString)  --class
  if not type(phaseString)=="string" then return phaseString end
  local t ={
  ["輪始"] = Player.RoundStart,
  ["預段"] = Player.Start,
  ["伏段"] = Player.Judge,
  ["補段"] = Player.Draw,
  ["主段"] = Player.Play,
  ["撤段"] = Player.Discard,
  ["末段"] = Player.Finish,
  ["轉外"] = Player.NotActive,
  ["未知"] = Player.PhaseNone,
}
return t[phaseString]
end

szyih_guos.convertPhase = function (p)  --class
 local map ={
  ["輪始"] = Player.RoundStart,
  ["預段"] = Player.Start,
  ["伏段"] = Player.Judge,
  ["補段"] = Player.Draw,
  ["主段"] = Player.Play,
  ["撤段"] = Player.Discard,
  ["末段"] = Player.Finish,
  ["轉外"] = Player.NotActive,
  ["未知"] = Player.PhaseNone,
}
  if type(p) == "string" then
  return t[p]
  elseif type(p)=="number" then
    return  table.indexOf(map,p)
  end
end

szyih_guos.convertSubtype = function (t)  --class
  local map={
    "action",
    "goods",
    "trick",
    "weapon",
    "armor",
    "armor",
    "offensive_horse",
    "treasure",
    "magic",
    "allusion",
  }
  if type(t)=="number" then
    return map[t]
  elseif type(t)=="string"  then
    return table.indexOf(map,t)
  end
end

szyih_guos.convertType = function (t)  --class
  local map={
    "basic",
    "trick",
    "equip",
    "magic",
    "allusion",
  }
  if type(t)=="number" then
    return map[t]
  elseif type(t)=="string"  then
    return table.indexOf(map,t)
  end
end

szyih_guos.skipPhase = function (playerid, phase)  --phase  class
-- Player.RoundStart = 1
-- Player.Start = 2
-- Player.Judge = 3
-- Player.Draw = 4
-- Player.Play = 5
-- Player.Discard = 6
-- Player.Finish = 7
-- Player.NotActive = 8
-- Player.PhaseNone = 9

  local player = type(playerid)=="number" and Fk:currentRoom():getPlayerById(playerid) or playerid
  local room=player.room
  local phasestring = type(phase)=="string" and phase or szyih_guos.getPhaseString(phase)
  -- if #phases==0 then
  --   phases={[Player.Start]=0,[Player.Judge]=0,[Player.Draw]=0,[Player.Play]=0,[Player.Discard]=0,[Player.Finish]=0,}
  -- end
  -- phases[phase] =  phases[phase]+1
  -- room:setPlayerMark(player,"@toSkipPhases",phases)
  room:addTableMark(player,"@toSkipPhases",phasestring)
end

szyih_guos.isToSkipPhase = function (playerid, phase)  --phase  class --canSkip
  local player = type(playerid)=="number" and Fk:currentRoom():getPlayerById(playerid) or playerid
  -- if player.phase.isSkiped=true then return true end
  local str=szyih_guos.getPhaseString(phase)
    for _, p in pairs(player:getMark("@toSkipPhases")) do  --出入應該統一用number
      if str==p or phase == p then
        return true
      end
    end
    return false
end

---@param playerid? integer|player @起點  起點論死否皆計
---@param num? integer @
---@param ignoreRemoved? boolean @ 考慮迻除 默認不計入
---@param ignoreRest? boolean @ 考慮迻除休整 默認不計入
---@return Player
szyih_guos.getNextOne = function (playerid, num, ignoreRemoved, ignoreRest)  --return playerid?

    local player = type(playerid)=="number" and Fk:currentRoom():getPlayerById(playerid) or playerid
    num = num or 1  --nextOne
    local players=table.filter(Fk:currentRoom().players,function(p)  --players按座次排
        return p==player
        or  not p.dead 
        or  (p.rest~=0 and  ignoreRest==true ) --默認值???
        or ( p:isRemoved() and ignoreRemoved==true )

      end)
    local  n= (table.indexOf(players, player) + num  )%  #players 
      if n==0 then
        n= #players 
      end
    return  players[n]--進id 出class
end


szyih_guos.clearSquad = function (room,playerid)  --ids {}
  local id =type(playerid)=="number" and playerid or playerid.id

  local d=room:getBanner("squad")
  if d==nil then
    return true
  else
    local newSquad={}
    for _, t in pairs(d) do  --差亼
      table.removeOne(t,id)
      if #t>1 then table.insert(newSquad,t) end
    end
    room:setBanner("squad",newSquad)
    for i, p in ipairs(newSquad) do 
      room:setBanner("@&squad"..i,table.map(p, function(id)
        return Fk:currentRoom():getPlayerById(id).general 
      end)
      )
    end
    return true
  end
end

szyih_guos.setSquad = function (room,playerids)  --ids {}
  local pid ={}
  local newSquad={}
  for _, p in ipairs(playerids) do
    -- if type(p)=="userdata" then p=p.id end
    if type(p)=="number" then 
      table.insert(pid,p)
    else 
      table.insert(pid,p.id)
    end
  end
  local d=room:getBanner("squad")
  if d==nil then
    newSquad={pid}
  else
    for _, t in pairs(d) do  --差亼
      for _, p in pairs(pid) do
        table.removeOne(t,p)
          -- if #t<=1 then
            -- t=nil
            -- goto continue
          -- end

      end
      if #t>1 then table.insert(newSquad,t) end
    -- ::continue::
    end
    table.insert(newSquad,pid)
  end
  room:setBanner("squad",newSquad)
  for i, p in ipairs(newSquad) do 
    room:setBanner("@&squad"..i,table.map(p, function(id)
      return Fk:currentRoom():getPlayerById(id).general 
    end)
    )
  end
end

szyih_guos.getSquad = function (playerid)  --ids {}
  -- local player = type(playerid)=="number" and Fk:currentRoom():getPlayerById(playerid) or playerid
  local player=playerid
  local room = Fk:currentRoom()
  local d=room:getBanner("squad")
  if d==nil then return {player.id} end
  local id =player.id
  for _, t in pairs(room:getBanner("squad")) do
    if table.contains(t,id) then
      return t
    end
  end
  return {player.id}
end

szyih_guos.isSameSquad = function (playerid1,playerid2)  --ids {}
  if playerid1==playerid2 then return true end
  -- local id1= type(playerid1)=="number" and playerid1 or playerid1.id
  local id2= type(playerid2)=="number" and playerid2 or playerid2.id
  return table.contains(szyih_guos.getSquad(playerid1), id2)
end

szyih_guos.joinSquad = function (room,playerid1,joiners)
  -- local t =type(joiners)==
  local t =szyih_guos.getSquad(playerid1)
  for _, i in ipairs(joiners) do
    table.insert(t,i)
  end
  szyih_guos.setSquad(room,t)
end

szyih_guos.inviteToJoinSquad = function (room,player,players,sourceName,prompt)
  local req = Request:new(player, "AskForSkillInvoke")
  req.focus_text = sourceName
  req.receive_decode = false -- 这个返回的都是"1" 不用decode
  local prompt=prompt or "是否加入%src"
  local sourceName=sourceName or ""
  local data={sourceName,prompt}
  for _, p in ipairs(players) do
    req:setData(p, data)
  end
  req:ask()
  local t={}
  for _, p in ipairs(players) do
    if  req:getResult(p) ~= "" then
      talbe.insert(t,p)
    end
  end
  return t
end
--
szyih_guos.getKhouc = function (room, n)
  local ids = {}
  for _, id in ipairs(room.void) do
    if n <= 0 then break end
    local card=Fk:getCardById(id,true)
    if card.name == "khouc" then
      for mark, value in pairs(card.mark) do  --應該无需保畱者 ??
        card.mark[mark]=nil
      end
      room:setCardMark(Fk:getCardById(id), MarkEnum.DestructIntoDiscard, 1)
      table.insert(ids, id)
      n = n - 1
    end
  end
  while n > 0 do
    local card = room:printCard("khouc")
    room:setCardMark(card, MarkEnum.DestructIntoDiscard, 1)
    table.insert(ids, card.id)
    n = n - 1
  end
  return ids
end

szyih_guos.printKhouc = function (room, name, player, skill_name,  n)
  local ids= szyih_guos.getKhouc(room,n or 1)
  if name then 
    for _, id in ipairs(ids) do
      room:setCardMark(Fk:getCardById(id),"@@khouc_filter_view_as",name)
    end
  end
  if player then
  room:moveCards({
    ids = ids,
    to = player,
    toArea = Card.PlayerHand,
    moveReason = fk.ReasonJustMove,
    proposer = player,
    skillName = skill_name,
    moveVisible = true,
  })
  end
  return ids
  -- Fk:filterCard(ids[1], player)
end

---@param player @目幖
---@param cardid @ 單張牌
---@param skill_name @ 效果
---@param proposer @ 操作者 默認player
szyih_guos.koarbiuk = function(player, cardid, skill_name, proposer)  --id --多牌轉化視爲?  card止1
  local skill_name = skill_name or ""
  local proposer = proposer or player
  if (#Card:getIdList(cardid) ~= 1) then return end
  if player.dead then return end
  local room = player.room  --card不需要
  room:addSkill("#koarbiuk_rule")
  local card=Fk:getCardById(cardid)
  -- if type(card)=="number" then
  --   card=Fk:getCardById(card)
  -- end
  -- local card=Fk:getCardById(cardid)
          for name, value in pairs(card.mark) do  --轉化後葢 不會清幖記 需過一遍 --无效??
            if name:find("-inhand", 1, true) 
              -- and card.area == Card.PlayerHand 
            then
              room:setCardMark(card, name, 0)
            end
            if name:find("-inarea", 1, true) and
            type(value) == "table" and table.contains(value, card.area) and not table.contains(value, Card.PlayerJudge)
            then
              room:setCardMark(card, name, 0)
            end
        end

  local cards = Card:getIdList(card)  --getIdList
  -- local card = card:getEffectiveId()
  local c = Fk:cloneCard("koarbiuk_card")  --koarbiuk_card
  c:addSubcards(cards)  --緟寫合成規則 mixCard
  player:addVirtualEquip(c)  --filter?
  room:moveCardTo(c, Player.Judge, player, fk.ReasonPut, skill_name, nil, false, proposer, nil, {player.id})

  -- room:setCardMark(card,"@@koarbiuk-inarea", {Card.PlayerJudge,card.id})  --先幖記 迻動旹不可見
  -- -- room:moveCardTo(card, Player.Judge, player, fk.ReasonPut, skill_name, nil, false, proposer, nil, {player.id})
  -- room:moveCardTo(card, Player.Judge, player, fk.ReasonPut, skill_name.name, nil, false)

  -- function MoveEventWrappers:moveCardTo(card, to_place, target, reason, skill_name, special_name, visible, proposer, moveMark, visiblePlayers)
  -- room:handleAddLoseSkills(player, "jiocsbiuk&", nil, false, true)
end

-- local extension = Package:new("szyih_mechanism", Package.CardPack)
-- local koarbiuk_card = fk.CreateCard{  --skill card operate
--   name = "&koarbiuk_card",  --koarbiuk_card
--   type = Card.TypeTrick,
--   sub_type = Card.SubtypeDelayedTrick,
--   stackable_delayed = true,
-- }

-- extension:loadCardSkels{koarbiuk_card}
-- extension:addCardSpec("koarbiuk_card")

-- Fk:loadTranslationTable{
--   ["&koarbiuk_card"] = "葢伏",  --不需譯
-- }

-- Fk:loadPackage(extension)

--

szyih_guos.getPlayerKoarbiukCards = function (players,pattern)  
  if players ==nil then players = Fk:currentRoom().alive_players
  elseif (not players[1]) and players.class then players = { players } 
  end
  local ids={}
  local ps ={}
  for  _, p in ipairs(players) do
    for _,id in ipairs(p:getCardIds("j")) do
      if ((p:getVirualEquip(id)  and p:getVirualEquip(id).name == "koarbiuk_card" )
        -- or (#Fk:getCardById(id):getTableMark("@@koarbiuk-inarea")>0)
      )
        and  (pattern==nil or Fk:getCardById(id):matchPattern(pattern) )
      then
        table.insert(ids,id)
        table.insertIfNeed(ps,p)        
      end
    end
  end
  return ids,ps
end


szyih_guos.getAllKoarbiukCards = function (pattern) 
  return szyih_guos.getPlayerKoarbiukCards(nil,pattern)
end

szyih_guos.getPlayerDelayCards = function (player)  
  local cards = table.filter(player:getCardIds("j"), 
    function(id)
      return (not player:getVirualEquip(id)  or player:getVirualEquip(id).name ~= "koarbiuk_card" )
      and (#Fk:getCardById(id):getTableMark("@@koarbiuk-inarea")==0)
    end)
  return cards
end

szyih_guos.getPlayersRealCards= function (players,pattern,area)  --以id代name+area
  players =players or Fk:currentRoom().alive_players
  local ids={}
  for  _, p in ipairs(players) do
    for _,id in ipairs(p:getCardIds(area or "h")) do
      if Fk:getCardById(id):matchPattern(pattern) then
        table.insert(ids,id)
      end
    end
  end
  return ids
end


szyih_guos.deControl = function (player,skillName,fromPlayer)   --
  player.room:setPlayerMark(player,"loav",0)
  player.room:throwCard(szyih_guos.getPlayerDelayCards(player), skillName, player, fromPlayer or nil)
end

---@field public cardNames int[]|int @ 名或pattern
---@field public toBeCheck players[]|player @ 識別單體羣體
--return players
szyih_guos.getHolders = function(cardNames, toBeCheck, whatTodo, includeArea, cardEffectData)  --同旹 單牌? --trueName?--无抵消   
  local pattern=""
  if type(cardNames)=="table" then 
    pattern=table.concat(cardNames,",")
  elseif  type(cardNames)=="string" then 
    pattern=cardNames
  end
  if whatTodo==nil then whatTodo=fk.ReasonUse end
  if includeArea==nil then includeArea="h" end
  if whatTodo==fk.ReasonUse and not includeArea:find("&") then includeArea = includeArea.."&" end
  local only_one
  if  toBeCheck ==nil then
    toBeCheck = Fk:currentRoom().alive_players   
  elseif not toBeCheck[1] and toBeCheck.class then
    toBeCheck = { toBeCheck }
    only_one=true
  end
  local players={}  --id?

      local whatTodoCheck=function(p,card) --對單人 止檢名, --按指定id檢索(如死士)如何寫?
        if whatTodo == nil or whatTodo == fk.ReasonUse then --迻動因
          return not p:prohibitUse(card) 
        elseif  whatTodo == fk.ReasonResponse then
          return not p:prohibitResponse(card) 
        elseif whatTodo == fk.ReasonDiscard then
          return not p:prohibitResponse(card) 
        elseif table.contains({fk.ReasonRecast, fk.ReasonExchange, fk.ReasonPutIntoDiscardPile, fk.ReasonPut,fk.ReasonGive },whatTodo) then
          return true 
        end
      end

      local oldPattern = Fk.currentResponsePattern
      Fk.currentResponsePattern = pattern

      for _, p in ipairs(toBeCheck) do

              local cards = p:getCardIds(includeArea)
              if type(includeArea) == "string" and includeArea:find("k")  then --待改
                table.insertTable(cards,szyih_guos.getPlayerKoarbiukCards({p}))
              end
              for _, cid in ipairs(cards) do
                local card = Fk:getCardById(cid)
                if 
                  card:matchPattern(pattern)
                  and whatTodoCheck(p,card,whatTodo)
                then
                  table.insert(players, p)
                  goto continue
                end
              end

              if whatTodo~=nil and whatTodo~=fk.ReasonUse and whatTodo~=fk.ReasonResponse then goto continue end
              -- if not table.contains(players, p) then
              -- Self = p -- for enabledAtResponse
              for _, s in ipairs(table.connect(p.player_skills, rawget(p, "_fake_skills"))) do
                ---@cast s ViewAsSkill
                if
                  s.pattern --??如何判定 function
                  and Exppattern:Parse(pattern):matchExp(s.pattern)
                  and  (s:enabledAtNullification(p, cardEffectData)-- 以Fk.currentResponsePattern 判斷
                    --or  only_one and  s:enabledAtResponse(p, whatTodo==fk.ReasonResponse ) 
                  )    
                then
                  table.insert(players, p)
                end
              end
            -- end
          -- end
        ::continue::
      end

  Fk.currentResponsePattern = pattoldPatternern
  return players
end


--
---@class askToJointCardsParams
---@field players ServerPlayer[] @ 被询问的玩家
---@field min_num integer @ 最小值
---@field max_num integer @ 最大值
---@field include_equip? boolean @ 能不能选装备
---@field includeArea? string @ 
---@field skill_name? string @ 技能名
---@field cancelable? boolean @ 能否点取消
---@field pattern? string @ 选牌规则
---@field prompt? string @ 提示信息
---@field expand_pile? string @ 可选私人牌堆名称
---@field will_throw? boolean @ 是否是弃牌，默认否（在这个流程中牌不会被弃掉，仅用作禁止弃置技判断）

---@param player ServerPlayer @ 源
---@param params askToJointCardsParams @ 
---@return <Player, integer[] @ 返回
szyih_guos.askToChooseCardExclusively = function(player, params, whatTodo, includeArea)  --選牌 不轉化
  local skill_name = params.skill_name or "AskForCardChosen"
  local cancelable = (params.cancelable == nil) and true or params.cancelable
  local pattern = params.pattern or "."
  local players, maxNum, minNum = params.players, params.max_num, params.min_num
  local include_equip = params.include_equip or false
  local expand_pile = params.expand_pile or nil
  local will_throw = params.will_throw or false
  local prompt = params.prompt or ("#AskForCard:::" .. maxNum .. ":" .. minNum)

  if whatTodo == nil then  whatTodo = fk.ReasonUse end 

    local whatTodoCheck=function(p,card) --見上
    if whatTodo == nil or whatTodo == fk.ReasonUse then 
      return not p:prohibitUse(card) 
    elseif  whatTodo == fk.ReasonResponse then
      return not p:prohibitResponse(card) 
    elseif whatTodo == fk.ReasonDiscard then
      return not p:prohibitResponse(card) 
    elseif table.contains({fk.ReasonRecast, fk.ReasonExchange, fk.ReasonPutIntoDiscardPile, fk.ReasonPut,fk.ReasonGive },whatTodo) then
      return true 
    end
  end

  local toAsk = {}
  local ret = {}
  if cancelable then
    toAsk = players
  else
    for _, p in ipairs(players) do
      local cards = {}
      if include_equip then
        table.insertTable(cards, p:getCardIds("he"))
      else
        table.insertTable(cards, p:getCardIds("h"))
      end
      if expand_pile then
        if type(expand_pile) == "string" then
          table.insertTableIfNeed(cards, p:getPile(expand_pile))
        elseif type(expand_pile) == "table" then
          table.insertTableIfNeed(cards, expand_pile)
        end
      end
      local exp = Exppattern:Parse(pattern)
      cards = table.filter(cards, function(cid)
        local c = Fk:getCardById(cid)
        return exp:match(c) and whatTodoCheck(p,c)
      end)
      if #cards > minNum then
        table.insert(toAsk, p)
      end
      ret[p] = table.random(cards, minNum)
    end
    if #toAsk == 0 then
      return ret
    end
  end

  local req = Request:new(toAsk, "AskForUseActiveSkill")
  req.focus_text = skill_name
  req.focus_players = players
  local data = {
     "choose_cards_skill",
    prompt,
    cancelable,
    {
      num = maxNum,
      min_num = minNum,
      include_equip = include_equip,
      skillName = skill_name,
      pattern = pattern,
      expand_pile = expand_pile,
    },
  }

  for _, p in ipairs(toAsk) do
    req:setData(p, data)
    req:setDefaultReply(p, ret[p] or {})
  end
  req:ask()


    local winner = req.winners[1]

    -- askForUseCardData.afterRequest = true
    -- askForUseCardData.overtimes = req.overtimes
    -- player.room.logic:trigger(fk.HandleAskForPlayCard, nil, askForUseCardData, true)  --

    if winner then
      local result = req:getResult(winner)
      return winner, result.card.subcards

      -- useResult = self:handleUseCardReply(winner, result)

      -- if type(useResult) == "string" and useResult ~= "" then  --可能有技能
      --   table.insertIfNeed(disabledSkillNames, useResult)
      -- end
    end
    -- Fk.currentResponsePattern = nil
  -- until type(useResult) ~= "string"

  -- local askForNullificationData = {
  --   result = useResult,
  --   askForUseCardData = event_data,
  -- }
  -- player.room.logic:trigger(fk.AfterAskForNullification, nil, askForNullificationData)

end

---@param params AskToUseCardParams @ 
---@param special_params {playerid,params}
---@param expand_cards {playerid,params} 默認展開葢牌?
---@param only_trigger bool 止觸發
szyih_guos.askToUseKoarbiukCard = function(room, players, params,special_params,expand_cards, only_trigger)  --同旹  --room self 
  -- local room=players[1].room


  local only_one =nil
  if players==nil or (type(players)=="table" and  #players == 0 ) then
    room.logic:trigger(fk.AfterAskForNullification, nil, { eventData =params.event_data})    --多人 无人可用則躍過  --詢問旹? 
    return 
  end
  if not players[1] then assert(players:isInstanceOf(Player)) only_one=true players={players} end


  params.pattern = type(params.pattern) == "string" and params.pattern or tostring(Exppattern{ id = params.pattern })
  params.skill_name = params.skill_name or ""
  params.prompt = params.prompt or ("#AskForUseOneCard:::"..params.skill_name)
  params.cancelable = (params.cancelable == nil) and true or params.cancelable

  local extra_data = params.extra_data and table.simpleClone(params.extra_data) or {}
  if extra_data.bypass_times == nil then extra_data.bypass_times = true end
  if extra_data.extraUse == nil then extra_data.extraUse = true end

  local card_name, pattern, prompt, cancelable, event_data =
    params.skill_name, params.pattern, params.prompt,
    params.cancelable, params.event_data

  special_params  = special_params or {}
  expand_cards =expand_cards or {}

  local prohibiteCheck = function()--事件不可響應,
    if not event_data  then return end--此前檢是否ask 如无nulli則不問 此處檢是否能用牌
        if event_data.prohibitedCardNames then --其它禁法?
          local exp = Exppattern:Parse(pattern)
          for _, matcher in ipairs(exp.matchers) do
            matcher.name = table.filter(matcher.name, function(name)
              return not table.contains(event_data.prohibitedCardNames, name)
            end)
            if #matcher.name == 0 then return nil end  --goto
          end
          pattern = tostring(exp)
        end


        for _, p in ipairs(players) do
          if event_data:isDisresponsive(p)  then
            table.removeOne(players,p)
          end
        end
        if #players==0 then return end
  end

  local command = "AskForUseCard"


  local askForUseCardData = {  --trigger
    -- user=nil,
    cardName = card_name,
    pattern = pattern,
    extraData = extra_data,
    eventData = event_data,
  }
  -- if not prohibiteCheck() then  --goto shoutdown
  --   room.logic:trigger(fk.AfterAskForNullification, nil, { askForUseCardData =params and params.event_data })
  --   return nil
  -- end 
  local target = only_one and #players==1 and players[1] or nil
  room.logic:trigger(fk.HandleAskForPlayCard, target, askForUseCardData, true)


  room.logic:trigger(fk.AskForCardUse, target, askForUseCardData)  --插入中還被封?


  askForUseCardData.afterRequest = true
  room.logic:trigger(fk.HandleAskForPlayCard, nitargetl, askForUseCardData, true)
  askForUseCardData.afterRequest = false

  -- prohibiteCheck()
  
  local useResult
  if askForUseCardData.result then
    if type(askForUseCardData.result) == 'table' then
      useResult = askForUseCardData.result
    else
      askForUseCardData.result = nil
    end
  elseif not only_trigger then  --req
    local disabledSkillNames = {}

      local removeSkill= function() end
        removeSkill= function()
          for _, p in ipairs(players) do 
            room:setPlayerMark(p,"koarbiukCards",0)
            room:handleAddLoseSkills(p, "-jiocsbiuk&",nil,false,true)  --ask 中發動其它技能??
            -- p:loseSkill("jiocsbiuk&")
          end
      end

    repeat
      useResult = nil

      local data = {card_name, pattern, prompt, cancelable, extra_data, disabledSkillNames}  --req

      Fk.currentResponsePattern = pattern  --止能葢伏?


      room.logic:trigger(fk.HandleAskForPlayCard, target, askForUseCardData, true)

      local req = Request:new(players, command, 1)
      if not only_one then req.focus_players = room.alive_players end
      req.focus_text = card_name

      for _, p in ipairs(players) do 
        -- local a
        -- if special_params[p.id] then
        --   local b =special_params[p.id] 
        --   a={b.skill_name,b.pattern,b.prompt,b.cancelable,b.extra_data,disabledSkillNames}
        -- end
        local t=table.simpleClone(data)
        if special_params[p.id] then 
          t[1] = special_params[p.id].card_name or data[1]  --skill_name
          t[2] = special_params[p.id].pattern or data[2]
          t[3] = special_params[p.id].prompt  or data[3]
          t[4] = special_params[p.id].cancelable or data[4]
          t[5] = special_params[p.id].extra_data or data[5]
          t[6] = special_params[p.id].disabledSkillNames or data[6]
        end
          -- for k,v in ipairs(special_params[p.id] or {}) do
          --   t[k]=v
          -- end
          -- t[5].expand_cids= expand_cards[p.id]  or {}
          req:setData(p, t) 
          room:setPlayerMark(p,"koarbiukCards",expand_cards[p.id]  or {})
          room:handleAddLoseSkills(p, "jiocsbiuk&",nil,false,true)  --ask 中發動其它技能??
          -- p:addSkill("jiocsbiuk&")
      end


      req:ask()
      local winner = req.winners[1]

      askForUseCardData.afterRequest = true
      askForUseCardData.overtimes = req.overtimes
      room.logic:trigger(fk.HandleAskForPlayCard, target, askForUseCardData, true)

      if winner then
        local result = req:getResult(winner)
        useResult = room:handleUseCardReply(winner, result,{
        skill_name = card_name,
        prompt = prompt,
        pattern = pattern,
        cancelable = cancelable,
        extra_data = extra_data,
        event_data = event_data,
      })

        if type(useResult) == "string" and useResult ~= "" then
          table.insertIfNeed(disabledSkillNames, useResult)
        end
      end
      Fk.currentResponsePattern = nil
      removeSkill()
    until type(useResult) ~= "string"

  end

  if target then
    askForUseCardData.result = useResult
    room.logic:trigger(fk.AfterAskForCardUse, target, askForUseCardData)
    return useResult
  else
    local askForNullificationData = {
      result = useResult,
      askForUseCardData = event_data,
    }
    room.logic:trigger(fk.AfterAskForNullification, nil, askForNullificationData)  --詢問旹?
    return useResult
  end


  -- ::shoutdown::
  -- room.logic:trigger(fk.AfterAskForNullification, nil, { askForUseCardData =params and params.event_data })
  -- return nil

end



--
szyih_guos.mixCard = function (card)  --多子牌緟算色點 updateColorAndNumber  --virtual id 0 无法已id得牌
  if type(card) ~= "table" then
    return
  end

  local n=#card.subcards
  
    if n==0 then  --?
      card.suit = Card.NoSuit
      card.color = Card.NoColor
      card.number = 0
      return
    end

    local c=Fk:getCardById(card.subcards[1])
    if n == 1 then
      card.suit = c.suit
      card.color = c.color
      card.number = c.number
      return
    end
    --n>1
    local suit = c.suit  --function內
    local color = c.color
    local number = c.number
    local different_color = false
    local i=1

    -- local function sum()
    --   while i<=n do
    --     i=i+1
    --     number = number + card.subcards[i].number
    --   end
    -- end
    local numberAdd=function(c)
      if number == 0 or c.number == 0 then
        number=0
        numberAdd=function() end
      else
         number = number + c.number  --相加无限 0爲无點  
      end
    end

    local colorAdd=function(c)
      if color == Card.NoColor or c.color == Card.NoColor or color~= c.color   then
        color=Card.NoColor  
        colorAdd=function() end
      end
    end

    local suitAdd=function(c)
      if suit==Card.Nosuit or c.suit == Card.Nosuit  or suit~= c.suit then
        suit=Card.NoSuit
      suitAdd=function() end
      end
    end


    while i<n do
      i=i+1
      local c=Fk:getCardById(card.subcards[i])
      numberAdd(c)
      suitAdd(c)
      colorAdd(c)
    end

    card.suit = suit  --初旹執行 若有異則改
    card.color = color
    card.number = number
end


-- szyih_guos.getModeCamps = function (room)
--   local n=0
--   if room:isGameMode("role_mode") then  --主忠必有  lord loyalist rebel renegade civilian
--       local rebel=false
--     for _, p in ipairs(room.players) do
--       if p.role=="renegade" then 
--         n=n+1
--       elseif p.role=="rebel" then
--         rebel=true
--       end
--     end
--     if rebel then
--        n=n+2
--        goto result
--     else 
--        n=n+1
--        goto result
--     end
--   end
--   ::result::
--   return n
-- end



-- szyih_guos.NoTargetCanUse = function(self, player, card)
--     return not player:prohibitUse(card)
-- end

szyih_guos.isTargetedCard = function(cardid)
  local card=cardid
  if type(card) == "number" then
    card = Fk:getCardById(cardid)
  elseif type(card) == "string" then
    card=Fk:cloneCard(card)
  end
  local name=card.trueName 
  local t={"jink","gij",
  "nullification","theem_prac_kaemh_tsoavs","tsiac_keejs_dzius_keejs",
  "lih_doeojs_doav_kiac","tshjit","nniuh_ttwenh_gxen_khoon","tsjas_szji_hzfan_hzoon"}
  return not table.contains(t, name)
  -- card.skill:getMinTargetNum(player) or card.skill:fixTargets(player, self, extra_data)
end

szyih_guos.getCardUsageType = function(cardid) --卽旹 延遲 持續 --錦囊止延旹錦囊 代表延旹,卽旹爲basic
  local card=cardid
  if type(card) == "number" then
    card = Fk:getCardById(cardid)
  elseif type(card) == "string" then
    card=Fk:cloneCard(card)
  end
  if card.type == Card.TypeTrick and card.sub_type ~= Card.SubtypeDelayedTrick or  card.type == Card.TypeBasic then
    return 1
  elseif card.type == Card.TypeEquip then
    return 3 
  elseif card.sub_type == Card.SubtypeDelayedTrick  then 
    return 2
  end
end

--local cardNameAndType = {}
szyih_guos.getCardSubtypeByName = function(card,is_verse,to_string)  --getNamesBySubtype
  local cardNames = {  }--基 錦囊 裝僃 法術 事件   --en?
    cardNames[1] = {"ssaet",            "fire__ssaet", "thunder__ssaet",  "chaos__ssaet",
          "szjemh",              "chaos__szjemh",

          "gij",  --tsjer cvos jox
          "slash",            "fire__slash", "thunder__slash",  "chaos__slash", "ambush__slash",
          "jink",              "chaos__jink",
              }
    cardNames[2] =  {"nziuk",
          "tsiuh",  
          "jiak",
          "meej",
          "deep",  --derive?
          "tsoucs",
          "cuat_pjech",
          "thoac_qwen",
          "hzvoac_paav",

          "ssaac_dzzjin_koac",  --生辰綱

          "peach",  "fake__peach",
          "analeptic",  
          "mint",
          "ecstasy",
          -- "tsoucs",
          -- "cuat_pjech",
          -- "thoac_qwen",
        }

    cardNames[3] = {
          "buac_hzfan_mujs_nzjen","buac_muj_dooh_dzjemh", "tsiac_keejs_dzius_keejs","theem_prac_kaemh_tsoavs",

          "hqjin_deek_qwe_tsji", "buoh_teejh_tthiu_sjin", "hsiap_paak",
          "tous_tsiacs", "hsvoah_kouc","szyih_kouc",  "pik_dzziach_liac_ssaen", "hzaac_tshjes","thou_liac_hzvoans_dduoh", "hsio_hzvoach_hqjit_tshiac", "hqjin_szjer_ljis_doavs", "moan_theen_kvas_hsoeojh","sjevs_lih_dzoac_toav","thooms_theec",
          
          "theet_soak_ljen_hzfen",  --鐵索算何 ->因勢利導
          "maach_hsooh_hzaah_ssaen",  "kiuc_szjih_sje_ttiac",  --"muans_tsjens_dzeej_puat",
          "ttxis_tsiuh_szjet_jjen", "hsiu_jiach_ssaac_sik",
          --己
          "liac_tshoavh_seen_hzaac","mxevs_svoans_quo_seen", 
          
          --延旹
          "khxes_kheet_sis_tssaas", "tvoans_liac_dzyet_quan", "tsjek_tshoavh_doon_liac",  "tshoak_hsvoah_tsjek_sjin",
          --derive
          "buak_koavh_qwe_nzjin", "muo_ttiuc_ssaac_qiuh", "dzzuoh_dzziach_khoeoj_hsfa","tsjas_toav_ssaet_nzjin",
          
          "nullification", -- "counter", "deliberate",
          "snatch", "dismantlement", "collateral", --en nzjen
          "duel", "fire_attack",--"water_attack",  --"pik_dzziach_liac_ssaen",
          "iron_chain",
          "savage_assault", "archery_attack",
          "amazing_grace", "god_salvation",
          "ex_nihilo",  

          "indulgence", "supply_shortage", --"tsjek_tshoavh_doon_liac",

        }

    cardNames[4] = {"kaeh_hqvoans_toav",
          "ssaoc_toav","nzjit_cuat_ssaoc_toav", "tshjit_seec_kiams", "cio_ddiac_kiams", "pheek_piuc_toav",   "pjen",  --"paet_loeoc_koac_pjen","koon_coo_kiams",  --
          "puoh", "miu","toav","ddiach","hqianh_cuat_toav", --"ddiach_paet_dzzja_miu", "kxim_tssaems_puoh ", "szyih_moa_dzzjen_ddiach", "teemh_koac_tsiac",  "tsheec_lioc_hqianh_cuat_toav"
          "krak","ssaok", "baoch", --"puac_theen_hzfek_krak","kou_ljem_tshiac",  "loac_caa_baoch", 
          "kiuc","teev_kiuc",--无名?
          "phaavs", --礟
          "ddiak",

          "crossbow",
          "guding_blade","double_swords","ice_sword","qinggang_sword",
          "axe","spear","blade",
          "fan","halberd",
          "kylin_bow",
      }
    cardNames[5] ={"svoah_tsih_kaap","boos_nzjin_kaap","soam_ddioc_khoeojh",  "lioc_boav", "biucs_szjes_khooj","soeojs_doac_ceej",
          "eight_diagram","nioh_shield","vine", "silver_lion",
          "jjas_hzaac_hqij",
                }

    cardNames[6]={  "syet_baak_kwenh_moav","tsheen_lih_seej_piuc", "gi_ljin_szius", 
    "hqeen_tszji", 
    "tszjevs_jjas_ciok_ssxi_tsih",
    "ljen_hzfan_maah" ,
      }
          
    cardNames[7]={"cxin_ssik_gwen_hsfa","syet_paavs","tszhjek_thoos", 
    "thoop_syet_hqoo_tszyi",  
    "tsheec_tshouc_maah" , 
            }

    cardNames[8]= {"hoeojh_tshjev",
          "kaap_maah",
          "gi",
          "soam_dzzjin_gi"
        }
    
    cardNames[9] = {"theen_looj", "szjemh_deens","lightning",--
      
       "hsoeojh_seevs", "hqoon_jyek",
    "ssaen_hsvoah","djis_douch",
              }  --天災屬法術

    cardNames[10]={
          "lih_doeojs_doav_kiac",
          "nniuh_ttwenh_gxen_khoon", --七死七生cvos jox 挩胎換骨? hzvah_piu禍福无門 ?--theen qiuh piu tsshik,gvoah piu toan hzaac
          "tshjit",--

          "hzvoans_tsiacs",--jje_hzeec_hzvoans_hqrach
          "hsoo_piuc_hsvoans_quoh",

          "szjep_hzoon",
          "jje_seec_jjek_sius",

          "tsjas_szji_hzfan_hzoon",
          "khuo_kuujh_dzziuk_zja",  --難分類

          "douc_ssaac_giocx_sjih",
          "bioc_hsioc_hsfas_kjit", --Ex
          "tsoeojs_ssaac", --枯木逢萅
          "tsoeoj_hzvoah",--天災?
        }
    cardNames[11] = {"tous_puap_phoas_koav_ljem",
          "liac_ssaen_hsoavh_hsoans_kiap_puap_ddiac",
          "soocs_kouc_mrac_cuos_kiuh_theen_gveen_nnioh",
          "ttxes_tshuoh_ssaac_dzzjin_koac",
          "hsfa_hzova_ddiacs_thoucs_toah_sjevh_paas_quac",
          "tsyis_toah_tsiach_moon_zzin",
          "quac_boa_thoom_hsoojh_szyet_piuc_dzjec",
          "zjim_jiac_lou_deej_puad_szi",
          "ddzi_tshjen_doavs_kaap",
       }

  cardNames[12]={"khouc"} --😓️

  if is_verse== true then
    return cardNames[card] or {}
  end

  local cardName =""
  if type(card) == "string"  then
    cardName=card
  elseif type(card) == "number" then
    cardName = Fk:getCardById(card).name
  elseif  type(card) == "table" then
    cardName=card.name
  end

  for i, names in pairs(cardNames) do
    if table.contains(names, cardName) then
      return to_string~=true and i else szyih_guos.convertSubtype(i)
    end
  end

  -- if  table.contains({"khouc"} , cardName) then
  --   return -1
  -- end

  return 12 --nil?未知?无類?
end

---@field public is_verse bool @ 輸入類返回名列表
szyih_guos.getCardTypeByName = function(card,is_verse,to_string) --寫一遍就行 Subtype --getNamesBytype
  local cardTypes = {}--基 錦囊 裝僃 法術 事件   --en?
  cardTypes[1]={1,2}  --基 物,作
  cardTypes[2]={3}  --錦囊
  cardTypes[3]={4,5,6,7,8} --5類裝僃
  cardTypes[4]={9,10}  --天災 法術
  cardTypes[5]={11}  --事件
  cardTypes[6]={12}  --无

  if is_verse==true then
    if type(card)~="number" or cardTypes[card] ==nil then return {} end
    local t=szyih_guos.getCardSubtypeByName(cardTypes[card][1],true)
    for i=2, #cardTypes[card],1 do
      table.insertTable(t,szyih_guos.getCardSubtypeByName(cardTypes[card][i],true))
    end
    return t
  end
  local cardName =""
  if type(card) == "string"  then
    cardName=card
  elseif type(card) == "number" then
    cardName = Fk:getCardById(card).name
  elseif  type(card) == "table" then
    cardName=card.name
  end

  local typ=szyih_guos.getCardSubtypeByName(cardName)
  for i, typs in pairs(cardTypes) do
    if table.contains(typs, typ) then
      return to_string~=true and i or szyih_guos.convertType(i)
    end
  end

  return -2 --nil?
end

---@field public notype boolean? @ 无類別不同類且不異類 默認爲總不同類
szyih_guos.compareCardType = function(c1,c2, different, notype)  --name
   
  local n =szyih_guos.getCardTypeByName(c1)
  local m=szyih_guos.getCardTypeByName(c2)
  if notype==true and (n==6 or m==6) then return false end
  local same=n~=6 and n == m
  if  different==true then return not same else return same end
end

szyih_guos.compareCardSubType = function(c1,c2, different, notype)
   
  local n =szyih_guos.getCardSubtypeByName(c1)
  local m=szyih_guos.getCardSubtypeByName(c2)
  if notype==true and (n==12 or m==12) then return false end
  local same=n~=12 and n == m
  if  different==true then return not same else return same end
end

szyih_guos.getCardNameLength = function(card)
  local cardName =""
  if type(card) == "string"  then
    cardName=card
  elseif type(card) == "number" then
    cardName = Fk:getCardById(card).trueName
  elseif  type(card) == "table" then
    cardName=card.trueName
  end
  if table.contains({"khouc","hsio","hqrach"}, cardName) then return 0 end
  return Fk:translate(cardName, "zh_CN"):len()  
end

szyih_guos.isAttackCard = function(card,player,skillName)
    local cardNames ={"slash","duel", "dismantlement", "snatch", "savage_assault", "archery_attack", "fire_attack","szyih_kouc","indulgence", "supply_shortage", }
    local cardName =""
    if type(card) == "string"  then
      cardName=card
    elseif type(card) == "number" then
      card = Fk:getCardById(card)
    elseif  type(card) == "table" then
      cardName=card.trueName
    end

    return table.contains(cardNames, cardName) 

end
Fk:loadTranslationTable{
  ["AttackCard"] = "\"<b>進攻牌</b>\" 殺 鬥將 釜底抽薪 因敵爲資 猛虎下山 弓矢 火攻 水攻 詐 斷",
}

szyih_guos.isCommonTrick = function(cardName)  --name
  return szyih_guos.getCardTypeByName(cardName) ==2 and szyih_guos.getCardUsageType(cardName)==1
end

szyih_guos.getNamesBySubtype = function(typeN)  --number
  if type(typeN)~="number" then return {} end
  return szyih_guos.getCardSubtypeByName(typeN,true)
end

szyih_guos.getNamesByType = function(typeN)  --number
  if type(typeN)~="number" then return {} end
  return szyih_guos.getCardTypeByName(typeN,true)
end

szyih_guos.moveNonEquipIntoEquipArea = function (target, cards, skillName, convert, proposer, slots)  --指定裝僃欄  暫假定1種欄止1 1裝僃子類止1
    -- local mapper = {
    --   [Card.SubtypeWeapon] = "weapon",  --num
    --   [Card.SubtypeArmor] = "armor",
    --   [Card.SubtypeDefensiveRide] = "offensive_horse",
    --   [Card.SubtypeOffensiveRide] = "defensive_horse",
    --   [Card.SubtypeTreasure] = "treasure",
    -- }
    
    local room=target.room
    cards = type(cards) == "table" and cards or {cards}  --對噟
    slots = type(cards) == "table" and slots or {slots}
    if #cards~=#slots then return end

    room:addSkill("not_equip_filter_skill")

    for i, cid in ipairs(cards) do
      room:setCardMark(Fk:getCardById(cid), "@@not_equip", slots[i])  --手動刪除?
      Fk:filterCard(cid, target)
    end

    -- local equips={}
    -- for i, cid in ipairs(cards) do
    --   local card = Fk:cloneCard(mapper[slots[i]].."__not_equip")
    --   card:addSubcard(cid)
    --   table.insert(equips,card)
    -- end

    room:moveCardIntoEquip(target, cards, skillName, convert, proposer)

    for i, cid in ipairs(cards) do
      room:setCardMark(Fk:getCardById(cid), "@@not_equip", 0)
      -- Fk:filterCard(cid, target)
    end
end

-- szyih_guos.addVirtualEquip = function (player,cards)
-- end

-- ---@param derive_from string @ 本有技能 發弃
-- ---@param source string @ 源名 无則爲得失實技能
-- ---@return string[],string[] @ 得,失技能 
-- szyih_guos.handleAddLoseSkills = function(player, skill_names, derive_from, sendlog, no_trigger, source)
--   local virtualSkills =player:getTableMark("_virtual_skills")  --tag有何用?
--   -- local virtualSkills =player.tag["_virtual_skills"] or {}
--   -- local skill_names={}
--   if type(skill_names) == "string" then
--     skill_names = skill_names:split("|")
--   end
--   if #skill_names == 0 then return end
--   if source==nil then source = "real" end
--   local losts = {}  ---@type boolean[]
--   local triggers = {} ---@type Skill[]
--   -- local lost_piles = {} ---@type integer[]
--   for _, skill in ipairs(skill_names) do
--     if string.sub(skill, 1, 1) == "-" then

--       local actual_skill = string.sub(skill, 2, #skill)
--       if not player:hasSkill(actual_skill, true, true)  then goto continue end

--       virtualSkills[actual_skill] =virtualSkills[actual_skill] or {"real"}  --有技能无源爲real --裝僃?
--       table.removeOne(virtualSkills[actual_skill],source )

--       if #virtualSkills[actual_skill]>0 then    goto continue end
          -- virtualSkills[actual_skill]=nil

--         local lost_skills = player:loseSkill(actual_skill,derive_from)
--         for _, s in ipairs(lost_skills) do
--           player.room:doBroadcastNotify("LoseSkill", json.encode{
--             player.id,
--             s.name
--           })
--           if sendlog and s.visible then  --非real 不當有
--             player.room:sendLog{
--               type = "#LoseSkill",
--               from = player.id,
--               arg = s.name
--             }
--           end
--         end

--         table.insert(losts, true)
--         table.insert(triggers, Fk.skills[actual_skill])
--         player.room:validateSkill(player, actual_skill)
--         for _, suf in ipairs(MarkEnum.TempMarkSuffix) do
--           player.room:validateSkill(player, actual_skill, suf)
--         end
--       -- end
--     else
--       virtualSkills[skill]=virtualSkills[skill] or {}

--       table.insert(virtualSkills[skill],source )  --同名裝僃不同源
--       -- table.insertIfNeed(virtualSkills[skill],source )
--       local sk = Fk.skills[skill]
--       if not sk or player:hasSkill(sk, true, true) then    goto continue end
--         local got_skills = player:addSkill(sk,derive_from)

--         for _, s in ipairs(got_skills) do
--           -- TODO: limit skill mark

--           player.room:doBroadcastNotify("AddSkill", json.encode{
--             player.id,
--             s.name
--           })
--           if sendlog and s.visible then
--             player.room:sendLog{
--               type = "#AcquireSkill",
--               from = player.id,
--               arg = s.name
--             }
--           end
--         end
--         table.insert(losts, false)
--         table.insert(triggers, sk)

--     end
--     ::continue::
--   end

--   player:setMark("_virtual_skills",virtualSkills)
--   -- player.tag["_virtual_skills"] = virtualSkills
 
--   if #triggers > 0 then
--     no_trigger = no_trigger == nil and false or no_trigger
--     for i = 1, #triggers do
--       if losts[i] then
--         local skill = triggers[i]
--         if not no_trigger then
--           player.room.logic:trigger(fk.EventLoseSkill, player, {skill = skill, who = player})
--         end
--         skill:getSkeleton():onLose(player, false)
--       else
--         local skill = triggers[i]
--         if no_trigger then
--           skill:getSkeleton():onAcquire(player, player.room:getBanner("RoundCount") == nil)
--         else
--           player.room.logic:trigger(fk.EventAcquireSkill, player, {skill = skill, who = player})
--           skill:getSkeleton():onAcquire(player, false)
--         end
--       end
--     end
--   end

-- end

-- szyih_guos.handleAddLoseSkills = function(player, skill_names, derive_from, sendlog, no_trigger, source)
szyih_guos.handleAddLoseVirtualSkills = function(player, skill_names, source_skill, sendlog, no_trigger,derive_from )
  local virtualSkills =player:getTableMark("_virtual_skills")  --tag有何用?
  -- local virtualSkills =player.tag["_virtual_skills"] or {}
  -- local skill_names={}
  if type(skill_names) == "string" then
    skill_names = skill_names:split("|")
  end
  if #skill_names == 0 then return end
  if source==nil then source = "real" end
  local toChange = {}  ---@type string[]
  for _, skill in ipairs(skill_names) do
    if string.sub(skill, 1, 1) == "-" then

      local actual_skill = string.sub(skill, 2, #skill)

      -- if not player:hasSkill(actual_skill, true, true)  then goto continue end

      virtualSkills[actual_skill] =virtualSkills[actual_skill]
      if  virtualSkills[actual_skill]==nil or virtualSkills[actual_skill][1]==nil then virtualSkills[actual_skill] = {"real"}  end--有技能无源爲real --裝僃?
      table.removeOne(virtualSkills[actual_skill],source )

      if #virtualSkills[actual_skill]>0 then    goto continue end
      virtualSkills[actual_skill]=nil
      table.insert(toChange,skill)

    else
      virtualSkills[skill]=virtualSkills[skill] or {}

      table.insert(virtualSkills[skill],source )  --同名裝僃不同源
      -- table.insertIfNeed(virtualSkills[skill],source )

      -- local sk = Fk.skills[skill]
      -- if not sk or player:hasSkill(sk, true, true) then    goto continue end

      table.insert(toChange,skill)
    end
    ::continue::
  end

  player:setMark("_virtual_skills",virtualSkills)
  player.room:setPlayerMark(player,"@[:]virtual_skills",virtualSkills[skill])
  -- player.tag["_virtual_skills"] = virtualSkills
  player.room:handleAddLoseSkills(player, table.concat(toChange,"|"), derive_from, sendlog, no_trigger)
end

-- ---@param source_skill string @  效果源技能名,視爲有止能被源效果清除
-- ---@param sendlog bool @  
-- ---@param no_trigger bool @ 視爲技能皆爲遊戲內技能而非操作輔助 技能修改
-- szyih_guos.handleAddLoseVirtualSkills = function(player, skill_names, source_skill, sendlog, no_trigger )
--   if source_skill==nil then return end
--   szyih_guos.handleAddLoseSkills(player, skill_names, nil, sendlog, no_trigger, source_skill)
-- end

---@param player Player @ 
---@param card Card @ 卡牌
---@param source_skill string @ 

szyih_guos.addVirtualEquip = function(player, card, source_skill)
  local equip
  if not card then return end 
  if type(card)=="string" then
    equip= player.room:printCard(card)
  elseif type(card)=="table" then
    equip= player.room:printCard(card[1],card[3],card[2])
  else 
    return
  end
  equip.skillName = source_skill

  -- player.room:addTableMark(player,"@[:]virtual_equip",equip.trueName)  --止用于察看  --@$virtual_equip ?
  player.room:addTableMark(player,"@$virtual_equip",equip.id)--復活?
  -- player:addToPile("virtual_equip", equip, true,source_skill.name)
  -- player.room:addTableMark(player,"_virtual_equip",equip)  --可同名 按:皆无色?

  -- equip:onInstall(player.room, player)
  -- equip:onInstall(player.room, player)
end

szyih_guos.removeVirtualEquip = function(player, card, source_skill)
  if not card then return end 
  local name
  if type(card)~="string" then
    name=card.name
  else
    name=card
  end
  -- assert(equip and equip:isInstanceOf(Card) and equip:isVirtual())

  -- player.room:removeTableMark(player,"@[:]virtual_equip",name)
  local t = player:getTableMark("@$virtual_equip")
  for i,id in ipairs(t) do
    local equip =Fk:getCardById(id)
    if equip and equip.name==name 
      and table.contains(equip.skillNames,source_skill) 
    then
      table.remove(t, i)
      return
    end
  end
  -- player.room:removeTableMark(player,"_virtual_equip",equip)
  -- equip:onUninstall(player.room,player)
  -- equip:onUninstall(player.room, player)

end



-- ---@param from player @  使用者
-- ---@param to player @  目幖 ??角色?裝僃?技能?
-- ---@param card Card @  牌 止有幖記,无使用旹效果
-- ---@param useData CardUseData @ 使用data,預使用旹无
-- ---@param effectData bool @牌效data
szyih_guos.isIgnoreArmorFromAToB = function(from,to,card,useData,effectData)
  if not to then return end
        if card and card:hasMark("@@ignoreArmor")  then return true end
        if useData and useData.extra_data and useData.extra_data.ignoreArmorTo and table.contains(useData.extra_data.ignoreArmorTo,to) then  --use不會中途迻去效果,不計數
          return true
        end
        if effectData and effectData.extra_data and effectData.extra_data.ignoreArmorTo and table.contains(effectData.extra_data.ignoreArmorTo,to)  then
          return true
        end
        if not from then return end
        if from:hasMark("@@ignoreArmor")  then ----无視任意防具 不分來源 不失效｡ 可与MarkArmorInvalidTo合併
          return true--qinggang?
        end
        if from:hasMark("ssaetIgnoreArmor") and card.trueName=="ssaet"   then ----无視任意防具 不分來源 不失效｡ 可与MarkArmorInvalidTo合併
          return true--qinggang?
        end
        for _, skillName in ipairs(from:getTableMark("ignoreArmorBySkills"))  do --狀態技 
          if from:hasSkill(skillName) then return true end  --hasSkill已攷慮技能失效
        end
        for _, skillName in ipairs(from:getTableMark("ssaetIgnoreArmorBySkills"))  do
          if card and card.trueName=="ssaet" and  from:hasSkill(skillName) then return true end  --靑鋼劍 与類似
        end
        local suffixes = {""}  --每局 
        table.insertTable(suffixes, MarkEnum.TempMarkSuffix)--phase turn round
        for _, suffix in ipairs(suffixes) do
          if table.contains(from:getTableMark(MarkEnum.MarkArmorInvalidTo .. suffix), to.id) or  --table insert 允許緟 迻除旹刪1卽可
            table.contains(to:getTableMark(MarkEnum.MarkArmorInvalidFrom .. suffix), from.id) then
            return true
          end
        end

      -- if not card then return end
      --   if card:hasMark("@@ignoreArmor")  then 
      --     return true--qinggang?
      --   else
        --   local room = Fk:currentRoom()
      --     local e=room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true)
      --     while true do
      --       if e==nil then return end
      --       if e.data and e.data.card ==card then  --上次使用 卽止當次使用有效
      --         return e.data.extra_data and e.data.extra_data.qinggang_tag 
      --       end
      --       e=e:findParent(GameEvent.UseCard)
      --     end
      --   end

      --   for _, suffix in ipairs(suffixes) do
      --     if table.contains(card:getTableMark(MarkEnum.MarkArmorInvalidTo .. suffix), to.id)  then
      --       return true
      --     end
      --   end

      

end

szyih_guos.hasEquip = function(player,cardSubtype)
  for _, cardId in ipairs(player.player_cards[Player.Equip]) do
    card = player:getVirtualEquip(cardId) or Fk:getCardById(cardId)
    if (cardSubtype == nil or card.sub_type == cardSubtype) 
    and not card.name:endsWith("not_equip") then
      return true
    end
  end

  for _,id in ipairs(player:getTableMark("@$virtual_equip")) do
    local card =Fk:getCardById(id)
    local name = card.skillName
    if name and player:hasSkill(name) 
    --and Fk.skills[name] and table.contains(Fk.skills[name].skill_filter(self,player) or {}, card.equip_skill)
    then
      if (cardSubtype == nil or card.sub_type == cardSubtype) then
        return true
      end
    end
  end

  return  false
end

szyih_guos.magicCanUse = function(player,card)
  if  player:prohibitUse(card)  then return false end
  local t= player:getTableMark("magicTimes-turn")
  return (t[card.trueName] or 0) ==0
end

szyih_guos.magicOnUse = function(player,use)
  local t= player:getTableMark("magicTimes-turn")
  t[use.card.trueName]  = (t[use.card.trueName] or 0)+1
  player.room:setPlayerMark(player,"magicTimes-turn", t)
end

dofile 'packages/szyihhsoohssaet/aux_events/addTsziukzzyit.lua'
dofile 'packages/szyihhsoohssaet/aux_events/useNullify.lua'
dofile 'packages/szyihhsoohssaet/aux_events/effectNullify.lua'
dofile 'packages/szyihhsoohssaet/aux_events/revive.lua'
dofile 'packages/szyihhsoohssaet/aux_events/changeDamage.lua'
dofile 'packages/szyihhsoohssaet/aux_events/invalidateSkill.lua'
dofile 'packages/szyihhsoohssaet/aux_events/playCard.lua'

return szyih_guos
