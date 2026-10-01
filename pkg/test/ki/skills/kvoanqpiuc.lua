local kvoanqpiuc = fk.CreateSkill{
  name = "kvoanqpiuc", 
}


Fk:loadTranslationTable{
  ["kvoanqpiuc"] = "觀風",
  [":kvoanqpiuc"] = "伱預段始旹,伱可發動｡全體腳色議事(同旹各展示1手牌),若亮出牌花色无冣多或爲♥️,亮出花色不爲♥️者同旹各弃一半手牌",
  -- [":kvoanqpiuc"] = "伱預段始旹,伱可發動｡全體腳色議事(同旹各展示1手牌),若紅牌多,亮出紅牌腳色各選2手牌,否則全體腳色各選2手牌,同旹弃置所選牌",

  -- ["#kvoanqpiuc-discard"] = "觀風 弃置2手牌",
  ["#kvoanqpiuc-discard"] = "觀風 弃置 %arg 手牌",

  ["$kvoanqpiuc2"] = "風吹艸上 必偃",
}

local U = require "packages.utility.utility"

kvoanqpiuc:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target==player and data.phase==Player.Start and player:hasSkill(kvoanqpiuc.name)
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    -- local discussion = U.Discussion(player, room.alive_players, kvoanqpiuc.name )

    local req = Request:new(room.alive_players, "AskForUseActiveSkill")
    req.focus_text = kvoanqpiuc.name
    local extraData = {
      num = 1,
      min_num = 1,
      include_equip = false,
      pattern = ".",
      reason = kvoanqpiuc.name,
    }

    local data = { "choose_cards_skill", "#askForDiscussion", false, extraData }
    for _, p in ipairs(room.alive_players) do
      req:setData(p, data)
      req:setDefaultReply(p, room:tableRandomPick(p:getCardIds("h"), 1))
    end
    req:ask()
    local results ={}
    local ids={}
    local tos={}
    local suits={}
    for _, p in ipairs(room.alive_players) do

      local result = req:getResult(p)
      if result ~= "" then
        local id
        if result.card then
          id = result.card.subcards[1]
        else
          id = result[1]
        end
        results[p]=id
        table.insert(ids,id)
        local suit=id and Fk:getCardById(id).suit or Card.NoSuit
        suits[suit]=(suits[suit] or 0)+1
        if not p.dead and (suit~=Card.Heart) then table.insert(tos,p) end
      end

          
    end

    local max=0
    local result_suit=Card.NoSuit
    for suit=1,4,1 do
      
      if suits[suit] and suits[suit]>max then max=suits[suit] result_suit=suit 
      elseif suits[suit] and suits[suit]==max then  result_suit= Card.NoSuit  
      end
    end

    if result_suit == Card.Spade then
      result_suit = "spade"
    elseif result_suit == Card.Heart then
      result_suit = "heart"
    elseif result_suit == Card.Club then
      result_suit = "club"
    elseif result_suit == Card.Diamond then
      result_suit = "diamond"
    elseif result_suit == Card.NoSuit then
      result_suit = "nosuit"
    end
    room:showCards(ids)
    room:sendLog{
      type = "#ShowDiscussionResult",
      from = player.id,
      arg = "log_" ..result_suit,
      toast = true,
    }
    if result_suit~="nosuit" and result_suit~="heart" then return end

    
    local req = Request:new(room.alive_players, "AskForUseActiveSkill")
    req.focus_text = kvoanqpiuc.name

    for _, p in ipairs(room.alive_players) do
    local n=(p:getHandcardNum()+1)//2

    local data = { "discard_skill", "#kvoanqpiuc-discard:::"..n, false,  {
      num = n,
      min_num = n,
      include_equip = false,
      pattern = ".",
      reason = kvoanqpiuc.name,
    } }
      req:setData(p, data)
      req:setDefaultReply(p, room:tableRandomPick(p:getCardIds("h"), n))
    end
    req:ask()

    local moves = {}
    for _, p in ipairs(tos) do
      local cards = result[p] or {}
      if #cards > 0 then
        -- table.insert(moves, {
        --   ids = cards,
        --   from = p,
        --   toArea = Card.DiscardPile,
        --   moveReason = fk.ReasonDiscard,
        --   proposer = p,
        --   skillName = kvoanqpiuc.name,
        -- })
        table.insertTable(moves,cards)
      end
    end
      -- room:moveCards(table.unpack(moves))
    room:moveCardTo(moves,Card.DiscardPile,nil,fk.ReasonDiscard,kvoanqpiuc.name)
    
  end,
})


-- kvoanqpiuc:addEffect(fk.EventPhaseStart, {
--   anim_type = "drawcard",
--   can_trigger = function(self, event, target, player, data)
--     return target==player and data.phase==Player.Start and player:hasSkill(kvoanqpiuc.name)
--   end,
--   on_use = function(self, event, target, player, data)
--     local room=player.room
--     local discussion = U.Discussion(player, room.alive_players, kvoanqpiuc.name )
--     local tos={}
--     if discussion.color~="red" then
--       tos=room.alive_players
--     else
--       for p, result in ipairs(discussion.results) do
--         if not p.dead and result.opinion=="red" then
--                   table.insert(tos,p)

--         end
--       end
--     end
--       local result = room:askToJointCards(player, {
--         players = tos,
--         min_num = 2,
--         max_num = 2,
--         cancelable = false,
--         skill_name = kvoanqpiuc.name,
--         prompt = "#kvoanqpiuc-discard",
--         include_equip=false,
--         will_throw = true,
--       })
--       local moves = {}
--       for _, p in ipairs(tos) do
--         local cards = result[p] or {}
--         if #cards > 0 then
--           -- table.insert(moves, {
--           --   ids = cards,
--           --   from = p,
--           --   toArea = Card.DiscardPile,
--           --   moveReason = fk.ReasonDiscard,
--           --   proposer = p,
--           --   skillName = kvoanqpiuc.name,
--           -- })
--           table.insertTable(moves,cards)
--         end
--       end
--       -- room:moveCards(table.unpack(moves))
--     room:moveCardTo(moves,Card.DiscardPile,nil,fk.ReasonDiscard,kvoanqpiuc.name)
    
--   end,
-- })



return kvoanqpiuc
