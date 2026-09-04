local kijqcian = fk.CreateSkill{
  name = "kijqcian",
}

Fk:loadTranslationTable{
  ["kijqcian"] = "譏言",
  [":kijqcian"] = "轉脚色A起動牌後,伱可發動.伱聲明1牌類B｡A下次起動牌旹,若牌類与B:同,中止1轉(不中止結算);不同,其予伱1傷,1轉不可起動打出弃置B牌類",

  ["#kijqcian-invoke"] = "譏言： %src 是否發動",
  ["@kijqcian-turn"] = "譏言",
  ["@kijqcian-prohibit-turn"] = "譏言",

  ["#kijqcian-same"] = "%from 譏言譣明 %tos 轉終",
  ["#kijqcian-different"] = "%from 譏言譣僞 %tos 不可起動 %arg",

  ["$kijqcian1"] = "吾已埋下伏兵，敌兵一来，管教他瓮中捉鳖。",
  ["$kijqcian2"] = "我已设下重重圈套，就等敌军入彀矣。",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

kijqcian:addEffect(fk.CardUseFinished, {
  anim_type = "control",
  can_refresh= function(self, event, target, player, data)
    return player.seat==1 and target ==Fk:currentRoom():getCurrent() 
  end,
  on_refresh= function(self, event, target, player, data)
    event:setCostData(self,{tos={Fk:currentRoom():getCurrent() }})
  end,
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(kijqcian.name) and event:getCostData(self)
    and player:usedEffectTimes(kijqcian.name, Player.HistoryTurn) == 0
  end,
  on_cost = function (self, event, target, player, data)
    local room = player.room
    local to = event:getCostData(self).tos[1]
    local choices={"action","trick","equip","goods" ,"magic","allusion"}  --S.
    local choice = room:askToChoice(player, {
      choices = choices,
      skill_name = kijqcian.name,
      prompt = "#kijqcian-choose",
      prompt="#kijqcian-invoke:"..to.id,
      cancelable=true,
    })
    if choice~="Cancel" then
      local t  =table.indexOf(choices,choice)
      event:setCostData(self,{tos={to}, choice=t})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    local dat = event:getCostData(self)
    room:setPlayerMark(player, "@kijqcian-turn",{dat.tos[1].id,dat.choice} )
  end,
})

kijqcian:addEffect(fk.CardUsing, {-- --AfterCardUseDeclared
  anim_type = "control",
  -- is_dellay_effect=true,
  can_trigger = function(self, event, target, player, data)
    return  player:getMark("@kijqcian-turn")~=0
    and player:getTableMark("@kijqcian-turn")[1]  == target.id
  end,
  on_trigger = function (self, event, target, player, data)
    local room = player.room
    if player:getTableMark("@kijqcian-turn")[2]  == S.getCardTypeByName(data.card.trueName) then
      room:sendLog{
        type = "#kijqcian-same",
        from = player.id,
        tos = {target.id},
      }
      -- player:drawCards(1, kijqcian.name)
      -- player.room.logic:breakTurn()
      room:endTurn()
    else
    local choices={"action","trick","equip","goods" ,"magic","allusion"}  --S.
      room:sendLog{
        type = "#kijqcian-different",
        from = player.id,
        tos = {target.id},
        arg=t[player:getTableMark("@kijqcian-turn")[2]],
      }
       if not player.dead and not target.dead then
        room:damage({
          from = target,
          to = player,
          -- card = effect.card,
          damage = 1,
          damageType = 1,
          skillName = kijqcian.name,
        })
      end
      room:addTableMarkIfNeed(target, "@kijqcian-prohibit-turn",player:getTableMark("@kijqcian-turn")[2] )
    end

  end,
})

kijqcian:addEffect("prohibit", {
  prohibit_use = function(self, player, card)
    if player:getMark("@kijqcian-prohibit-turn")==0 then return end
    if table.contains(player:getTableMark("@kijqcian-prohibit-turn"), S.getCardTypeByName(card.trueName)) then
    return true
    end
    if card:isVirtual() then
      for _,id in ipairs(card.subcards) do

        if table.contains(player:getTableMark("@kijqcian-prohibit-turn"), S.getCardTypeByName(Fk:getCardById(id).trueName)) then
          return true
        end
      end
    end
  end,
  prohibit_response = function(self, player, card)
    if player:getMark("@kijqcian-prohibit-turn")==0 then return end
    if table.contains(player:getTableMark("@kijqcian-prohibit-turn"), S.getCardTypeByName(card.trueName)) then
    return true
    end
    if card:isVirtual() then
      for _,id in ipairs(card.subcards) do

        if table.contains(player:getTableMark("@kijqcian-prohibit-turn"), S.getCardTypeByName(Fk:getCardById(id).trueName)) then
          return true
        end
      end
    end
  end,
  prohibit_discard = function(self, player, card)
    if player:getMark("@kijqcian-prohibit-turn")==0 then return end
    if table.contains(player:getTableMark("@kijqcian-prohibit-turn"), S.getCardTypeByName(card.trueName)) then
    return true
    end
    if card:isVirtual() then
      for _,id in ipairs(card.subcards) do

        if table.contains(player:getTableMark("@kijqcian-prohibit-turn"), S.getCardTypeByName(Fk:getCardById(id).trueName)) then
          return true
        end
      end
    end
  end,
})


return kijqcian
