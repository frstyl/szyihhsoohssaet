local khyeqjuo = fk.CreateSkill{
  name = "khyeqjuo",
}

Fk:loadTranslationTable{
  ["khyeqjuo"] = "窺窬",
  [":khyeqjuo"] = "一段終,若爲其它腳色手牌于伱可見或已知,伱可發動",  --

  ["khyeqjuo-invoke"] = "窺窬 昰否弃1牌埋伏%src",

  ["$khyeqjuo1"] = "板刀麪還是餛飩麪",
  ["$khyeqjuo2"] = "上已昰船可由不得伱矣",
}


khyeqjuo:addEffect(fk.EventPhaseEnd, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(khyeqjuo.name) 
    and data.phase>1 and data.phase<8
  end,
  on_cost = function(self, event, target, player, data)
    local targets={}
    local room=player.room
    for _,p in ipairs(player.room:getOtherPlayers(player)) do
      if table.find(p:getCardIds("h"),function(id) return player:cardVisible(id) end) then 
        table.insert(targets,p)
        player:drawCards(3)
      elseif #player.card_tracker:getKnownCardsByArea(Card.PlayerHand, p)>0 then
        table.insert(targets,p)

      end
    end
    local card=Fk:cloneCard("hqjin_deek_qwe_tsji")
    card.skillName = khyeqjuo.name
      local targets = table.filter(targets, function (p)
        return player:canUseTo(card, p, {bypass_distances = true, bypass_times = true})
      end)
      if #targets==0 then return end
      local tos = room:askToChoosePlayers(player, {
        min_num = 1,
        max_num = 999,
        targets = targets,
        prompt = "#khyeqjuo-use",
        cancelable=true,
      })
    if   #tos>0 then
        event:setCostData(self,{tos=tos})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local card=Fk:cloneCard("hqjin_deek_qwe_tsji")
    card.skillName = khyeqjuo.name
      room:useCard{
      from = player,
      tos = event:getCostData(self).tos,
      card = card,
      extraUse=false,
    }
  end,

})


return khyeqjuo
