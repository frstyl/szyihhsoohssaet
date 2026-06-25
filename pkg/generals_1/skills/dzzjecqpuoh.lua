local dzzjecqpuoh = fk.CreateSkill{
  name = "dzzjecqpuoh",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["dzzjecqpuoh"] = "城府",
  [":dzzjecqpuoh"] = "鎖定.伱轉外失去牌後,必發,伱抽等量牌;伱轉{內/外}受傷旹必發,{防止之伱抽1/伱弃1};伱手牌中{殺于轉內/閃于轉外}視爲{閃/殺}",

  ["#dzzjecqpuoh-discard"] = "城府 弃1牌",

  ["$dzzjecqpuoh1"] = "小可王倫且喜光臨草寨",
}

dzzjecqpuoh:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    local n=0
    if player:hasSkill(dzzjecqpuoh.name) and  (player.room.current ~= player or player.phase == Player.NotActive) then  --getCurrent() 
    for _, move in ipairs(data) do
      if move.from ==player and (move.to~=player or move.toArea==Card.PlayerJudge) then
        for _, info in ipairs(move.moveInfo) do
          if   (info.fromArea == Card.PlayerHand or info.fromArea == Card.PlayerEquip)   then
            n=n+1
          end
        end
      end
    end
    end
    if n>0 then
      event:setCostData(self,{n=n})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    player:drawCards(event:getCostData(self).n, dzzjecqpuoh.name)
  end,
})

-- dzzjecqpuoh:addEffect("prohibit", {
  -- prohibit_use = function(self, player, card)
    -- return card and card.trueName == "ssaet"  and player:hasSkill(dzzjecqpuoh.name) and  (Fk:currentRoom().current  ~= player or player.phase == Player.NotActive)
  -- end,
  -- prohibit_response = function(self, player, card)
    -- return card and card.trueName == "ssaet"  and player:hasSkill(dzzjecqpuoh.name) and  (Fk:currentRoom().current ~= player or player.phase == Player.NotActive)
  -- end,
-- })



-- dzzjecqpuoh:addEffect("viewas", {
  -- anim_type = "defensive",
  -- pattern = "szjemh",
  -- prompt = "#dzzjecqpuoh",
  -- mute_card = true,
  -- handly_pile = true,
  -- mute=true,
  -- card_filter = function(self, player, to_select, selected)
    -- return #selected == 0 and Fk:getCardById(to_select).trueName == "ssaet"
  -- end,
  -- view_as = function(self, player, cards)
    -- if #cards ~= 1 then return end
    -- local c = Fk:cloneCard("szjemh")
    -- c.skillName = dzzjecqpuoh.name
    -- c:addSubcard(cards[1])
    -- return c
  -- end,
  -- enabled_at_play = Util.FalseFunc,
  -- enabled_at_response = function(self, player)
    -- return Fk:currentRoom().current ~= player or player.phase == Player.NotActive
  -- end
-- })

-- dzzjecqpuoh:addEffect("filter", {
--   card_filter = function(self, to_select, player)
--     return player:hasSkill(dzzjecqpuoh.name) and to_select.trueName == "ssaet" 
--     and table.contains(player:getCardIds("h"), to_select.id)
--     and  (Fk:currentRoom().current ~= player or player.phase == Player.NotActive)
--     and ClientInstance
--     and ClientInstance.current_request_handler
--     and (ClientInstance.current_request_handler:isInstanceOf(Fk.request_handlers["AskForUseCard"])
--       or ClientInstance.current_request_handler:isInstanceOf(Fk.request_handlers["AskForResponseCard"])  --打出 --PlayCard
--       or ClientInstance.current_request_handler:isInstanceOf(Fk.request_handlers["PlayCard"]) 
--       )
--   end,
--   view_as = function(self, player, card)
--     return Fk:cloneCard("szjemh", card.suit  , card.number)
--   end,
-- })

-- dzzjecqpuoh:addEffect(fk.HandleAskForPlayCard, {
--   can_trigger = function(self, event, target, player, data)  --雙向?
--     return target == player and player:hasSkill(dzzjecqpuoh.name) 
--     and  (player.room.current ~= player or player.phase == Player.NotActive)
--     and  Exppattern:Parse(data.pattern):matchExp("ssaet") 
--   end,
--   on_use = function(self, event, target, player, data)
--     local room = player.room
--     -- room.broadcastPlaySound()
--      room:askToDiscard(player, {
--         min_num = 1,
--         max_num = 1,
--         include_equip = true,
--         skill_name = dzzjecqpuoh.name,
--         cancelable = false,
--         prompt = "#dzzjecqpuoh-discard",
--         skip = false,
--       })
--       return true
--   end,
-- })

-- ---@type AskForCardFunc
-- local dzzjecqpuoh_spec = {
--   on_use = function(self, event, target, player, data)
--     local room = player.room
--      local cards = room:askToDiscard(player, {
--         min_num = 1,
--         max_num = 1,
--         include_equip = true,
--         skill_name = dzzjecqpuoh.name,
--         cancelable = false,
--         prompt = "#dzzjecqpuoh-discard",
--         skip = false,
--       })
--     return true
--   end,
-- }

-- dzzjecqpuoh:addEffect(fk.AskForCardUse, {
--   can_trigger = function(self, event, target, player, data)
--     return target == player and player:hasSkill(dzzjecqpuoh.name) 
--     and  (player.room.current ~= player or player.phase == Player.NotActive)
--     and  Exppattern:Parse(data.pattern):matchExp("ssaet") 
--     -- and not player:prohibitUse(Fk:cloneCard("ssaet"))
--   end,
--   on_use = dzzjecqpuoh_spec.on_use,
-- })
-- dzzjecqpuoh:addEffect(fk.AskForCardResponse, {
--   can_trigger = function(self, event, target, player, data)
--     return target == player and player:hasSkill(dzzjecqpuoh.name) 
--       and  (player.room.current ~= player or player.phase == Player.NotActive)
--       and  Exppattern:Parse(data.pattern):matchExp("ssaet") 
--       -- and      not player:prohibitResponse(Fk:cloneCard("ssaet"))
--   end,
--   on_use = dzzjecqpuoh_spec.on_use,
-- })

dzzjecqpuoh:addEffect(fk.DamageInflicted, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(dzzjecqpuoh.name) 
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    if room:getCurrent()==player then
    -- local n = data.damage
    data:preventDamage()
    player:drawCards(1, dzzjecqpuoh.name)
    else
    --  local cards = 
     room:askToDiscard(player, {
        min_num = 1,
        max_num = 1,
        include_equip = true,
        skill_name = dzzjecqpuoh.name,
        cancelable = false,
        prompt = "#dzzjecqpuoh-discard",
        skip = false,
      })
    end
  end,
})

dzzjecqpuoh:addEffect("filter", {
  card_filter = function(self, to_select, player)
    return player:hasSkill(dzzjecqpuoh.name)
    and table.contains(player:getCardIds("h"), to_select.id)
    and  (
      (Fk:currentRoom():getCurrent()~=player  and to_select.trueName == "ssaet" )
    or  (Fk:currentRoom():getCurrent()==player  and to_select.trueName == "szjemh" )
  )
  end,
  view_as = function(self, player, card)
    if card.trueName=="ssaet" then
    return Fk:cloneCard("szjemh", card.suit  , card.number)
    else
    return Fk:cloneCard("ssaet", card.suit  , card.number)
    end
  end,
})
return dzzjecqpuoh
