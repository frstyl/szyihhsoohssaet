local kaavqprac = fk.CreateSkill {
  name = "kaavqprac",
}


Fk:loadTranslationTable{ --拆解
  ["kaavqprac"] = "交兵",
  [":kaavqprac"] = "伱使用殺或鬥將指定目幖後旹可發動.伱与目幖同旹選擇于生效後抽1或弃1,若所選相同,此{殺/鬥將}不可被{閃/防患未肰}抵消.",
  ["#kaavqprac"] = "交兵 失去體力加傷",


  ["$kaavqprac1"] = "賊子伱往若里去",
  ["$kaavqprac2"] = "",
}

kaavqprac:addEffect(fk.TargetSpecified, {  -- --PreCardEffect
  anim_type = "offensive",
  prompt = "#kaavqprac",
	can_trigger = function(self, event, target, player, data)
		return target==player and player:hasSkill(kaavqprac.name)
    and (data.card.trueName=="ssaet" or data.card.trueName=="tous_tsiacs")
    -- and data:isOnlyTarget(data.to)
	end,
	on_use = function(self, event, target, player, data)
    local room=player.room

    -- data:setUnoffsetable(data.to)
    -- data.extra_data=true

    -- data.disresponsiveList = data.disresponsiveList or {}
    -- table.insertTableIfNeed(data.disresponsiveList, {data.to})

    local params = {
      players = {data.to,player},
      choices = {"draw","discard"},
      prompt = "kaavqprac-choose",
      skillName = kaavqprac.name,
      send_log = true,
    }
   
    local req = player.room:askToJointChoice(player,params)
    if req[player]== req[data.to] then
      data:setUnoffsetable(data.to)
    end
    
    -- if not data then return end
    data.extra_data=data.extra_data or {}

    if  data.extra_data.kaavqprac==nil then
      data.extra_data.kaavqprac={}
      data.extra_data.kaavqprac.from=player.id
      data.extra_data.kaavqprac.t={}

    end

    local t={req[player]=="draw"  and 1 or 2,req[data.to]=="draw"  and 1 or 2}
    data.extra_data.kaavqprac.t[data.to.id]=t

  end,
})

kaavqprac:addEffect(fk.CardUseFinished, {
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    if  data.extra_data and data.extra_data.kaavqprac and  player.id==data.extra_data.kaavqprac.from  then
      return true
    end
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room
    local exe=function(p,result)
      if result==1      then
         p:drawCards(1, kaavqprac.name)
      else
        room:askToDiscard(p, {
          min_num = 1,
          max_num = 1,
          include_equip = false,
          skill_name = kaavqprac.name,
          cancelable = false,
          prompt = "#kaavqprac-discard",
          skip = false,
        })
      end
    end
    local t=data.extra_data.kaavqprac.t
    for _, p in ipairs (room:getOtherPlayers(player)) do
      if t[p.id] then
        if not player.dead then exe(player,t[p.id][1]) end
        if not p.dead then  exe(p,t[p.id][2]) end
      end
    end

  end,
})

kaavqprac:addEffect(fk.PreCardEffect, {
  can_trigger = function(self, event, target, player, data)
    if data.to==player  and data.extra_data 
    and
    --  
    data.extra_data.kaavqprac
    and  data.extra_data.kaavqprac.t and data.extra_data.kaavqprac.t[data.to.id]
    and data.extra_data.kaavqprac.t[data.to.id][1] ==data.extra_data.kaavqprac.t[data.to.id][2] then
      return true
    end
  end,
  on_trigger = function(self, event, target, player, data)

    data.prohibitedCardNames=data.prohibitedCardNames or {}
    table.insertIfNeed(data.prohibitedCardNames, "szjemh")
    table.insertIfNeed(data.prohibitedCardNames, "buac_hzfan_mujs_nzjen")

  end,
})


return kaavqprac
