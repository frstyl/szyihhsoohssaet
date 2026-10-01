local tszhiocqphioc = fk.CreateSkill{
  name = "tszhiocqphioc",
}

Fk:loadTranslationTable{
  ["tszhiocqphioc"] = "䡴鋒",
  [":tszhiocqphioc"] = "伱主段始旹,伱可投出x牌發動(x至少1,牌差值相同).伱抽x,1轉內伱至其它脚色距離-x",

  ["#tszhiocqphioc-invoke"] = "䡴鋒  投出牌 至多%arg",
  ["tszhiocqphioc-turn"] = "䡴鋒",

}

local S = require "packages/szyihhsoohssaet/szyih_guos"

tszhiocqphioc:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(tszhiocqphioc.name) and player.phase == Player.Play
  end,
  on_cost = function (self, event, target, player, data)
    local room = player.room
    local yes, ret = room:askToUseActiveSkill(player, {
      skill_name = "dou_dook", 
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
	S.playCard( event:getCostData(self).cards, tszhiocqphioc.name,player)
    -- player.room:throwCard(event:getCostData(self).cards, tszhiocqphioc.name, player, player)
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
