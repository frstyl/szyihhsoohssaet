local bracqtszyinh = fk.CreateSkill {
  name = "bracqtszyinh",
  tags = { Skill.Compulsory },
}

--賦斂
--kaaktszjer
Fk:loadTranslationTable{
  ["bracqtszyinh"] = "平準", 
  [":bracqtszyinh"] = "輪始旹,必發｡伱聲明1效果(覆蓋元效果)1.; 2.; 3.; 4.; 伱獲得對策",

  ["bracqtszyinh_start"] = "准备阶段和结束阶段：非锁定技失效",
  ["bracqtszyinh_judge"] = "判定阶段：选择两种延时锦囊进行判定",
  ["bracqtszyinh_draw"] = "摸牌阶段：摸到的牌颜色相同则弃置",
  ["bracqtszyinh_play"] = "出牌阶段：每种类别手牌只能使用一张",
  ["bracqtszyinh_discard"] = "弃牌阶段：你获得其弃置的牌",

  ["@bracqtszyinh-round"] = "平準",

  ["$bracqtszyinh1"] = "天时未到？可花时已到！",
  ["$bracqtszyinh2"] = "我于九州洗砚，如何不染人间？",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"


bracqtszyinh:addEffect(fk.RoundStart, {
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(bracqtszyinh.name) 
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room

      local phases = {"start", "judge", "draw", "play", "discard"}
      local choices = room:askToChoice(player, {
        choices = table.map(phases, function(phase)
          return "bracqtszyinh_"..phase
        end),
        skill_name = bracqtszyinh.name,
        prompt = "#bracqtszyinh-choice",
        cancelable = false,
      })

      room:setBanner("@bracqtszyinh-round",choices)
      room:setPlayerMark(player, "bracqtszyinh_counter-round", choices)

        room:handleAddLoseSkills(player, skill)
        room.logic:getCurrentEvent():findParent(GameEvent.Round):addCleaner(function()
          room:handleAddLoseSkills(player, "-"..skill)
        end)
      -- for _, p in ipairs(room:getOtherPlayers(player, false)) do

      --   room:setPlayerMark(p, bracqtszyinh.name, mark)

      -- end

  end,
})




bracqtszyinh:addEffect(fk.AfterCardUseDeclared, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player.room:getBanner("@bracqtszyinh-round") == "bracqtszyinh_play"
  end,
  on_trigger = function(self, event, target, player, data)
    if player:getMark("bracqtszyinh_counter-round") == "bracqtszyinh_play" then 
      local tos = player.room:askToChoosePlayers(player, {
        targets = table.filter(player.room:getOtherPlayers(player),function(p)
          return not table.contains(p:getTableMark("@bracqtszyinh_play_record-turn"), S.getCardTypeByName(data.card.trueName))
        end),
        min_num = 1,
        max_num = 1,
        prompt = "#bracqtszyinh-use-ask",
        skill_name = bracqtszyinh.name,
        cancelable=true,
      })
      if #tos>0 then data.from=tos[1]
        data.target=tos[1]
        data.extra_data=data.extra_data or {}
        data.extra_data.origin_from= data.extra_data.origin_from or player
      end
    end
    player.room:addTableMark(data.from, "@bracqtszyinh_play_record-turn", S.getCardTypeByName(data.card.trueName))
    -- player:drawCards(1,bracqtszyinh.name)

  end,
})

bracqtszyinh:addEffect("prohibit", {
  prohibit_use = function(self, player, card)
    if card and player and table.contains(player:getTableMark("@bracqtszyinh_play_record-turn"), S.getCardTypeByName(card.trueName)) then
      return true
    end

  end,
})


-- bracqtszyinh:addEffect(fk.BeforeCardsMove, {
--   anim_type = "negative",
--   can_trigger = function(self, event, target, player, data)
--     local t={}
--       for _, move in ipairs(data) do
--         if move.to == player and move.toArea == Player.Hand and move.moveReason == fk.ReasonDraw then
--           t[move.to] = (t[move.to] or 0) +#move.moveInfo
--         end
--       end
--       if #t > 0 then
--         event:setCostData(self, { extra_data = t })
--         return true
--       end
--     end
--   end,
--   on_trigger = function(self, event, target, player, data)
--    local 
--   end,
-- })

