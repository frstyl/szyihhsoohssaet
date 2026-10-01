local tssiohtsjins = fk.CreateSkill{
  name = "tssiohtsjins",
}

Fk:loadTranslationTable{
  ["tssiohtsjins"] = "阻進",  --折銳 deevhtszjens
  [":tssiohtsjins"] = "其它脚色A轉始伱,伱可發動.伱聲明1牌類B｡,A于1轉內下次聲明起動牌旹,若牌類与B:同,无效之;不同,,伱抽1,A于1轉內不可起動B類眞牌",
  -- [":tssiohtsjins"] = "轉脚色A起動牌後,伱可發動.伱聲明1牌類B｡1轉內,A下起動牌旹,若牌類与B:同,中止1轉(不中止結算);不同,其予伱1傷,1轉不可起動投出弃置B牌類",

  ["#tssiohtsjins-invoke"] = "阻進： %src 是否發動",
  ["@tssiohtsjins-turn"] = "阻進",
  ["@tssiohtsjins-prohibit-turn"] = "阻進",

  ["#tssiohtsjins-invoke"] = "%from 阻進聲明 %arg",
  -- ["#tssiohtsjins-same"] = "%from 阻進譣明 %tos 轉終",
  ["#tssiohtsjins-different"] = "%from 阻進譣僞 %tos 不可起動 %arg",

  ["$tssiohtsjins1"] = "吾已埋下伏兵，敌兵一来，管教他瓮中捉鳖。",
  ["$tssiohtsjins2"] = "我已设下重重圈套，就等敌军入彀矣。",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

-- tssiohtsjins:addEffect(fk.CardUseFinished, {
--   anim_type = "control",
--   can_refresh= function(self, event, target, player, data)
--     return player.seat==1 and target ==Fk:currentRoom():getCurrent() 
--   end,
--   on_refresh= function(self, event, target, player, data)
--     event:setCostData(self,{tos={Fk:currentRoom():getCurrent() }})
--   end,
--   can_trigger = function(self, event, target, player, data)
--     return  player:hasSkill(tssiohtsjins.name) and event:getCostData(self)
--     and player:usedEffectTimes(tssiohtsjins.name, Player.HistoryTurn) == 0
--   end,
--   on_cost = function (self, event, target, player, data)
--     local room = player.room
--     local to = event:getCostData(self).tos[1]
--     local choices={"action","trick","equip","goods" ,"magic","allusion"}  --S.
--     local choice = room:askToChoice(player, {
--       choices = choices,
--       skill_name = tssiohtsjins.name,
--       prompt = "#tssiohtsjins-choose",
--       prompt="#tssiohtsjins-invoke:"..to.id,
--       cancelable=true,
--     })
--     if choice~="Cancel" then
--       local t  =table.indexOf(choices,choice)
--       event:setCostData(self,{tos={to}, choice=t})
--       return true
--     end
--   end,
--   on_use = function (self, event, target, player, data)
--     local room = player.room
--     local dat = event:getCostData(self)
--     room:setPlayerMark(player, "@tssiohtsjins-turn",{dat.tos[1].id,dat.choice} )
--   end,
-- })

tssiohtsjins:addEffect(fk.TurnStart, {
  anim_type = "control",
  can_trigger= function(self, event, target, player, data)
    return player~=target and player:hasSkill(tssiohtsjins.name)
  end,

  on_cost = function (self, event, target, player, data)
    local room = player.room
    local to = event:getCostData(self).tos[1]
    local choices={"action","trick","equip","goods" ,"magic","allusion"}  --S.
    local choice = room:askToChoice(player, {
      choices = choices,
      skill_name = tssiohtsjins.name,
      prompt = "#tssiohtsjins-choose",
      prompt="#tssiohtsjins-invoke:"..to.id,
      cancelable=true,
    })
    if choice~="Cancel" then
      local t  =table.indexOf(choices,choice)
      event:setCostData(self,{tos={to}, choice=t,string=choice})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    local dat = event:getCostData(self)
    room:sendLog{
        type = "#tssiohtsjins-invoke",
        from = player.id,
        arg=dat.string
      }
    room:setPlayerMark(player, "@tssiohtsjins-turn",{dat.tos[1].id,dat.choice} )
  end,
})

tssiohtsjins:addEffect(fk.AfterCardUseDeclared, {-- --AfterCardUseDeclared
  anim_type = "control",
  -- is_dellay_effect=true,
  can_trigger = function(self, event, target, player, data)
    return  player:getMark("@tssiohtsjins-turn")~=0
    and player:getTableMark("@tssiohtsjins-turn")[1]  == data.from.id
  end,
  on_trigger = function (self, event, target, player, data)
    local room = player.room
    if player:getTableMark("@tssiohtsjins-turn")[2]  == S.getCardTypeByName(data.card.trueName) then
      -- room:sendLog{
      --   type = "#tssiohtsjins-same",
      --   from = player.id,
      --   tos = {target.id},
      -- }
      S.useNullify(data,player,tssiohtsjins.name)

      -- player.room.logic:breakTurn()
      -- room:endTurn()
    else
    local choices={"action","trick","equip","goods" ,"magic","allusion"}  --S.
      room:sendLog{
        type = "#tssiohtsjins-different",
        from = player.id,
        tos = {target.id},
        arg=t[player:getTableMark("@tssiohtsjins-turn")[2]],
      }
      if not player.dead then
      player:drawCards(1, tssiohtsjins.name)
      end
      --  if not player.dead and not target.dead then
        -- room:damage({
        --   from = target,
        --   to = player,
        --   -- card = effect.card,
        --   damage = 1,
        --   damageType = 1,
        --   skillName = tssiohtsjins.name,
        -- })
      -- end
      room:addTableMarkIfNeed(target, "@tssiohtsjins-prohibit-turn",player:getTableMark("@tssiohtsjins-turn")[2] )
    end

  end,
  late_refresh=true,
  can_refresh= function(self, event, target, player, data)
    return player:getMark("@tssiohtsjins-turn")~=0
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:setPlayerMark(player, "@tssiohtsjins-prohibit-turn",nil )
  end,
})

tssiohtsjins:addEffect("prohibit", {
  prohibit_use = function(self, player, card)
    if player:getMark("@tssiohtsjins-prohibit-turn")==0 then return end
    -- if table.contains(player:getTableMark("@tssiohtsjins-prohibit-turn"), S.getCardTypeByName(card.trueName)) then
    -- return true
    -- end
    if not card:isVirtual() and table.contains(player:getTableMark("@tssiohtsjins-prohibit-turn"), S.getCardTypeByName(card.trueName)) then
      return true
    end
    if card:isConverted() then
      for _,id in ipairs(card.subcards) do

        if table.contains(player:getTableMark("@tssiohtsjins-prohibit-turn"), S.getCardTypeByName(Fk:getCardById(id).trueName)) then
          return true
        end
      end
    end
  end,
  -- prohibit_response = function(self, player, card)
  --   if player:getMark("@tssiohtsjins-prohibit-turn")==0 then return end
  --   if table.contains(player:getTableMark("@tssiohtsjins-prohibit-turn"), S.getCardTypeByName(card.trueName)) then
  --   return true
  --   end
  --   if card:isVirtual() then
  --     for _,id in ipairs(card.subcards) do

  --       if table.contains(player:getTableMark("@tssiohtsjins-prohibit-turn"), S.getCardTypeByName(Fk:getCardById(id).trueName)) then
  --         return true
  --       end
  --     end
  --   end
  -- end,
  -- prohibit_discard = function(self, player, card)
  --   if player:getMark("@tssiohtsjins-prohibit-turn")==0 then return end
  --   if table.contains(player:getTableMark("@tssiohtsjins-prohibit-turn"), S.getCardTypeByName(card.trueName)) then
  --   return true
  --   end
  --   if card:isVirtual() then
  --     for _,id in ipairs(card.subcards) do

  --       if table.contains(player:getTableMark("@tssiohtsjins-prohibit-turn"), S.getCardTypeByName(Fk:getCardById(id).trueName)) then
  --         return true
  --       end
  --     end
  --   end
  -- end,
})


return tssiohtsjins
