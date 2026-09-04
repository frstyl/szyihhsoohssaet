
local jiuqtous = fk.CreateSkill {
  name = "jiuqtous",
}

Fk:loadTranslationTable{
["jiuqtous"] = "游鬥",
[":jiuqtous"] = "伱可對脚色A起動殺旹,伱可發動.伱展示其1手牌,肰後伱与其同旹選是否弃1手牌与所示牌同色者,若伱弃而A未弃,伱1段對其所起動下一張殺不可被｢閃｣抵消致傷旹傷害+1;若伱未弃且A弃,伱獲得A所弃牌抽1,伱1段下一殺不可指定其爲目幖",
--區分伱已此法所起動 与 此牌?
["#jiuqtous"] = "2同類牌轉化爲殺",

["$jiuqtous1"] = "來一个,殺一个.來一對,殺一雙",
["$jiuqtous2"] = "絳霞影裏,卷一道凍地仌霜",
}

jiuqtous:addEffect("active", {
  target_num = 1,
  card_num = 0,
  target_filter = function(self, player, to_select, selected)
    return player:canUseTo(Fk:cloneCard("ssaet"),to_select)
  end,
  on_use = function (self, room, effect)
    local to=effect.tos[1]
    local result = room:askToJointCards(player, {
      players = {player, to},
      min_num = 1,
      max_num = 1,
      include_equip = true,
      cancelable = false,
      skill_name = jiuqtous.name,
      prompt = "#jiuqtous-discard",
      will_throw = true,
    })
    local n=0
    if #result[player]==0 and #result[to]==1 then
      n=1

    elseif  #result[player]==1 and #result[to]==0 then
      n=2
    end 
    -- room:throwCards()
    -- room:throwCards()
    local moves = {}
    if #result[data.to] > 0 then
    table.insert(moves, {
      from = player,
      ids = result[player],
      toArea = Card.DiscardPile,
      moveReason = fk.ReasonDiscard,
      proposer = player,
    })
    end
    if #result[data.to] > 0 then
      table.insert(moves, {
        from = to,
        ids = result[data.to],
        toArea = Card.DiscardPile,
        moveReason = fk.ReasonDiscard,
        proposer = data.to,
      })
    end
    room:moveCards(table.unpack(moves))
    if player.dead then return end
    if n==1 then
      player:drawCards(1,jiuqtous.name)
      room:setPlayerMark(player,"jiuqtous-prohibit-phase",to.id)
    elseif n==2 then
      room:setPlayerMark(player,"jiuqtous-damage-phase",to.id)
    end
  end,
})

jiuqtous:addEffect(fk.CardUseFinished, {  --无視防具 --待改
  can_refresh = function(self, event, target, player, data)
    return target==player and data.card.trueName=="ssaet"
  end,
  on_refresh = function(self, event, target, player, data)
    room:setPlayerMark(player,"jiuqtous-prohibit-phase",0)
    for _, p in ipairs(data.tos)do 
      if p.id=="jiuqtous-damage-phase" then 
        room:setPlayerMark(player,"jiuqtous-damage-phase",0)
      end
    end
  end,
})

jiuqtous:addEffect(fk.TargetConfirmed, {
  can_trigger = function(self, event, target, player, data)
    return  data.from == player and player:getMark("jiuqtous-damage-phase")==data.to.id
      and data.card.trueName == "ssaet"
  end,
  on_trigger = function(self, event, target, player, data)
    player:broadcastSkillInvoke(jiuqtous.name)
    player.room:notifySkillInvoked(player, jiuqtous.name, "defensive")
    data.use.prohibitedCardNames = data.use.prohibitedCardNames or {}
    table.insertIfNeed(data.use.prohibitedCardNames,"szjemh")
  end,
})

jiuqtous:addEffect(fk.DamageInflicted, {
  can_trigger = function(self, event, target, player, data)
    return player.seat==1 and data.from :getMark("jiuqtous-damage-phase")==data.to.id
      and data.card.trueName == "ssaet"
  end,
  on_trigger = function(self, event, target, player, data)
    player:broadcastSkillInvoke(jiuqtous.name)
    player.room:notifySkillInvoked(player, jiuqtous.name, "defensive")
    S.changeDamage({damageData=data,num=1,skillName=jiuqtous.name})
  end,
})

jiuqtous:addEffect("prohibit", {
  is_prohibited = function(self, from, to, card)
    if from:getMark("jiuqtous-prohibit-phase")==to.id and card then
      return card.trueName=="ssaet"
    end
  end,
})
return jiuqtous

