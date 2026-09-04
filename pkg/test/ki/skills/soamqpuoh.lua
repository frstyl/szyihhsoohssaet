local soamqpuoh = fk.CreateSkill{
  name = "soamqpuoh",
  -- tags = { Skill.Switch, Skill.Compulsory },
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["soamqpuoh"] = "三斧",
  [":soamqpuoh"] = "伱不可調整手牌敘｡伱失去牌後,若其數爲1且爲伱冣左/正中/冣右手牌,必發,伱抽1/可虛擬使用此牌(同名同花同點)/可弃置1腳色區域內1牌",

  ["$soamqpuoh1"] = "泰山虽崩于前，我亦风淸云淡。",
  ["$soamqpuoh2"] = "诸君勿忧，一切尽在掌握。",
}

soamqpuoh:addLoseEffect(function (self, player, is_death)
  player.room:unbanSortingHandcards(player, "-_soamqpuoh")
end)

soamqpuoh:addAcquireEffect(function (self, player, is_death)
  player.room:banSortingHandcards(player, "-_soamqpuoh")
end)

soamqpuoh:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(soamqpuoh.name) 
    and  data.extra_data and data.extra_data.soamqpuohSideCards  and data.extra_data.soamqpuohSideCards[1]==player.id
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    -- player:drawCards(5,soamqpuoh.name)
    local n =data.extra_data.soamqpuohSideCards[2]
    if n==1 then
      player:drawCards(1, soamqpuoh.name)
    elseif n == 2 then
      local use = room:askToUseRealCard(player, {
        pattern = {data.extra_data.soamqpuohSideCards[3]},
        skill_name = soamqpuoh.name,
        prompt = "#soamqpuoh-use",
        extra_data = {
          bypass_times = true,
          expand_pile = {data.extra_data.soamqpuohSideCards[3]},
        },
        skip = true,
      })
      if use then
        local card = Fk:cloneCard(use.card.name,use.card.number,use.card.suit)
        card.skillName = soamqpuoh.name
        use = {
          card = card,
          from = player,
          tos = use.tos,
          extraUse = true,
        }
        room:useCard(use)
      end
    elseif n==3 then
        local to = room:askToChoosePlayers(player, {
          targets = table.filter(room.alive_players,function(p)
            return #p:getCardIds("hej")>0
          end),
          min_num = 1,
          max_num = 1,
          prompt = "#soamqpuoh-discard",
          skill_name = soamqpuoh.name,
          cancelable = true,
        })
        if #to>0 then
          local cid = room:askToChooseCard(player, { target = to[1], flag = "hej", skill_name = soamqpuoh.name })
          room:throwCard({cid}, soamqpuoh.name, to[1], player)
        end
    end

  end,
})

soamqpuoh:addEffect(fk.BeforeCardsMove, {
  can_refresh = function (self, event, target, player, data)
    if not player:hasSkill(soamqpuoh.name, true) then return end

    local cid 
        for _, move in ipairs(data) do  --data move info
          if move.from==player and #move.moveInfo==1 then 
            -- return player:hasSkill(soamqpuoh.name, true) --中途獲得技能
            for _, info in ipairs(move.moveInfo) do
              if table.contains({Card.PlayerHand,Card.PlayerEquip},info.fromArea) then
                cid= info.cardId
              end
            end
          end
        end

    if cid then
      local handcards = player:getCardIds("h")
      local n = 0
      if #handcards== 1 then 
        n=4
      elseif handcards[1] == cid then 
        n=1
      elseif handcards[#handcards] == cid then
        n=3
      elseif  #handcards%2==1 and handcards[(#handcards+1)//2] == cid then  --中
        n=2
      end
      if n~= 0 then
        event:setCostData(self,{n= n,cid=cid})
        return true 
      end
    end

  end,
  on_refresh = function (self, event, target, player, data)
    if player:canSortHandcards() then
      player.room:syncPlayerClientCards(player)
    end
    local dat =event:getCostData(self)
    data.extra_data = data.extra_data or {}
    data.extra_data.soamqpuohSideCards = {player.id, dat.n,dat.cid}
  end,
})


-- soamqpuoh:addLoseEffect(function (self, player, is_death)
--   player.room:unbanSortingHandcards(player, "-_soamqpuoh-turn")
-- end)

-- soamqpuoh:addEffect(fk.CardUsing, {
--   anim_type = "drawcard",
--   can_trigger = function(self, event, target, player, data)
--     return target == player and player:hasSkill(soamqpuoh.name) 
--     and  data.extra_data and data.extra_data.soamqpuohSideCards~=0
--   end,
--   on_use = function(self, event, target, player, data)
--     local room = player.room
--     local n =data.extra_data.soamqpuohSideCards
--     if n==1 then
--       player:drawCards(1, soamqpuoh.name)
--     elseif n == 2 then
--       data.additionalEffect=(data.additionalEffect or 0) + 1
--     elseif n==3 then
--         local to = room:askToChoosePlayers(player, {
--           targets = table.filter(room.alive_players,function(p)
--             return #p:getCardIds("he")>0
--           end),
--           min_num = 1,
--           max_num = 1,
--           prompt = "#soamqpuoh-choose",
--           skill_name = soamqpuoh.name,
--           cancelable = true,
--         })
--         if #to>0 then
--           local cid = room:askToChooseCard(player, { target = to[1], flag = "he", skill_name = soamqpuoh.name })
--           room:throwCard({cid}, soamqpuoh.name, to[1], player)
--         end
--     end
--     if not player.dead and player:getMark(MarkEnum.SortProhibited .. "-_soamqpuoh-turn") == 0 then
--       room:banSortingHandcards(player, "-_soamqpuoh-turn")
--     end
--   end,
-- })

-- soamqpuoh:addEffect(fk.PreCardUse, {
--   can_refresh = function (self, event, target, player, data)
--     return target == player and player:hasSkill(soamqpuoh.name, true) and not data.card:isVirtual()
--   end,
--   on_refresh = function (self, event, target, player, data)
--     if player:canSortHandcards() then
--       player.room:syncPlayerClientCards(player)
--     end
--     local handcards = player:getCardIds("h")
--     local n = 0
--     if #handcards== 1 then 
--       n=4
--     elseif handcards[1] == data.card.id then 
--       n=1
--     elseif handcards[#handcards] == data.card.id then
--       n=3
--     elseif  #handcards%2==1 and handcards[(#handcards+1)//2] == data.card.id then  --中
--       n=2
--     end
--     data.extra_data = data.extra_data or {}
--     data.extra_data.soamqpuohSideCards = n
--   end,
-- })

return soamqpuoh
