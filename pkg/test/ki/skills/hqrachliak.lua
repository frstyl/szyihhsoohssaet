local hqrachliak = fk.CreateSkill {
  name = "hqrachliak",
}

Fk:loadTranslationTable{  --分爲4?
["hqrachliak"] = "影掠",--1/4影掠
[":hqrachliak"] = "伱失去牌後,伱可選1其它脚色發動.伱弃其區域1牌",

["#hqrachliak-choose"]="影掠 選擇1脚色",
["#hqrachliak-recover"]="影掠 選擇1脚色回1",
["#hqrachliak-damage"]="影掠 選擇1脚色傷其1",
-- ["#hqrachliak-drawcard"]="影掠 選擇1脚色 其抽1",
-- ["#hqrachliak-discard"]="影掠 選擇1脚色 其弃1",
}


hqrachliak:addEffect(fk.AfterCardsMove, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(hqrachliak.name) 
  end,
  trigger_times = function(self, event, target, player, data)
    if not  player:hasSkill(hqrachliak.name)  then return 0 end
    local n = 0
    for _, move in ipairs(data) do
      if move.from ==player and (move.to~=player or not table.contains({Card.PlayerEquip,Card.PlayerHand }, move.toArea)) then
        for _, info in ipairs(move.moveInfo) do
          if   (info.fromArea == Card.PlayerHand or info.fromArea == Card.PlayerEquip)   then
            n=n+1
          end
        end
      end
    end
    -- if n>0 then
      event:setCostData(self, {n=n})
      return n
    -- end
  end,
  on_cost = function(self, event, target, player, data)
    local room=  player.room
    -- local n  = event:getCostData(self).n
    local tos = room:askToChoosePlayers(player,{
      targets = room:getOtherPlayers(player, false),
      min_num=1,
      max_num=1,
      prompt = "#hqrachliak-choose",
      skill_name = hqrachliak.name,
      cancelable = true,
    })
    if #tos>0 then 
      event:setCostData(self, {tos=tos,n=event:getCostData(self).n})
      return true
    end

  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local to = event:getCostData(self).tos[1]
    local n  = event:getCostData(self).n
    local cards = room:askToChooseCards(player, {
      skill_name = hqrachliak.name,
      target = to,
      flag = "hej",
      min = 1,
      max = n,
    })
    room:throwCard(cards, hqrachliak.name, to, player)
  end,
})



return hqrachliak
