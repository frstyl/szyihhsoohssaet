local dzjishsioh = fk.CreateSkill({
  name = "dzjishsioh",
})

Fk:loadTranslationTable{
  ["dzjishsioh"] = "自許",--驕矜
  [":dzjishsioh"] = "任一轉始,伱聲明1數字a(不大于max(1,伱體力值)發動｡抽a,轉終,若伱起動打出牌次數小于a,伱流失差值體力｡",  --1轉?

  ["#dzjishsioh-ivnoek"] = "自許 選擇抽牌數",

  ["@dzjishsioh-turn"] = "自許",


  ["$dzjishsioh1"] = "矢贯坚石，劲冠三军！", 
  ["$dzjishsioh2"] = "吾虽年迈，箭矢犹锋！",
}



dzjishsioh:addEffect(fk.TurnStart, {
  anim_type = "drawcards",
  can_trigger = function(self, event, target, player, data)
    return
      player:hasSkill(dzjishsioh.name) 
      and player.hp>0
  end,
  on_cost = function(self, event, target, player, data)
    local choices = {"Cancel"}
      for i = 1, player.hp do
        table.insert(choices, tostring(i))
      end
    local  n = player.room:askToChoice(player, { ---@type integer
        choices = choices,
        skill_name = dzjishsioh.name,
        prompt = "#dzjishsioh-invoke"
      })

    if n~="Cancel" then
      event:setCostData(self,{n=tonumber(n)})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local n = event:getCostData(self).n
    player:drawCards(n,dzjishsioh.name)
    room:setPlayerMark(player,"@dzjishsioh-turn",n)


    --   room.logic:getCurrentEvent():findParent(GameEvent.Turn, true):addCleaner(function()
    --   if  player.dead then return end

    --   local m = 0
    --   room.logic:getEventsOfScope(GameEvent.UseCard, 1, function (e)
    --     local dat=e.data
    --       if dat.from == player then --用牌數?用牌次數
    --         n=n+1
    --       end
    --   end, Player.HistoryTurn)
    --   if n>m then room:loseHp(player,n-m,dzjishsioh.name) end
    -- end)

  end,
})


dzjishsioh:addEffect(fk.TurnEnd, {
  anim_type = "negative",
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    if  player.dead then return end
    local n= player:getMark("@dzjishsioh-turn")
    if n==0 then return end
      local m = 0
      local room=player.room

      room.logic:getEventsOfScope(GameEvent.UseCard, 1, function (e)
        local dat=e.data
          if dat.from == player then --用牌數?用牌次數
            m=m+1
          end
      end, Player.HistoryTurn)
      room.logic:getEventsOfScope(GameEvent.RespondCard, 1, function (e)
        local dat=e.data
          if dat.from == player then --用牌數?用牌次數
            m=m+1
          end
      end, Player.HistoryTurn)

      if n>m then 
        event:setCostData(self,{n=n-m})
        return true
      end
  end,
  on_use= function(self, event, target, player, data)
    player.room:loseHp(player,event:getCostData(self).n,dzjishsioh.name)
  end,
  })
return dzjishsioh
