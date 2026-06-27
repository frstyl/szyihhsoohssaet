local tszhiocqphioc = fk.CreateSkill{
  name = "tszhiocqphioc",
}

Fk:loadTranslationTable{
  ["tszhiocqphioc"] = "䡴鋒",
  [":tszhiocqphioc"] = "主段始旹,伱可預弃x牌(至少1,至多爲伱已損體力值,點數等差)發動.伱抽x,此轉伱至其它角色距離-x",

  ["#tszhiocqphioc-invoke"] = "䡴鋒  弃牌 至多%arg",
  ["tszhiocqphioc-turn"] = "䡴鋒",

}


tszhiocqphioc:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(tszhiocqphioc.name) and player.phase == Player.Play
  end,
  on_cost = function (self, event, target, player, data)
    local room = player.room
    local yes, ret = room:askToUseActiveSkill(player, {
      skill_name = "tszhiocqphioc_active", 
      prompt = "#tszhiocqphioc-invoke:"..player:getLostHp(), 
      cancelable = true, 
      no_indicate = false,
      skip=true,
    })
    if yes then 
      event:setCostData(self, {cards = ret.cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local n =#event:getCostData(self).cards
    player.room:throwCard(event:getCostData(self).cards, tszhiocqphioc.name, player, player)
    player:drawCards(n, tszhiocqphioc.name)
    player.room:setPlayerMark(player,"tszhiocqphioc-turn",n)

  end,
})

tszhiocqphioc:addEffect("distance", {
  correct_func = function(self, from, to)
    if from:hasSkill(tszhiocqphioc.name) and from:getMark("tszhiocqphioc-turn")>0 then
      return -from:getMark("tszhiocqphioc-turn")
    end
  end,
})

return tszhiocqphioc
