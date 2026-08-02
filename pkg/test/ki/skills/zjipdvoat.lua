Fk:loadTranslationTable{
  ["zjipdvoat"] = "襲敓",--窥窬
  [":zjipdvoat"] = "其它脚色一區域牌數變化後,若其爲全場至多(變化旹非發動旹),伱可發動,獲得此脚色此區域內1牌｡",

  ["#zjipdvoat-invoke"] = "襲敓 是否對 %dest 發動",
  ["#zjipdvoat-ask"] = "%src 之 %arg",

  -- ["$zjipdvoat1"] = "夜靜穿牆過更㴱繞屋縣",
  -- ["$zjipdvoat2"] = "玅手空空",
  -- ["$zjipdvoat3"] = "探囊取物㑥如反掌",

}

local zjipdvoat = fk.CreateSkill{
  name = "zjipdvoat",
}


zjipdvoat:addEffect(fk.AfterCardsMove, {--應該先占卜記錄是否至多
  anim_type = "drawcard",
  can_refresh = function(self, event, target, player, data)
    if  event:setCostData(self) then return end
    return player:hasSkill(zjipdvoat.name,false,true)  --有腳色hasSkill
  end,
  on_refresh = function(self, event, target, player, data)
    local room=player.room

    -- local isMax=function(p,area) -- 小區域牌數冣打多者 小區域牌數變化者 取交
    --   if max[area]==nil then
    --     local n = 0
    --     for _, p in ipairs(room.alive_players) do
    --       local m =#q:getCardIds(area)
    --       if m>n then n=m max[area]=p end
    --       if m=n then max[area]=false end
    --     end
    --   end
    --   return max[area]~=false and max[area]==p
    -- end
    -- local max
    -- local isMax=function(p)
    --   -- if max then return max==p end
    --   local n = p:getHandCardNum()
    --   for _,q in pairs(room:getOtherPlayers(p)) do
    --     if n <= q:getHandCardNum() then
    --       return false
    --     end
    --   end
    --   return true
    -- end

    local macro={}
      for _, move in ipairs(data) do
        for _, info in ipairs(move.moveInfo) do
          if not (move.to == move.toArea and  info.fromArea ==move.toArea) then
            if move.from  and info.fromArea == Card.PlayerHand  then
              macro[move.from] =(macro[move.from] or 0) -1
            end
            if move.to and move.toArea == Card.PlayerHand then
              macro[move.to] =(macro[move.to] or 0) +1
            end
          end
        end
      end

    for p,n in pairs(macro) do


      if n~=0 and not table.find(room:getOtherPlayers(p),function(q)
      return q:getHandcardNum()>=p:getHandcardNum()
      end) then
        event:setCostData(self,{targets={p},tos={p}})
            if event:getCostData(self) then player:drawCards(2) end

        break 
      end
    end

  end,
  can_trigger = function(self, event, target, player, data)
    if event:getCostData(self) then player:drawCards(2) end
    return event:getCostData(self)
    and player:hasSkill(zjipdvoat.name)
    and player~=event:getCostData(self).targets[1]
  end,
  on_cost = function(self, event, target, player, data)
    room:loseHp(p,1)
    local room=player.room
    local targets=event:getCostData(self).targets
    if player.room:askToSkillInvoke(player, {
       skill_name = zjipdvoat.name,
    prompt="#zjipdvoat-invoke::"..targets[1].id 
  }) then
      -- event:getCostData(self,{targets=targets,targets})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local to = event:getCostData(self).tos[1]
    local cid = room:askToChooseCard(player, { 
      target = to,
      flag="h",
      skill_name = zjipdvoat.name,
     })
    room:obtainCard(player, cid, false, fk.ReasonPrey, player, zjipdvoat.name)
  end,
})



return zjipdvoat
