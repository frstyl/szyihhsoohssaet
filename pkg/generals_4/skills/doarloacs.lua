local doarloacs = fk.CreateSkill {
  name = "doarloacs",
}

Fk:loadTranslationTable {
  ["doarloacs"] = "大浪",
  [":doarloacs"] = "伏段始歬,伱可選一角色伏區1牌發動.伱將其迻動至別一角色伏區,伱可緟複此流程.伱越過此段伏段補段",

  ["#doarloacs-choose"] = "大浪：選擇伏區1牌",
  ["#doarloacs-choose"] = "大浪：選擇迻動目幖角色 不選則不動",

  ["$doarloacs1"] = "准备受死吧！",

}

doarloacs:addEffect(fk.EventPhaseChanging, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(doarloacs.name) and data.phase == Player.Judge 
    and #table.filter(player.room.alive_players,       function(p)
      return  #p:getCardIds("j")>0
      end)>0
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local to1 = room:askToChoosePlayers(player, {
          targets = table.filter(room.alive_players , 
      function(p)
      return  #p:getCardIds("j")>0
      end),
          min_num = 1,
          max_num = 1,
          prompt = "#doarloacs-choose",
          skill_name = doarloacs.name,
          cancelable = true,
        })

      if #to1==0 then return end
      local card = room:askToChooseCard(player,{
        target = to1[1],
        flag = "j",
        skill_name = doarloacs.name,
        })
            
        local to2 = room:askToChoosePlayers(player, {
          targets = table.filter(room.alive_players ,function(p)
          return  p~=to1[1]
          end),
          min_num = 1,
          max_num = 1,
          prompt = "#doarloacs-choose2",
          skill_name = doarloacs.name,
          cancelable = true,
        })
      if #to2==0 then return end
      event:setCostData(self, {cards=card, tos={to1[1],to2[1]}})
      return true
  end,
  on_use = function(self, event, target, player, data)
      data.skipped = true
      player:skip(Player.Draw)
    local room = player.room
    local to1 = event:getCostData(self).tos[1]
    local to2 = event:getCostData(self).tos[2]
    room:moveCardTo(event:getCostData(self).cards, Card.PlayerJudge, to2, Fk.ReasonPut, doarloacs.name,nil,true,player)

    while 1 do
      if #to1:getCardIds("j")==0 then return end
      local card = room:askToChooseCard(player,{
        target = to1,
        flag = "j",
        skill_name = doarloacs.name,
        })
            
         to2 = room:askToChoosePlayers(player, {
          targets = table.filter(room.alive_players ,function(p)
          return  p~=to1
          end),
          min_num = 1,
          max_num = 1,
          prompt = "#doarloacs-choose2",
          skill_name = doarloacs.name,
          cancelable = true,
        })
      if #to2==0 then return end
    room:moveCardTo(card, Card.PlayerJudge, to2[1], Fk.ReasonPut, doarloacs.name,nil,true,player)  --緟流程 止發動1次
      end

  end,
})

return doarloacs
