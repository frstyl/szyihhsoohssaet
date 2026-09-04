local thoavqdoav = fk.CreateSkill{
  name = "thoavqdoav",
}

Fk:loadTranslationTable{
  ["thoavqdoav"] = "滔濤",
  [":thoavqdoav"] = "伱受傷後,伱末段始旹,伱可選1至x脚色發動｡伱同旹弃置所選脚色各1牌｡",

  ["#thoavqdoav-invoke"] = "滔濤：選擇目幖 弃置其牌 ",

  ["$thoavqdoav1"] = "",
}

local spec={
  on_cost = function(self, event, target, player, data)
    local tos = player.room:askToChoosePlayers(player, {
        min_num = 1,
        max_num = math.max(1,player:getLostHp()),
        targets = player.room.alive_players,
        -- targets = player.room:getOtherPlayers(player),
        skill_name = thoavqdoav.name,
        prompt = "#thoavqdoav-invoke",
        cancelable = true,
      })
      if #tos>0 then 
        event:setCostData(self,{tos=tos})
        return true 
      end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local tos=event:getCostData(self).tos
    local moveInfos={}
    for _, p in ipairs(tos) do
      if player.dead then return end
      if not p:isNude() then
        local id = room:askToChooseCard(player, {
          target = p,
          skill_name = thoavqdoav.name,
          flag = "he",
        })
        table.insert(moveInfos, {
          from = p.id,
          ids = {id},
          toArea = Card.DiscardPile,
          moveReason = fk.ReasonDiscard,
          proposer = player,
          skillName = thoavqdoav.name,
        })
        -- room:throwCard(id, thoavqdoav.name, p, player)
      end
    end
    

    room:moveCards(table.unpack(moveInfos))
  end,
}
thoavqdoav:addEffect(fk.EventPhaseStart, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(thoavqdoav.name) and player.phase == Player.Finish
  end,
  on_cost = spec.on_cost,
  on_use = spec.on_use,
})
thoavqdoav:addEffect(fk.Damaged, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return data.to == player and player:hasSkill(thoavqdoav.name)
  end,
  on_cost = spec.on_cost,
  on_use = spec.on_use,
})
return thoavqdoav
