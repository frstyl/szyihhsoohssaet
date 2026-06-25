local hsfaqdeen = fk.CreateSkill {
  name = "hsfaqdeen",
}

Fk:loadTranslationTable{  --分爲4?
["hsfaqdeen"] = "花田",--1/4花田
[":hsfaqdeen"] = "當伱{受傷/回復體力}後,至多{傷害值/回復值}次,伱可指定1其他角色發動,伱{令其回1,未損則与伱各抽2/予其1傷}.",

["#hsfaqdeen-choose"]="花田 選擇1角色",
["#hsfaqdeen-recover"]="花田 選擇1角色回1",
["#hsfaqdeen-damage"]="花田 選擇1角色傷其1",
-- ["#hsfaqdeen-drawcard"]="花田 選擇1角色 其抽1",
-- ["#hsfaqdeen-discard"]="花田 選擇1角色 其弃1",
}

hsfaqdeen:addEffect(fk.HpRecover, {
  anim_type = "offensive",
  -- trigger_times = function(self, event, target, player, data)
  --   return data.num
  -- end,
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(hsfaqdeen.name)
  end,
  trigger_times = function(self, event, target, player, data)
    return data.num
  end,
  on_cost = function(self, event, target, player, data)
    local room=  player.room
    local to = room:askToChoosePlayers(player,{
      targets = room:getOtherPlayers(player, false),
      min_num=1,
      max_num=1,
      prompt = "#hsfaqdeen-damage",
      skill_name = hsfaqdeen.name,
      cancelable = true,
    })
    if #to>0 then 
      event:setCostData(self,{tos=to})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room= player.room
    local to = event:getCostData(self).tos[1]
    room:damage{
      from = player,
      to = to,
      damage = 1,
      -- damageType = fk.NormalDamage,
      skillName = hsfaqdeen.name,
    }
  end,
})

hsfaqdeen:addEffect(fk.Damaged, {
  anim_type = "support",
  -- trigger_times = function(self, event, target, player, data)
  --   return data.num
  -- end,
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(hsfaqdeen.name)
  end,
  trigger_times = function(self, event, target, player, data)
    return data.damage
  end,
  on_cost = function(self, event, target, player, data)
    local room=  player.room
    local to = room:askToChoosePlayers(player,{
      targets = room:getOtherPlayers(player, false),
      min_num=1,
      max_num=1,
      prompt = "#hsfaqdeen-recover",
      skill_name = hsfaqdeen.name,
      cancelable = true,
    })
    if #to>0 then 
      event:setCostData(self,{tos=to})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room= player.room
    local to = event:getCostData(self).tos[1]
    if to:isWounded() then
    room:recover({
      who = to,
      num = 1,
      recoverBy = from,
      skillName = hsfaqdeen.name,
    })
    else
      to:drawCards(2,hsfaqdeen.name)
      if not player.dead then player:drawCards(2) end
    end
  end,
})


-- hsfaqdeen:addEffect(fk.AfterCardsMove, {
--   anim_type = "drawcard",
--   can_trigger = function(self, event, target, player, data)
--     return player:hasSkill(hsfaqdeen.name) 
--   end,
--   trigger_times = function(self, event, target, player, data)
--     if event:getCostData(self) and event:getCostData(self).n then  
--       return  event:getCostData(self).n 
--     end


--     local lose=0
--     local get=0
--     for _, move in ipairs(data) do
--       if move.from and move.from == player and move.moveReason==fk.ReasonDiscard then
--         for _, info in ipairs(move.moveInfo) do
--           if info.fromArea == Card.PlayerHand or info.fromArea == Card.PlayerEquip then
--             lose= lose+1
--           end
--         end
--       elseif move.to and move.to == player  and move.moveReason==fk.ReasonDraw then 
--         for _, info in ipairs(move.moveInfo) do
--           -- if info.fromArea == Card.Pile then
--              get= get+1
--           -- end
--         end
--       end

--     end
--     local drawN= lose//2
--     local discardN=get//2
--     local n=drawN+discardN
--     event:setCostData(self, {n=n,  drawN =drawN , discardN=discardN, tos={}, choose=""})
--     return n
--   end,

--   on_cost = function(self, event, target, player, data)
--     local room=  player.room
--     local dat=event:getCostData(self)
--     if dat.drawN>0 then
--       if dat.discardN>0 then
--        dat.choose = room:askToChoice(player, {
--           choices = {"drawcard","discard"},
--           skill_name = khiochhsaas.name,
--           prompt = "#hsfaqdeen-choose",
--         })
--       else
--         dat.choose="drawcard"
--       end
--     elseif dat.discardN>0 then
--       dat.choose="discard"
--     else 

--       return false 
--     end


--     local to = room:askToChoosePlayers(player,{
--       targets = room:getOtherPlayers(player, false),
--       min_num=1,
--       max_num=1,
--       prompt = "#hsfaqdeen-"..dat.choose,
--       skill_name = hsfaqdeen.name,
--       cancelable = true,
--     })
--     if #to>0 then 
--       dat.tos=to
--       if dat.choose=="drawcard" then
--         dat.drawN=dat.drawN-1
--       else 
--         dat.discardN=dat.discardN-1
--       end
--       event:setCostData(self,dat)
--       return true
--     else 
--           self.cancel_cost = false
--                   -- dat.drawN=0
--                   -- dat.discardN=0
--     end

--   end,
--   on_use = function(self, event, target, player, data)
--     local room=player.room
--     local to = event:getCostData(self).tos[1]
--     if  event:getCostData(self).choose=="discard" then
--       room:askToDiscard(to, {
--         min_num = 1,
--         max_num = 1,
--         include_equip = true,
--         skill_name = hsfaqdeen.name,
--         cancelable = false,
--         prompt = "#hsfaqdeen-discard",
--         skip = false,
--       })
--     else 
--       to:drawCards(1, hsfaqdeen.name)
--     end
--   end,
-- })



return hsfaqdeen
