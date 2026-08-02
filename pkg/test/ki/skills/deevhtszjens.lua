local deevhtszjens = fk.CreateSkill{
  name = "deevhtszjens",
}

Fk:loadTranslationTable{
  ["deevhtszjens"] = "誂戰",  --搦戰
  [":deevhtszjens"] = "轉脚色A起動牌後,伱可發動.伱聲明{傷害/非傷害}牌｡A下次起動牌旹,若与伱所聲明同:,{伱抽1/中止當轉(不中止結算)};不同,其不可起動打出{傷害/非傷害}牌至其下轉始",

  ["#deevhtszjens-invoke"] = "誂戰： 是否對 %src 發動  ",
  ["@deevhtszjens-showed-turn"] = "誂戰",
  ["deevhtszjens-hiden-turn"] = "誂戰",
  ["@deevhtszjens-prohibit"] = "誂戰",

  ["damageCard"] = "傷害牌",
  ["nonDamageCard"] = "非傷害牌",

  ["#deevhtszjens-trigger"] = "%from 誂戰聲明 %arg",
  ["#turn-end"] = "因 %arg 效果, %from 轉終",
  -- ["#deevhtszjens-different"] = "%from 誂戰譣僞 %tos 不可起動 %arg",

  ["$deevhtszjens1"] = "吾已埋下伏兵，敌兵一来，管教他瓮中捉鳖。",
  ["$deevhtszjens2"] = "我已设下重重圈套，就等敌军入彀矣。",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

local spec={
  anim_type = "control",
  can_refresh= function(self, event, target, player, data)
    return player.seat==1 and target ==Fk:currentRoom():getCurrent() 
  end,
  on_refresh= function(self, event, target, player, data)
    event:setCostData(self,{tos={Fk:currentRoom():getCurrent() }})
  end,
  can_trigger = function(self, event, target, player, data)
    return  target~=player and player:hasSkill(deevhtszjens.name)
    and event:getCostData(self)
    and not target.dead
    -- and player:usedEffectTimes(deevhtszjens.name, Player.HistoryTurn) == 0
  end,
  on_cost = function (self, event, target, player, data)
    local room = player.room
    local to = event:getCostData(self).tos[1]
    local choices={"damageCard","nonDamageCard", "Cancel"}  --S.
    local choice = room:askToChoice(player, {
      choices = choices,
      skill_name = deevhtszjens.name,
      prompt = "#deevhtszjens-choose",
      prompt="#deevhtszjens-invoke:"..to.id,
      cancelable=true,
    })
    if choice~="Cancel" then
      -- local t  =table.indexOf(choices,choice)
      event:setCostData(self,{tos={to}, choice=choice})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    local dat = event:getCostData(self)
    room:sendLog{
      type = "#deevhtszjens-trigger",
      from = player.id,
      -- tos = {target.id},
      arg=dat.choice,
    }
    room:setPlayerMark(player, "@deevhtszjens-showed-turn",{dat.tos[1].general, dat.choice} )
    room:setPlayerMark(player, "deevhtszjens-hiden-turn",{dat.tos[1].id, dat.choice=="damageCard" and true or false} )
  end,
}
deevhtszjens:addEffect(fk.TurnStart,  spec)
deevhtszjens:addEffect(fk.CardUseFinished, spec)

deevhtszjens:addEffect(fk.CardUsing, {-- --AfterCardUseDeclared
  anim_type = "control",
  -- is_dellay_effect=true,
  can_trigger = function(self, event, target, player, data)
    return  player:getMark("deevhtszjens-hiden-turn")~=0
    and player:getTableMark("deevhtszjens-hiden-turn")[1]  == target.id
  end,
  on_trigger = function (self, event, target, player, data)
    local room = player.room
    local log = player:getTableMark("@deevhtszjens-showed-turn")[2]
    local choice= player:getTableMark("deevhtszjens-hiden-turn")[2]
    room:setPlayerMark(player, "@deevhtszjens-showed-turn",0 )
    room:setPlayerMark(player, "@deevhtszjens-hiden-turn",0 )
    if choice and data.card.is_damage_card  then
        if  not player.dead then
        player:drawCards(1,deevhtszjens.name)
        end
      return
    end
    if not choice and not data.card.is_damage_card  then
    room:sendLog{
        type = "#turn-end",
        from = target.id,
        -- tos = {target.id},
        arg=deevhtszjens.name,
      }
          room:endTurn()
      return
    end

    room:addTableMarkIfNeed(target, "@deevhtszjens-prohibit",log )

  end,
})

deevhtszjens:addEffect(fk.TurnStart, {
  can_refresh = function (self, event, target, player, data)
    return target == player and player:getMark("@deevhtszjens-prohibit") ~= 0
  end,
  on_refresh = function (self, event, target, player, data)
    player.room:setPlayerMark(player, "@deevhtszjens-prohibit", 0)
  end,
})

deevhtszjens:addEffect("prohibit", {
  prohibit_use = function(self, player, card)
    if player:getMark("@deevhtszjens-prohibit")==0 or not card then return end
    if table.contains(player:getTableMark("@deevhtszjens-prohibit"), card.is_damage_card and "damageCard" or "nonDamageCard") then
    return true
    end
    if card:isVirtual() then
      for _,id in ipairs(card.subcards) do

        if table.contains(player:getTableMark("@deevhtszjens-prohibit"), Fk:getCardById(id).is_damage_card and "damageCard" or "nonDamageCard") then
          return true
        end
      end
    end
  end,
  prohibit_response = function(self, player, card)
    if player:getMark("@deevhtszjens-prohibit")==0 or not card then return end
    if table.contains(player:getTableMark("@deevhtszjens-prohibit"), card.is_damage_card and "damageCard" or "nonDamageCard") then
    return true
    end
    if card:isVirtual() then
      for _,id in ipairs(card.subcards) do

        if table.contains(player:getTableMark("@deevhtszjens-prohibit"), Fk:getCardById(id).is_damage_card and "damageCard" or "nonDamageCard") then
          return true
        end
      end
    end
  end,
  prohibit_discard = function(self, player, card)
    if player:getMark("@deevhtszjens-prohibit")==0 or not card then return end
    if table.contains(player:getTableMark("@deevhtszjens-prohibit"), card.is_damage_card and "damageCard" or "nonDamageCard") then
    return true
    end
    if card:isVirtual() then
      for _,id in ipairs(card.subcards) do

        if table.contains(player:getTableMark("@deevhtszjens-prohibit"), Fk:getCardById(id).is_damage_card and "damageCard" or "nonDamageCard") then
          return true
        end
      end
    end
  end,
})


return deevhtszjens
