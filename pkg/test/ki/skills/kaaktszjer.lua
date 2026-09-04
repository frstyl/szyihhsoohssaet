Fk:loadTranslationTable{
  ["kaaktszjer"] = "格制",--窥窬
  [":kaaktszjer"] = "牌進入一腳色A區域後,,若此區域牌數大于伱對應區域牌數(詢問旹),必發,A弃置此區域1牌(多區域同旹執行)",
  -- [":kaaktszjer"] = "其它脚色一區域牌數變化後,若其大于伱,伱可發動,獲得此脚色此區域內1牌｡",

  -- ["#kaaktszjer-invoke"] = "襲敓 是否對 %dest 發動",
  -- ["#kaaktszjer-ask"] = "%src 之 %arg",

  -- ["$kaaktszjer1"] = "夜靜穿牆過更㴱繞屋縣",
  -- ["$kaaktszjer2"] = "玅手空空",
  -- ["$kaaktszjer3"] = "探囊取物㑥如反掌",

}

local kaaktszjer = fk.CreateSkill{
  name = "kaaktszjer",
  tags={Skill.Compulsory}
}

local id_area_to_key=function(n,m)
  if n and m then
    return n>0 and n*4 +m or  ( (n+1)*4-m)
  elseif n then
    -- local t
    if n >0 then return  n//4 , n%4 --无4
    else
      return  -(-n//4+1),  (-n)%4  --id-1 n
    end
  end
end

kaaktszjer:addEffect(fk.AfterCardsMove, {--應該先占卜記錄是否至多
  anim_type = "control",

  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(kaaktszjer.name) then return end

        for _, move in ipairs(data) do
          if (move.to and move.toArea ~= Card.PlayerSpecial) then
            for _, info in ipairs(move.moveInfo) do
              if #move.to:getCardIds(move.toArea )>#player:getCardIds(move.toArea ) then return true end
                -- tos[id_area_to_key(move.to.id, info.fromArea)]=true
            end
          end
        end
    
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local moveInfos = {}
    -- local params={
    --     from = nil,
    --     ids = nil,
    --     toArea = Card.DiscardPile,
    --     moveReason = fk.ReasonDiscard,
    --     proposer = nil,
    --     skillName = kaaktszjer.name,
    --   }
    local areas={}
        for _, move in ipairs(data) do
          if (move.to and move.toArea ~= Card.PlayerSpecial) then
            for _, info in ipairs(move.moveInfo) do
               areas[id_area_to_key(move.to.id, move.toArea)]=true

              -- table.insertIfNeed(areas, id_area_to_key(move.to.id, move.toArea))
            end
          end
        end
      local number={#player:getCardIds(Card.PlayerHand), #player:getCardIds(2), #player:getCardIds(3),}

      for i, n in pairs(areas) do
        local id, area = id_area_to_key(i)
        -- room:changeHp(player,id)
        -- room:changeHp(player,number[area])

        local to=room:getPlayerById(id)
        room:changeHp(to,area)
        if #to:getCardIds(area)>number[area] then
        table.insert(moveInfos, {
          from = to,
          ids = room:tableRandomPick(to:getCardIds(area),1),
          toArea = Card.DiscardPile,
          moveReason = fk.ReasonDiscard,
          proposer = to,
          skillName = kaaktszjer.name,
          fromArea=area,
        })
      end
      end
    room:moveCards(table.unpack(moveInfos))

  end,
})

-- kaaktszjer:addEffect(fk.AfterCardsMove, {--應該先占卜記錄是否至多
--   anim_type = "drawcard",
--   can_refresh = function(self, event, target, player, data)
--     -- if  event:setCostData(self) then return end
--     return player:hasSkill(kaaktszjer.name,true)  --有腳色hasSkill
--   end,
--   on_refresh = function(self, event, target, player, data)
--     local room=player.room
--     local tos= {}
--     if not event:getCostData(self) then

--         for _, move in ipairs(data) do
--           if (move.to and move.toArea ~= Card.PlayerSpecial) then
--             for _, info in ipairs(move.moveInfo) do
--                 tos[move.to.seat *4+ info.fromArea]=#move.to:getCardIds(move.toArea)
--             end
--           end
--         end
--     else
--       tos=event:getCostData(self).tos
--     end
--     local players=event:getCostData(self) and event:getCostData(self).players or {}
--     players[player.seat]={#player:getCardIds("h"), #player:getCardIds("e"), #player:getCardIds("j")}
--     event:setCostData(self,{players=players, tos=tos})
--   end,
--   can_trigger = function(self, event, target, player, data)
--     if player:hasSkill(kaaktszjer.name) then
--     local pt=event:getCostData(self).players[player.seat]
--     local tos=event:getCostData(self).tos
--     for i, n in pairs(tos) do
--       if n>pt[i%4] then
--         return true
--       end
--     end
--   end
--   end,
--   on_use = function(self, event, target, player, data)
--     local room=player.room
--     local pt=event:getCostData(self).players[player.seat]
--     local tos=event:getCostData(self).tos
--     for i, n in pairs(tos) do
--       local to =room:getPlayerBySeat(i//4)
--       for j=1,3,1 do
--         if  n>pt[i%4]  then
          
--           room:throwCard(to:getCardIds(j)[1], kaaktszjer.name, to, player)
--         end
--       end
--     end
--   end,
-- })



return kaaktszjer
