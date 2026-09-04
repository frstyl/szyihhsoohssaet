local kouqljem = fk.CreateSkill {
  name = "kouqljem",
}

Fk:loadTranslationTable{
  ["kouqljem"] = "勾廉",
  [":kouqljem"] = "伱對其它腳色致傷旹,伱可發動,伱選擇其1裝僃欄,取得其中牌或裝僃欄",

  ["#kouqljem-ask"] = "勾廉 選擇 %dest 裝僃欄",

  ["$kouqljem1"] = "喝啊！",
  ["$kouqljem2"] = "今，必斩汝马下！",
}

kouqljem:addEffect(fk.DamageInflicted, {
  anim_type="offensive",
  can_trigger = function(self, event, target, player, data)
    return data.from  == player and player:hasSkill(kouqljem.name) 
    and data.to~=player
    -- and player.room.logic:damageByCardEffect()
    -- and data.card and (data.card.trueName == "ssaet" or data.card.trueName == "tous_tsiacs")
    and #data.to:getAvailableEquipSlots() >0
  end,
  on_cost = function(self, event, target, player, data)
    local all=data.to:getAvailableEquipSlots()
    -- table.insert(all,"Cancel")
    local choice = player.room:askToChoice(player, {
      choices = all,
      skill_name = kouqljem.name,
      cancelable=true,
      prompt="#kouqljem-ask::"..data.to.id
    })
    if choice=="Cancel" then return end
      local cards  = data.to:getEquipments(Util.convertSubtypeAndEquipSlot(choice))  --轉化牌不能拏

      if #cards ==1 then
        event:setCostData(self,{tos={data.to},choice=choice,cards=cards})
        return true

      elseif #cards ==0 then
          event:setCostData(self,{tos={data.to},choice=choice})
        return true
      else
          local id = room:askToChooseCard(player, {
          target = data.to,
          flag = { card_data = { { "equip", cards } } },
          skill_name = kouqljem.name,
        })
        event:setCostData(self,{tos={data.to},choice=choice,cards={id}})
        return true
      end

  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    if event:getCostData(self).cards then
      room:obtainCard(player, event:getCostData(self).cards , true, fk.ReasonPrey, player, kouqljem.name)
      -- room:moveCardTo(cards,  Card.PlayerHand, player, fk.ReasonPrey, kouqljem.name, nil, true, player)
    else
      local slot=event:getCostData(self).choice
      -- room:abortPlayerArea(data.to, slot)
      room:removePlayerEquipSlots(data.to,slot)
      room:addPlayerEquipSlots(player,slot)
    end 
  end,
})

return kouqljem
