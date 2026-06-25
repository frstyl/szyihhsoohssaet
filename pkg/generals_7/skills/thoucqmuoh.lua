local thoucqmuoh = fk.CreateSkill {
  name = "thoucqmuoh",
}

Fk:loadTranslationTable{
["thoucqmuoh"] = "通武",
[":thoucqmuoh"] = "伱使用殺指定目幖後,伱隱祕選1項發動.此殺{➀被｢閃｣抵消旹/➁對目幖致傷旹},伱抽1,肰後伱可{令一角色獲得此閃/弃置目幖1牌}",

["#thoucqmuoh-choose"] = "通武 選擇",
["#thoucqmuoh-szjemh"] = "獲得閃",
["#thoucqmuoh-szjemh-choose"] = "通武 選擇一角色獲得此閃",
["#thoucqmuoh-damage"] = "弃牌",
["#thoucqmuoh-damage-ask"] = "通武 是否弃 %src 牌",
}

thoucqmuoh:addEffect(fk.TargetSpecified, {
  can_trigger = function(self, event, target, player, data)
    return target == player and  player:hasSkill(thoucqmuoh.name) 
    and data.card.trueName == "ssaet" 
  end,
  on_cost = function(self, event, target, player, data)
    local choice = player.room:askToChoice(player, {
      choices = {"#thoucqmuoh-szjemh","#thoucqmuoh-damage","Cancel"},
      skill_name = thoucqmuoh.name,
      prompt = "#thoucqmuoh-choose",
    })
    if choice~="Cancel" then  
    event:setCostData(self,{choose=choice,tos={data.to}})
    return true
    end
  end,
  on_use = function(self, event, target, player, data)
    -- data.extra_data=data.extra_data or {}
    data.currentExtraData = data.currentExtraData or {}
    data.currentExtraData.thoucqmuoh={
      from=player.id,
      choose=event:getCostData(self).choose,
      -- tos=data.tos,
  }
  end,
})

thoucqmuoh:addEffect(fk.CardEffectCancelledOut, {  --不算發動技能
  is_delay_effect = true,
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return  data.cardsResponded[#data.cardsResponded].trueName=="szjemh" 
    and data.currentExtraData and data.currentExtraData.thoucqmuoh
    and data.currentExtraData.thoucqmuoh.choose=="#thoucqmuoh-szjemh"
    and data.currentExtraData.thoucqmuoh.from==player.id
  end,
  on_use = function(self, event, target, player, data)
    player:drawCards(1, thoucqmuoh.name)
    if   player.dead then return    end
    local to = player.room:askToChoosePlayers(player,{
      min_num = 1,
      max_num = 1,
      targets = player.room.alive_players,
      skill_name = thoucqmuoh.name,
      prompt = "#thoucqmuoh-szjemh-choose",
      cancelable = true,
    })
    if #to~=0 and (not to[1].dead ) and  player.room:getCardArea(data.cardsResponded) == Card.DiscardPile then
      player.room:obtainCard(to[1], data.cardsResponded, true, fk.ReasonJustMove, player, thoucqmuoh.name)
    end

  end,
})

thoucqmuoh:addEffect(fk.DamageCaused, {
  is_delay_effect = true,
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)

    if not player.dead and  player.room.logic:damageByCardEffect()  then
      local use_event = player.room.logic:getCurrentEvent():findParent(GameEvent.CardEffect, true)
      if use_event then
        local use = use_event.data
        return use.currentExtraData and use.currentExtraData.thoucqmuoh
            and use.currentExtraData.thoucqmuoh.choose=="#thoucqmuoh-damage"
            and use.currentExtraData.thoucqmuoh.from==player.id
            -- and table.contains(use.extra_data.thoucqmuoh.tos, data.to)
      end
    end
  end,

  on_use = function(self, event, target, player, data)
    player:drawCards(1, thoucqmuoh.name)
    if  player.dead then return end
    local room=player.room
    local dis=false
   if (not data.to.dead) and (not data.to:isAllNude())
   and  room:askToSkillInvoke(player,
      {skill_name=thoucqmuoh.name,
      prompt="#thoucqmuoh-damage-ask:"..data.to.id
    }) 
    then
      local cid=room:askToChooseCard(player,{
        target=data.to,
        flag="he",
        skill_name=thoucqmuoh.name
      })
      room:throwCard({cid}, thoucqmuoh.name, data.to, player)
    end


  end,
})

return thoucqmuoh
