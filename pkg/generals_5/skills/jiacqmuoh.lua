
local jiacqmuoh = fk.CreateSkill{
  name = "jiacqmuoh",
}

Fk:loadTranslationTable{
["jiacqmuoh"] = "揚武",
[":jiacqmuoh"] = "伱使用殺旹可發動.伱選擇1至2項發動｡令此殺➀結算後伱得到之➁不計入次數➂致傷旹傷害值+1,伱弃置1牌➃反抵消反失效｡若伱選擇相鄰二項,伱于結算後流失1體力",  --全部牌當閃

["#jiacqmuoh-invoke"] = "揚武 選擇1至2項發動",

["jiacqmuoh-get"] = "得到此殺",
["jiacqmuoh-times"] = "不計次數",
["jiacqmuoh-damage"] = "傷害+1",
["jiacqmuoh-uncancel"] = "反抵消反失效",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

jiacqmuoh:addEffect(fk.CardUsing, {----TargetSpecified
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(jiacqmuoh.name) and data.card.trueName=="ssaet"
  end,
  on_cost = function(self, event, target, player, data)
    local choices={"jiacqmuoh-get","jiacqmuoh-times","jiacqmuoh-damage","jiacqmuoh-uncancel"}
    local result = player.room:askToChoices(player, {
      choices = choices,
      min_num = 1,
      max_num = 2,
      skill_name = jiacqmuoh.name,
      cancelable = true,
      prompt="jiacqmuoh-invoke",
    })
    if #result>0 then
      local adjacent=false
      if result[2] and math.abs(table.indexOf(choices, result[2]) - table.indexOf(choices, result[1]))==1 then 
        adjacent=true
      end
      event:setCostData(self,{choices=result,adjacent=adjacent})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local choices=event:getCostData(self).choices
    data.extra_data=data.extra_data or {}
    data.extra_data.jiacqmuoh={}
    data.extra_data.jiacqmuoh.choices=choices
    data.extra_data.jiacqmuoh.from=player.id
    if event:getCostData(self).adjacent then 
      data.extra_data.jiacqmuoh.adjacent=true
    end
    for _, choice in ipairs(choices) do
      if choice=="jiacqmuoh-times" then
        if not data.extraUse then
          player:addCardUseHistory(data.card.trueName, -1)
          data.extraUse = true
        end
      elseif choice=="jiacqmuoh-uncancel"  then
        data.extra_data.antiNullify=true
        data.extra_data.antiCancel=true
      elseif  choice=="jiacqmuoh-get" then
        data.extra_data.jiacqmuoh.get=true
      elseif  choice=="jiacqmuoh-damage"  then
        data.extra_data.jiacqmuoh.damage=true
      end
      
    end

  end,
})



jiacqmuoh:addEffect(fk.CardUseFinished, {
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    return     data.extra_data 
    and data.extra_data.jiacqmuoh 
    and player.id ==data.extra_data.jiacqmuoh.from
    -- and data.extra_data.jiacqmuoh.get
    -- and player.room:getCardArea(data.card) == Card.Processing
  end,
  on_trigger = function(self, event, target, player, data)
    if player.dead then return end
    local room=player.room
    if   data.extra_data.jiacqmuoh.get and player.room:getCardArea(data.card) == Card.Processing then
    player.room:obtainCard(player, data.card, true, fk.ReasonJustMove, player, jiacqmuoh.name)
    end
    if data.extra_data.jiacqmuoh.adjacent then
      room:loseHp(player,1,jiacqmuoh.name)
    end

  end,
})

jiacqmuoh:addEffect(fk.DamageCaused, {  --不算發動技能
  is_delay_effect = true,
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    if target==player and player.room.logic:damageByCardEffect() then  --目幖
      local use_event = player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true) --插入?? .parent
      if use_event then
        local use = use_event.data
        if use.extra_data and use.extra_data.jiacqmuoh  
            and use.extra_data.jiacqmuoh.damage
            and use.card==data.card  --useId
            then
              event:setCostData(self,{from=player.room:getPlayerById(use.extra_data.jiacqmuoh.from)})
              return true
            end
      end
    end
  end,
  on_trigger = function(self, event, target, player, data)
    S.changeDamage({damageData=data, num=1,skillName=jiacqmuoh.name})
    player.room:askToDiscard(event:getCostData(self).from, {
      min_num = 1,
      max_num = 1,
      include_equip = true,
      skill_name = jiacqmuoh.name,
      prompt = "#jiacqmuoh-invoke",
      cancelable = false,
      skip = false,
    })
  end,
})


return jiacqmuoh
