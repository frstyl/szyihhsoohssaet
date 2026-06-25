local guacqdzzjen = fk.CreateSkill {
  name = "guacqdzzjen",
}

Fk:loadTranslationTable{
  ["guacqdzzjen"] = "狂禪",
  [":guacqdzzjen"] = "當伱使用卽旹錦囊牌結算終旹,伱可指定距離2以內角色發動.視爲伱對其使用虛殺",


  ["#guacqdzzjen-choose"] = "狂禪 選擇殺目幖",
  ["$guacqdzzjen1"] = "不破不立破而後立",

}


guacqdzzjen:addEffect(fk.CardUseFinished, { --??
  can_trigger = function(self, event, target, player, data)
    return 
    target == player and player:hasSkill(guacqdzzjen.name)
    and data.card.type==Card.TypeTrick
  end,
  on_cost = function(self, event, target, player, data)
    local room=player.room
      local targets = table.filter(room:getOtherPlayers(player, false), function (p)
      return player:canUseTo(Fk:cloneCard("ssaet"), p, {bypass_distances = true, bypass_times = true})
      and player:distanceTo(p) <3
    end)
      if #targets > 0 then
        local to = room:askToChoosePlayers(player, {
          targets = targets,
          min_num = 1,
          max_num = 1,
          prompt = "#guacqdzzjen-choose",
          skill_name = guacqdzzjen.name,
          cancelable = true,
        })
        if #to > 0 then
           event:setCostData(self,{tos=to})
           return true
        end
      end

  end,
  on_use = function(self, event, target, player, data)
    player.room:useVirtualCard("ssaet", nil, player, event:getCostData(self).tos, guacqdzzjen.name, true)
  end,
  })



return guacqdzzjen
