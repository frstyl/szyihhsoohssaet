local teejhlik = fk.CreateSkill({
  name = "teejhlik",
})

Fk:loadTranslationTable{
  ["teejhlik"] = "底力",--驕矜
  [":teejhlik"] = "伱轉始,伱聲明數字a發動｡伱體力調整至a,轉終,反調整伱因此變化體力值｡a取值爲1至伱體力上限且不爲伱體力值",  --當轉?

  ["#teejhlik-ivnoek"] = "底力 選擇數",

  ["@teejhlik-turn"] = "底力",


  ["$teejhlik1"] = "矢贯坚石，劲冠三军！", 
  ["$teejhlik2"] = "吾虽年迈，箭矢犹锋！",
}



teejhlik:addEffect(fk.TurnStart, {
  anim_type = "drawcards",
  can_trigger = function(self, event, target, player, data)
    return
      target==player
    and player:hasSkill(teejhlik.name) 
    and player.maxHp~=1
  end,
  on_cost = function(self, event, target, player, data)
    local choices = {"Cancel"}
    for i = 1, player.maxHp do
      if i ~=player.hp then
      table.insert(choices, tostring(i))
      end
    end
    local  n = player.room:askToChoice(player, { ---@type integer
        choices = choices,
        skill_name = teejhlik.name,
        prompt = "#teejhlik-invoke"
      })

    if n~="Cancel" then
      event:setCostData(self,{n=tonumber(n)})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local m=  event:getCostData(self).n -player.hp 
    room:changeHp(player,m, nil, teejhlik.name)
    room:setPlayerMark(player,"@teejhlik-turn",m)
  end,
})


teejhlik:addEffect(fk.TurnEnd, {
  anim_type = "negative",
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    if  player.dead then return end
    local n= player:getMark("@teejhlik-turn")

    if n~=0 then 
      event:setCostData(self,{n=n})
      return true
    end
  end,
  on_use= function(self, event, target, player, data)
    player.room:changeHp(player, -(event:getCostData(self).n), nil, teejhlik.name)
  end,
  })
return teejhlik
