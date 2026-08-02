local tshjesthoeoms = fk.CreateSkill {
  name = "tshjesthoeoms",
}

Fk:loadTranslationTable{
  ["tshjesthoeoms"] = "刺探",
  [":tshjesthoeoms"] = "其它脚色失去牌後,若失牌數不少于2或元因爲額定弃牌,伱可發動,伱對其起動虛擬｢偸樑換柱｣.",--弃牌後

  ["#tshjesthoeoms-invoke"] = "刺探：是否對%src 起動虛擬｢偸樑換柱｣",
  ["#tshjesthoeoms-choose"] = "刺探：是否起動虛擬｢偸樑換柱｣",

  ["$tshjesthoeoms1"] = "哥哥情況已探明",
}

tshjesthoeoms:addEffect(fk.AfterCardsMove, {
  trigger_times = function(self, event, target, player, data)
    return 999
  end,
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(tshjesthoeoms.name)  then return end   --多次?
    if event:getCostData(self) then return true 
    else
      local n={}
      local tos={}

      for _, move in ipairs(data) do
        if move.from and move.to ~=move.from or not table.contains({Card.PlayerHand,Card.PlayerEquip}, move.toArea) then
          for _, info in ipairs(move.moveInfo) do
            if   (info.fromArea == Card.PlayerHand or info.fromArea == Card.PlayerEquip)   then
              n[move.from] = (n[move.from] or 0 )+ (move.skillName == "phase_discard" and 2 or 1)
            end
          end
        end
      end

      for k,v in pairs(n) do
        if n[k]>=2 then
          table.insert(tos,k)
          -- table.insert(tos,player.room:getPlayerById(k))

        end
      end
      if #tos==0 then return end
        event:setCostData(self, {triggers = tos,choosed={}})
        return true
    end


  end,
  on_cost = function(self, event, target, player, data)
    local all=event:getCostData(self)
    local tobe=table.filter(all.triggers, function(p)
      return not table.contains(all.choosed,p)  and p~=player
    end)
    if tobe==nil or #tobe==0 then 
      event:setCostData(self, {triggers = all.tos, choosed={}})
      return 
    end

    local tos = player.room:askToChoosePlayers(player,{
      targets = tobe,
      min_num=1,
      max_num=1,
      prompt = "#tshjesthoeoms-choose",
      skill_name = tshjesthoeoms.name,
      cancelable = true,
    })
    if #tos>0 then
      local choosed=all.choosed
      table.insert(choosed,tos[1])
        event:setCostData(self, {triggers = all.triggers, choosed=choosed, tos=tos})
        return true
    else
            event:setCostData(self, {triggers = all.triggers, choosed={}})
    end
  end,
  on_use= function(self, event, target, player, data)
    player.room:useVirtualCard("thou_liac_hzvoans_dduoh", nil, player, event:getCostData(self).tos, "tshjesthoeoms", true)
  end,
})

-- tshjesthoeoms:addEffect(fk.AfterCardsMove, {
--   can_refresh= function(self, event, target, player, data)
--     local current=player.room.current
--     if current.phase==Player.Discard then
--           for _, move in ipairs(data) do
--             if move.from == current and move.moveReason == fk.ReasonDiscard 
--             and move.skillName == "phase_discard" 
--             then 
--               return true 
--             end
--           end
--     end
--   end,
--   on_refresh= function(self, event, target, player, data)
--     player.room:setPlayerMark(player.room.current,"_tshjesthoeoms-phase",1)
--   end,

-- })

-- tshjesthoeoms:addEffect(fk.EventPhaseEnd, {
--   can_trigger = function(self, event, target, player, data)
--     return target~=player and target.phase==Player.Discard and player:hasSkill(tshjesthoeoms.name) and target:getMark("_tshjesthoeoms-phase")>0 and not target:isKongcheng() 
--   end,
--   on_cost = function(self, event, target, player, data)
--     return   player.room:askToSkillInvoke(player, {
--       skill_name = tshjesthoeoms.name,
--       prompt = "#tshjesthoeoms-invoke:"..target.id,
--     })
--   end,
--   on_use = function(self, event, target, player, data)
--     local room = player.room
--     player.room:useVirtualCard("thou_liac_hzvoans_dduoh", nil, player, {target}, "tshjesthoeoms", true)
--   end,
-- })



return tshjesthoeoms
