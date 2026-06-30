---@class szyih_guos
local szyih_guos = require 'packages/szyihhsoohssaet/_base'


--- PlayCardData 打出牌  --止此2項必要--非響應  --使用打出迻動无關于使用打出事件
---@param card_ids integer[]|integer|Card|Card[] @ 牌
---@param from ServerPlayer @
---@param skillName? string @
---@param skipDrop? bool @ 畱在處理區?

---@class szyih_guos.PlayCardData: PlayCardDataSpec, TriggerData
szyih_guos.PlayCardData = TriggerData:subclass("PlayCardData")

--- 打出牌 TriggerEvent
---@class szyih_guos.PlayCard: TriggerEvent
---@field public data szyih_guos.PlayCardData
szyih_guos.PlayCard = TriggerEvent:subclass("PlayCardEvent")

--- 打出牌事件始 防止
---@class szyih_guos.PreCardPlay: szyih_guos.PlayCard
szyih_guos.PreCardPlay = szyih_guos.PlayCard:subclass("szyih_guos.PreCardPlay")

--- 打出牌旹 
---@class szyih_guos.CardPlaying: szyih_guos.PlayCard
szyih_guos.CardPlaying = szyih_guos.PlayCard:subclass("szyih_guos.CardPlaying")


--- 打出牌结束
---@class szyih_guos.CardPlayFinished: szyih_guos.PlayCard
szyih_guos.CardPlayFinished = szyih_guos.PlayCard:subclass("szyih_guos.CardPlayFinished")

---@alias PlayCardTrigFunc fun(self: TriggerSkill, event: szyih_guos.PlayCard,
---  target: ServerPlayer, player: ServerPlayer, data: szyih_guos.PlayCardData):any

---@class SkillSkeleton
---@field public addEffect fun(self: SkillSkeleton, key: szyih_guos.PlayCard,
---  data: TrigSkelSpec<PlayCardTrigFunc>, attr: TrigSkelAttribute?): SkillSkeleton

--- 打出牌 GameEvent
szyih_guos.PlayCardEvent = "PlayCard"

Fk:addGameEvent(szyih_guos.PlayCardEvent, nil, --prepare function
function (self)
  local playCardData = self.data ---@class PlayCardDataSpec
  local room = self.room ---@type Room
  local logic = room.logic
  local from = playCardData.from
  local card_ids=playCardData.card_ids

  local card =Fk:cloneCard("play")
  card:addSubcards(card_ids)
  local respondCardData={
    from=playCardData.from,
    card = card ,
    attachedSkillAndUser={muteCard=true},
  }

  -- if logic:trigger(fk.PreCardPlay, from, playCardData) then  --??
  --   logic:breakEvent()
  -- end

  if logic:trigger(fk.PreCardRespond, from, respondCardData ) then
    logic:breakEvent()
  end



  local skillName = playCardData.skillName or "unknown"


  room:moveCardTo(card_ids, Card.Processing, nil, fk.ReasonResponse)

      -- room:moveCards({
  --   ids = card_ids,
  --   toArea = Card.Processing,
  --   skillName = skillName,
  --   moveReason = fk.ReasonResponse,
  --   proposer = from,
  -- })
  room:sendFootnote(card_ids, {
    type = "##PlayCard",
    from = from.id,
  })
  room:sendLog{
    type = skillName == skillName and  "#PlayBySkill" or "PlayCard",
    from = from.id,
    card = card_ids,
    arg = skillName,
  }
  logic:trigger(fk.CardPlaying, from, playCardData)
  logic:trigger(fk.CardResponding, from, respondCardData)
end , 
function (self) --cleaner function

  local playCardData = self.data
  if playCardData.skipDrop then return end
  local room = self.room
  local cards=playCardData.card_ids
  local card =Fk:cloneCard("play")
  card:addSubcards(playCardData.card_ids)
  local respondCardData={
    from=playCardData.from,
    card = card ,
    attachedSkillAndUser={muteCard=true},
  }

  room.logic:trigger(fk.CardPlayFinished, playCardData.from, playCardData)
  room.logic:trigger(fk.CardRespondFinished, respondCardData.from, respondCardData)

  local ids = table.filter(playCardData.card_ids, function (id)
    return table.contains(room.processing_area, id)
  end)
  -- ids = room.logic:moveCardsHoldingAreaCheck(ids)
  if #ids ==0 then return end

  room:moveCards({
    ids = ids,
    toArea = Card.DiscardPile,
    moveReason = fk.ReasonResponse,
  })

end,
 nil)--exit function




Fk:loadTranslationTable{
  ["#PlayBySkill"] = "%from  打出 %card  (%arg)",
  ["#PlayCard"] = "%from  打出 %card",

  ["##PlayCard"] = "%from 打出",
}

--弃牌後?因弃置失去牌後
--抽牌?因抽得牌
szyih_guos.playCard = function(from,card_ids,skillName,skipDrop)

  if not from or not card_ids then return end
  if type(card_ids) == "number" then
    card_ids = {card_ids}
  end

  local playCardData={from=from,card_ids=card_ids,skillName=skillName,skipDrop=skipDrop}
  local event = GameEvent[szyih_guos.PlayCardEvent]:create(playCardData)
  local _, ret = event:exec()
  return playCardData --返回實際出牌 排除被防止者?
end