bracqtszyinh:addEffect(fk.BeforeDrawCard, {
  anim_type = "negative",
  can_trigger = function(self, event, target, player, data)
    return target == player and player.room:getBanner("@bracqtszyinh-round") == "bracqtszyinh_draw"
    and data.num>0
  end,
  on_trigger = function(self, event, target, player, data)
    local n = (data.num+1) //2
    -- S.printKhoucTo(player, 2*n,bracqtszyinh.name)
      room:moveCards({
      ids = S.getKhouc(2*n),
      to = nil,
      toArea = Card.DrawPile,
      moveReason = fk.ReasonJustMove,  --Prey?
      proposer = nil,
      skillName = bracqtszyinh.name,
    })
    data.num = data.num + n
    if player:getMark("bracqtszyinh_counter-round") == "bracqtszyinh_draw" then 
      data.fromPlace="bottom"
    end
  end,
})

--手牌冣多 --
-- bracqtszyinh:addEffect(fk.AfterCardsMove, {
--   anim_type = "negative",
--   can_trigger = function(self, event, target, player, data)
--     local t={}
--       for _, move in ipairs(data) do
--         if move.to == player and move.toArea == Player.Hand and move.moveReason == fk.ReasonDraw then
--           t[move.to] = (t[move.to] or 0) +#move.moveInfo
--         end
--       end
--       if #t > 0 then
--         event:setCostData(self, { extra_data = t })
--         return true
--       end
--     end
--   end,
--   on_trigger = function(self, event, target, player, data)
--    local 
--   end,
-- })

-- bracqtszyinh:addEffect(fk.BeforeCardsMove, {
--   can_trigger = function(self, event, target, player, data)
--     if player.room:getBanner("@bracqtszyinh-round") ~= "bracqtszyinh_discard" then return end
--     for _, move in ipairs(data) do
--         -- if move.to and  move.to:getMark("bracqtszyinh_counter-round") == "bracqtszyinh_draw" 
--         --   and move.toArea == Card.PlayerHand 
--         -- then
--         --   return true  ---偷
--         -- end
--         if move.moveReason == fk.ReasonDiscard and  move.toArea == Card.DiscardPile and move.proposer ==move.from then
--           return true
--         end
--     end
--   end,
--   on_trigger = function(self, event, target, player, data)
--     -- for _, move in ipairs(data) do
--     --     if move.to and  move.to:getMark("bracqtszyinh_counter-round") == "bracqtszyinh_draw" 
--     --       and move.toArea == Card.PlayerHand 
--     --     then
--     --        move.toArea == Card.PlayerSpecial
--     --        move.specialName="bracqtszyinh_pile"
--     --     end
--     -- end
--     local room=player.room
--     local t={}
--     for _, move in ipairs(data) do  --未整合
--         if move.moveReason == fk.ReasonDiscard and  move.toArea == Card.DiscardPile and move.proposer ==move.from then
--               for _, info in ipairs(move.moveInfo) do
--                 if info.fromArea==Card.PlayerHand or info.fromArea==Card.PlayerEquip then
--                   t[move.from]=(t[move.from] or 0) +1
--                 end
--               end
--         end
--     end
    
--     for p , n in ipairs(t) do
--       local result = room:askToDiscard(to, {
--         min_num = (n+1)//2,
--         max_num = (n+1)//2,
--         include_equip = false,
--         skill_name = bracqtszyinh.name,
--         cancelable = false,
--         prompt = "#bracqtszyinh-discard",
--       })
--       for _, move in ipairs(data) do  --未整合
--           if move.moveReason == fk.ReasonDiscard and  move.toArea == Card.DiscardPile and move.p ==move.from then
--             local infos={}
--             for _,id in ipairs(result) do
--               table.insert(infos,{cardId = id,
--               fromArea = Card.PlayerHand})
--             end
--           end
--       end
--     end
--   end,
-- })

return bracqtszyinh
