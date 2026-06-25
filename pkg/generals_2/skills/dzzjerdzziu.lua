local dzzjerdzziu = fk.CreateSkill{
  name = "dzzjerdzziu",
}


Fk:loadTranslationTable{
["dzzjerdzziu"] = "誓讎",
[":dzzjerdzziu"] = "伱進入瀕死旹,若當轉角色A不爲伱,伱可選B發動.B展示全部手牌,予A x傷(x爲其手牌黑牌數)",

["#dzzjerdzziu-choose"] = "誓讎 選擇一角色其展示手牌 予%src傷害",
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

dzzjerdzziu:addEffect(fk.EnterDying, {
  anim_type = "drawcard",
  can_trigger = function (self, event, target, player, data)
    if  target==player and player:hasSkill(dzzjerdzziu.name)  then
      local current=player.room:getCurrent()
      if current~=nil and current~=player then
        event:setCostData(self, {current = current})
        return true
      end
    end
  end,
  on_cost= function (self, event, target, player, data)
    local current=event:getCostData(self).current
    local tos = player.room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = table.filter(player.room.alive_players,function(p)
        return p~=player and p~= current
      end),
      skill_name = dzzjerdzziu.name,
      prompt = "#dzzjerdzziu-choose:"..current.id,
      cancelable = true,
    })
    if #tos > 0 then
      event:setCostData(self, {current=current, tos = tos})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local to =event:getCostData(self).tos[1]
    local cards=to:getCardIds("h")
    to:showCards(cards)
    local n =0
    for _,id in ipairs(cards) do
      if Fk:getCardById(id).color==Card.Black then n=n+1 end
    end
        player.room:damage{
          from = to,
          to = event:getCostData(self).current,
          damage = n,
          skillName = dzzjerdzziu.name,
        }
    return true
  end,
})


return dzzjerdzziu
