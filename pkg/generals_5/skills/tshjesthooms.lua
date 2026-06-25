local tshjesthooms = fk.CreateSkill {
  name = "tshjesthooms",
}

Fk:loadTranslationTable{
  ["tshjesthooms"] = "刺探",
  [":tshjesthooms"] = "其它角色失去牌後,若失牌數不少于2或元因爲額定弃牌,伱可發動,視爲對其使用偸樑換柱.",--弃牌後

  ["#tshjesthooms-invoke"] = "刺探：是否對%src 虛擬使用｢偸樑換柱｣",
  ["#tshjesthooms-choose"] = "刺探：是否虛擬使用｢偸樑換柱｣",

  ["$tshjesthooms1"] = "哥哥情況已探明",
}

tshjesthooms:addEffect(fk.AfterCardsMove, {
  trigger_times = function(self, event, target, player, data)
    return 999
  end,
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(tshjesthooms.name)  then return end   --多次?
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
      prompt = "#tshjesthooms-choose",
      skill_name = tshjesthooms.name,
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
    player.room:useVirtualCard("thou_liac_hzvoans_dduoh", nil, player, event:getCostData(self).tos, "tshjesthooms", true)
  end,
})

-- tshjesthooms:addEffect(fk.AfterCardsMove, {
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
--     player.room:setPlayerMark(player.room.current,"_tshjesthooms-phase",1)
--   end,

-- })

-- tshjesthooms:addEffect(fk.EventPhaseEnd, {
--   can_trigger = function(self, event, target, player, data)
--     return target~=player and target.phase==Player.Discard and player:hasSkill(tshjesthooms.name) and target:getMark("_tshjesthooms-phase")>0 and not target:isKongcheng() 
--   end,
--   on_cost = function(self, event, target, player, data)
--     return   player.room:askToSkillInvoke(player, {
--       skill_name = tshjesthooms.name,
--       prompt = "#tshjesthooms-invoke:"..target.id,
--     })
--   end,
--   on_use = function(self, event, target, player, data)
--     local room = player.room
--     player.room:useVirtualCard("thou_liac_hzvoans_dduoh", nil, player, {target}, "tshjesthooms", true)
--   end,
-- })



return tshjesthooms
