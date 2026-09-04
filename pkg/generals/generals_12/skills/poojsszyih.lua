
local poojsszyih = fk.CreateSkill {
  name = "poojsszyih",
}

Fk:loadTranslationTable{
  ["poojsszyih"] = "背水",
  [":poojsszyih"] = "伱失去伱冣後{手牌/體力}後,伱可選1項發動.➀伱抽2x➁伱對1其它脚色起動虛擬｢殺｣x張.(x爲伱已損體力數)",  --有距離限制

  ["#poojsszyih-invoke"] = "背水 是否發動 不選目幖則抽牌",

  -- ["$poojsszyih1"] = "旅人多西望， 客雁難南歬",
  -- ["$poojsszyih2"] = "霜露結瑤華， 煙波勞玉指",
}

local spec={
  on_cost = function(self, event, target, player, data)
    local tos =player.room:askToChoosePlayers(player,{
          targets = player.room:getOtherPlayers(player),
          min_num = 0,
          max_num = 1,
          prompt = "#poojsszyih-invoke",
          skill_name = poojsszyih.name,
          cancelable = true,
        })
        -- if #tos > 0 then
          event:setCostData(self,{tos=tos})
          return true
        -- end
  end,
  on_use = function(self, event, target, player, data)
      local n=player:getLostHp()
    if #event:getCostData(self).tos>0 then
      local room=player.room
      local tos=event:getCostData(self).tos
      for i=1,n,1 do
        -- local use =
         if player:canUseTo(Fk:cloneCard("ssaet"), tos[1], {bypass_distances = false, bypass_times = true}) then
           room:useVirtualCard("ssaet", nil, player, tos, poojsszyih.name, true)
         end
      end
    else
      player:drawCards(2*n,poojsszyih.name)
    end
  end,
}
poojsszyih:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_refresh = function(self, event, target, player, data)
    if   player:hasSkill(poojsszyih.name,true) and player:isKongcheng() then
        for _, move in ipairs(data) do
          if 
            move.from == player 
          then
            for _, info in ipairs(move.moveInfo) do
              if info.fromArea==Card.PlayerHand then
                return true
              end
            end
          end
        end
    end
  end,
  on_refresh = function(self, event, target, player, data)
    local triggers=event:getCostData(self) and event:getCostData(self).triggers or {}
    triggers[player.id]=true
    event:setCostData(self,{triggers=triggers})
  end,
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(poojsszyih.name) and event:getCostData(self) and event:getCostData(player.id)

  end,
  on_cost=spec.on_cost,
  on_use=spec.on_use,
})

poojsszyih:addEffect(fk.HpChanged, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return  target==player and player:hasSkill(poojsszyih.name) and player.hp<1 and data.num < 0 
  end,
  on_cost=spec.on_cost,
  on_use=spec.on_use,
})
return poojsszyih
