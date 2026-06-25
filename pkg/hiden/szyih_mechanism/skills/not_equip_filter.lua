local cardSkill = fk.CreateSkill {
  name = "not_equip_filter_skill",
}


    local mapper = {
      [Card.SubtypeWeapon] = "weapon",  --num
      [Card.SubtypeArmor] = "armor",
      [Card.SubtypeDefensiveRide] = "defensive_horse",
      [Card.SubtypeOffensiveRide] = "offensive_horse",
      [Card.SubtypeTreasure] = "treasure",
    }
    
cardSkill:addEffect("filter", {
  -- global=true,
  card_filter = function(self, to_select, player, isJudgeEvent)
    return to_select:getMark("@@not_equip") ~= 0
    -- return #to_select:getTableMark("@@not_equip-inarea") ~= 0 --and Fk:getCardById(to_select).area~=Card.PlayerEquip
  end,
  view_as = function(self, player, to_select)

    return Fk:cloneCard(mapper[to_select:getMark("@@not_equip")].."__not_equip", to_select.suit, to_select.number)
  end,
})

return cardSkill
