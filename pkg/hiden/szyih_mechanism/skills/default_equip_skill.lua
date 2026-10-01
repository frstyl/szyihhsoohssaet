local skill = fk.CreateSkill{
  name = "self_equip_skill",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{
["#self_equip_skill"] = "起動而裝僃 ｢%arg｣",
}
skill:addEffect("cardskill", {
  prompt = function(self, player, selected_cards, _)
    if not selected_cards or #selected_cards == 0 then return " " end
    return "#self_equip_skill:::" .. Fk:getCardById(selected_cards[1]).name
  end,
  mod_target_filter = function(self, player, to_select, selected, card, distance_limited)
    return #to_select:getAvailableEquipSlots(card.sub_type) > 0
  end,
  -- can_use = Util.CanUseToSelf,
  target_num=1,
  target_filter = function(self, player, to_select, selected, _, card, extra_data)  --能否多目幖?
    return S.useToSelfFilter(self, player, to_select, selected, _, card, extra_data)
  end,
  on_use = function(self, room, use)
    if not use.tos or #use.tos == 0 then
      use.tos = { use.from }
    end

    local target = use.tos[1]
    local subType = use.card.sub_type

    if use.toPutSlot == nil and #target:getAvailableEquipSlots(subType)>1 then  --裝僃欄應幖號
      local choices = table.map(target:getEquipments(subType), function(id, index)
        return "#EquipmentChoice:" .. index .. "::" .. Fk:translate(Fk:getCardById(id).name)
      end)
      if target:hasEmptyEquipSlot(subType) then
        table.insert(choices, Util.convertSubtypeAndEquipSlot(subType))
      end
      use.toPutSlot = room:askToChoice(target, {
        choices = choices,
        skill_name = "replace_equip",
        prompt = "#GameRuleReplaceEquipment",
      })
    end
  end,
  on_action = function(self, room, use, finished)
    room:sortByAction(use.tos)
    local target=use.tos[1]
    if not target then return end

    local target = use.tos[1]
    local subType = use.card.sub_type
    local existingEquipId

    if use.toPutSlot == nil and #target:getAvailableEquipSlots(subType)>1 then  --裝僃欄應幖號
      local choices = table.map(target:getEquipments(subType), function(id, index)
        return "#EquipmentChoice:" .. index .. "::" .. Fk:translate(Fk:getCardById(id).name)
      end)
      if target:hasEmptyEquipSlot(subType) then
        table.insert(choices, Util.convertSubtypeAndEquipSlot(subType))
      end
      use.toPutSlot = room:askToChoice(target, {
        choices = choices,
        skill_name = "replace_equip",
        prompt = "#GameRuleReplaceEquipment",
      })

      if use.toPutSlot:startsWith("#EquipmentChoice") then
        local index = useCardData.toPutSlot:split(":")[2]
        existingEquipId = target:getEquipments(useCardData.card.sub_type)[tonumber(index)]
      end
    end

    local moves={}
    if   existingEquipId  then  --有敘?
      table.insert(moves,{
        ids = { existingEquipId },
        from = target,
        toArea = Card.DiscardPile,
        moveReason = fk.ReasonPutIntoDiscardPile,
      }) 
    end
    table.insert(moves,{ ---@type CardsMoveInfo
        ids = realCardIds,
        to = target,
        toArea = Card.PlayerEquip,
        moveReason = fk.ReasonUse,
      })
    room:moveCards(moves)


  end,
})



return skill