szyih_guos.playCardSimultaneously = function(tables)
  if not tables or type(tables)~="table" then return end
  local room = Fk:currentRoom()
  local card_ids={}
  local moveInfos={}
  local skillName=t.skillName

  for _,t in ipairs(tables) do 
    table.insertTableIfNeed(card_ids, t.card_ids)
  end
  room:moveCardTo(card_ids, Card.Processing, nil, fk.ReasonResponse)

  for _,t in ipairs(tables) do 
    room:sendFootnote(t.card_ids, {
      type = "##PlayCard",
      from = t.from.id,
    })
      room:sendLog{
      type = skillName == skillName and  "#PlayBySkill" or "PlayCard",
      from = t.from.id,
      card = t.card_ids,
      arg = skillName,
    }
  end

  local ids={}
  for _,t in ipairs(tables) do 
    if not t.skipDrop then 
      for _,id in ipairs(t.card_ids) do
        if table.contains(room.processing_area, id) then
        -- table.insertTableIfNeed(ids, t.card_ids)
        table.insertIfNeed(ids, id)
        end
      end
    end
  end

  -- ids = room.logic:moveCardsHoldingAreaCheck(ids)
  if #ids ==0 then return end
  room:moveCards({
    ids = ids,
    toArea = Card.DiscardPile,
    moveReason = fk.ReasonResponse,
  })

end



-- szyih_guos.responseCards = function (player,cards)
--     local room =player.room
--     -- for _, id in ipairs(cards) do
--     --   if player.dead then return  end
--     --   -- local card= Fk:getCardById(id)
--     --     local t={
--     --       card=Fk:getCardById(id),
--     --       from=player,
--     --       attachedSkillAndUser={muteCard=true},
--     --     }
--     --   room:responseCard(t)
--     -- end
--     local card =Fk:cloneCard("khouc") 
--     card:addSubcards(cards)
--     room:responseCard({
--       card=card,
--       from=player,
--       attachedSkillAndUser={muteCard=true},
--     })
-- end

--- RespondCardData 打出牌的数据
---@class RespondCardDataSpec
---@field public from ServerPlayer @ 使用/打出者
---@field public card Card @ 卡牌本牌
---@field public responseToEvent? CardEffectData @ 响应事件目标
---@field public skipDrop? boolean @ 是否不进入弃牌堆
---@field public customFrom? ServerPlayer @ 新响应者
---@field public attachedSkillAndUser? { user: integer, skillName: string, muteCard: boolean } @ 附加技能、使用者与卡牌静音，用于转化技

---@class AskToPlayCardParamss: AskToSkillInvokeParams #兼容askToDiscard
---@field skillName? string @ 
---@field pattern? string @ 
---@field prompt? string @ 
---@field cancelable? boolean @ 默认可以
---@field extra_data? UseExtraData|table @ 额外信息，因技能而异了
---@field event_data? CardEffectData @ 事件信息，如借刀事件之于询问杀
---@field min_num? int
---@field max_num? int 
---@field includeArea string | table @默認不含裝僃? 如手牌? ---可以通过flag.card_data = {{牌堆1名, 牌堆1ID表},...}来定制能选择的牌
---@field include_equip? bool @ --保留 會修改includeArea
---@field expand_pile? string|integer[] @
---@field skip? bool @true不打出, 默認不打出 
---@field tos? bool @指示線

---@param player ServerPlayer @ 要询问的玩家
---@param params AskToPlayCardParams @ 各种变量
szyih_guos.askToPlayCard = function (player,params)
  if params.event_data and event_data:isDisresponsive(player) then
    return {}
  end


  local extra_data = params.extra_data and table.simpleClone(params.extra_data) or {}
  local skillName, pattern, prompt, cancelable, event_data, min_num, max_num, includeArea, expand_pile, skip,tos =
    params.skill_name, 
    params.pattern or "." , 
    params.prompt or "",
    (params.cancelable == nil) and true or params.cancelable , 
    params.event_data,
    params.min_num or 0,
    params.max_num or 1, 
    params.includeArea or (params.include_equip and "he" or "h"),
    params.expand_pile or {},
    params.skip==false and false or true,
    params.tos
  local skipDrop=params.skipDrop

  if string.find(includeArea, "e")  then table.insertTableIfNeed(expand_pile, player:getCardIds("e")) end
  if string.find(includeArea, "j") then table.insertTableIfNeed(expand_pile, player:getCardIds("j")) end
  if string.find(includeArea, "&") then table.insertTableIfNeed(expand_pile, player:getCardIds("&")) end
  if string.find(includeArea, "k") then table.insertTableIfNeed(expand_pile, S.getPlayerKoarbiukCards(player)) end

  local allCards=player:getCardIds(includeArea)
  --expand_pile
  if string.find(includeArea, "k") then 
    table.insertTableIfNeed(allCards, S.getPlayerKoarbiukCards(player))
  end

  local canPlay=table.filter(allCards,function(id)
    local card = Fk:getCardById(id)
    if  player:prohibitResponse(card) then return false end
    if  not (Exppattern:Parse(pattern):match(card)) then return end
    return true
  end)

  if min_num >= #canPlay and not cancelable then
    if skip==false then
      szyih_guos.playCard(player,canPlay,skillName)
    end
    return canPlay
  end

  local data = {
    num = max_num,
    min_num = min_num,
    -- include_area = areas,  --table
    skillName = skillName,
    pattern = pattern,
    expand_pile = expand_pile,
    canPlay=canPlay,  --代替pattern
  }
  local activeParams = { ---@type AskToUseActiveSkillParams
    skill_name = "play_card_skill",
    prompt = prompt,
    cancelable = cancelable,
    extra_data = data,
    no_indicate = params.no_indicate
  }
  local cards ={}
  local _, ret = player.room:askToUseActiveSkill(player, activeParams)
  if ret then
   cards = ret.cards
  else
    if  cancelable then return {} end  --不足則全弃, 不足則全打出?
    cards = table.random(canPlay, max_num)
  end

  if #cards < 1 then return {} end

  if  skip==false then
    szyih_guos.playCard(player,cards,skillName,skipDrop)
  end

  return cards
end
