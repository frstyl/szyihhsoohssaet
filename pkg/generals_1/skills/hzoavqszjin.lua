local hzoavqszjin = fk.CreateSkill {
  name = "hzoavqszjin",
}

Fk:loadTranslationTable{
  ["hzoavqszjin"] = "𠢕紳",
  [":hzoavqszjin"] = "➀額定抽牌旹,若伱抽牌數大于0,伱可指定1角色發動,伱抽牌數-1,目幖角色將手牌補至體力上限.➁段限1,主旹.選擇1其它角色与伱x手牌(x=max(1,Ceiling(手牌數/2))并聲明1階段發動,伱將所選牌交予目幖角色,其于此轉後執行1額外轉止含伱所聲明之段,此轉內其致傷旹,伱抽1",  

  ["#hzoavqszjin-active"] = "𠢕紳 將半數手牌交与1角色,其執行額外主段",
  ["#hzoavqszjin-draw"] = "𠢕紳 令1角色將手牌補至體力上限",
  ["@@hzoavqszjin-turn"] = "𠢕紳",

  ["$hzoavqszjin1"] = "以吾萬串家財,助伱一臂之力",

}
hzoavqszjin:addEffect(fk.DrawNCards, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(hzoavqszjin.name) and data.n > 0
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local to = room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = room.alive_players,
      skill_name = hzoavqszjin.name,
      prompt = "#hzoavqszjin-draw",
      cancelable = true,
    })
    if #to > 0 then
      event:setCostData(self, {tos = to})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)  --鎖
    data.n=data.n-1
    local to = event:getCostData(self).tos[1]
    local n = to.maxHp - to:getHandcardNum()
    if n>0 then
      to:drawCards(n,hzoavqszjin.name)
    end
  end,
})


hzoavqszjin:addEffect("active", {
  anim_type = "support",
  prompt = "#hzoavqszjin-active",
  card_num = function(self, player)
    return (1 + player:getHandcardNum()) // 2
  end,
  target_num = 1,
  can_use = function(self, player)
    return not player:isKongcheng() and player:usedSkillTimes(hzoavqszjin.name, Player.HistoryPhase) == 0
  end,
  card_filter = function(self, player, to_select, selected)
    return #selected < (1 + player:getHandcardNum()) // 2 and table.contains(player:getCardIds("h"), to_select)
  end,
  target_filter = function(self, player, to_select, selected)
    return #selected == 0 and to_select ~= player
  end,
  interaction = function(self, player)
    return UI.ComboBox {
      choices = {"預段","伏段","補段","主段","撤段","末段"}
      --  choices ={Player.Start, Card.Judge, Player.Draw, Player.Play, Player.Discard, Player.Finish}
    }
  end,
  on_use = function(self, room, effect)
    local player = effect.from
    local target = effect.tos[1]
     
    room:moveCardTo(effect.cards, Player.Hand, target, fk.ReasonGive, hzoavqszjin.name, nil, false, player)
    if not target.dead then
      local phaseList = {Player.Start, Card.Judge, Player.Draw, Player.Play, Player.Discard, Player.Finish}
      local choice = phaseList[table.indexOf({"預段","伏段","補段","主段","撤段","末段"},  self.interaction.data)]  --+1
      target:gainAnExtraTurn(true, hzoavqszjin.name, {choice}, {hzoavqszjin_from=player.id})
    end
  end,
})

hzoavqszjin:addEffect(fk.TurnStart, {
  can_refresh = function(self, event, target, player, data)
    return data.reason == hzoavqszjin.name and data.extra_data and data.extra_data.hzoavqszjin_from==player.id
  end,
  on_refresh = function(self, event, target, player, data)
      player.room:setPlayerMark(target, "@@hzoavqszjin-turn", player.id)
  end,
})

hzoavqszjin:addEffect(fk.DamageCaused, {
  can_trigger = function(self, event, target, player, data)
    return target:getMark("@@hzoavqszjin-turn") == player.id
  end,
  on_trigger = function(self, event, target, player, data)
     player:drawCards(1,hzoavqszjin.name)
  end,
})

return hzoavqszjin
