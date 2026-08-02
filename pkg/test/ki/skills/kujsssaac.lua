local kujsssaac = fk.CreateSkill {
  name = "kujsssaac",
}

Fk:loadTranslationTable{
  ["kujsssaac"] = "貴生",  --䘙生 養生
  [":kujsssaac"] = "每轉每項限1.當一脚色{進入瀕死旹/失去全部手牌後/失去全部裝僃區牌後},伱可發動.令其抽1", --脚色限1 --冣後體力?

  ["#kujsssaac-invoke"] = "貴生  令 %src 抽1",

  ["$kujsssaac1"] = "兵精將猛山川險峻獨霸一方",
  ["$kujsssaac2"] = "貴生五十六縣皆爲我土",
}



local spec={
  on_cost = function(self, event, target, player, data)
    local to =event:getCostData(self).tos[1]
    if player.room:askToSkillInvoke(player, {
          skill_name = kujsssaac.name,
          prompt = "#kujsssaac-invoke:"..to.id,
        }) then
          -- event:setCostData(self,{tos={to}})
          return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local to = event:getCostData(self).tos[1]
    if to.dead then return end
    to:drawCards(1, kujsssaac.name)
  end,
}

kujsssaac:addEffect(fk.EnterDying, {
  anim_type = "masochism",
  can_trigger = function (self, event, target, player, data)
    if  not player:hasSkill(kujsssaac.name) or player:usedEffectTimes(self.name, Player.HistoryTurn)~=0 then return end
        event:setCostData(self, {tos = {target}})
        self:doCost(event, target, player, data)
    
  end,
  on_cost = spec.on_cost,
  on_use = spec.on_use,
})



kujsssaac:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not  player:hasSkill(kujsssaac.name) or player:usedEffectTimes(self.name, Player.HistoryTurn)~=0 then return end

    local tos = {}
      for _, move in ipairs(data) do
        if move.from ~=nil and  #move.from:getCardIds("e")==0  then
          if table.find(move.moveInfo,function(info)
            return 
             (info.fromArea == Card.PlayerEquip  )
          end)
          then
              table.insert(tos,move.from)

          end


        end
      end
    if #tos==0 then return end

    --tos = player.room:askToChoosePlayers(player, {
    --       targets = tos,
    --       min_num = 1,
    --       max_num = 999,
    --       prompt = "#kujsssaac-choose",
    --       skill_name = kujsssaac.name,
    --       cancelable = true,
    --     })
    -- if #to==0 then return end
    player.room:sortByAction(tos)
    for _,p in ipairs(tos) do
      if not player:hasSkill(kujsssaac.name) then break end
      if not p.dead then
        event:setCostData(self, {tos = {p}})
        -- self:use(event, target, player, data)
        self:doCost(event, target, player, data)
      end
    end
  end,
  on_cost=spec.on_cost,
  on_use=spec.on_use,
})

kujsssaac:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not  player:hasSkill(kujsssaac.name) or player:usedEffectTimes(self.name, Player.HistoryTurn)~=0 then return end

    local tos = {}
      for _, move in ipairs(data) do
        if move.from ~=nil and #move.from:getCardIds("h")==0 then
          if table.find(move.moveInfo,function(info)
            return 
            (info.fromArea == Card.PlayerHand   )
          end)
          then
              table.insert(tos,move.from)

          end


        end
      end
    if #tos==0 then return end
    --tos = player.room:askToChoosePlayers(player, {
    --       targets = tos,
    --       min_num = 1,
    --       max_num = 999,
    --       prompt = "#kujsssaac-choose",
    --       skill_name = kujsssaac.name,
    --       cancelable = true,
    --     })
    -- if #to==0 then return end
    player.room:sortByAction(tos)
    for _,p in ipairs(tos) do
      if not player:hasSkill(kujsssaac.name) then break end
      if not p.dead then
        event:setCostData(self, {tos = {p}})
        -- self:use(event, target, player, data)
        self:doCost(event, target, player, data)
      end
    end
  end,
  on_cost=spec.on_cost,
  on_use=spec.on_use,
})


-- kujsssaac:addEffect(fk.AfterCardsMove, {
--   anim_type = "drawcard",
--   can_trigger = function(self, event, target, player, data)
--     if not  player:hasSkill(kujsssaac.name) then return end

--     local tos = {}
--       for _, move in ipairs(data) do
--         if move.from ~=nil  then
--           if table.find(move.moveInfo,function(info)
--             return 
--             (info.fromArea == Card.PlayerHand and #move.from:getCardIds("h")==0 )
--             or (info.fromArea == Card.PlayerEquip and  #move.from:getCardIds("e")==0 )
--           end)
--           then
--               table.insert(tos,move.from)

--           end


--         end
--       end
--     if #tos==0 then return end
--     --tos = player.room:askToChoosePlayers(player, {
--     --       targets = tos,
--     --       min_num = 1,
--     --       max_num = 999,
--     --       prompt = "#kujsssaac-choose",
--     --       skill_name = kujsssaac.name,
--     --       cancelable = true,
--     --     })
--     -- if #to==0 then return end
--     player.room:sortByAction(tos)
--     for _,p in ipairs(tos) do
--       if not player:hasSkill(kujsssaac.name) then break end
--       if not p.dead then
--         event:setCostData(self, {tos = {p}})
--         -- self:use(event, target, player, data)
--         self:doCost(event, target, player, data)
--       end
--     end
--   end,
--   on_cost=spec.on_cost,
--   on_use=spec.on_use,
-- })
return kujsssaac
