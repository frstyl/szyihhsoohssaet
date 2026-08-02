local cardSkill = fk.CreateSkill {
  name = "dzzuoh_dzziach_khoeoj_hsfa_skill",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{
  ["dzzuoh_dzziach_khoeoj_hsfa_skill"] = "樹上開花",
  ["#dzzuoh_dzziach_khoeoj_hsfa_skill"] = "伱將牌堆頂牌置入伱裝僃區至伱裝僃區滿",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt = "#dzzuoh_dzziach_khoeoj_hsfa_skill",
  offset_func= Util.FalseFunc,
  mod_target_filter = function(self, player, to_select)
    return to_select:hasEmptyEquipSlot()
  end,
  -- can_use = Util.CanUseToSelf,
  target_num=1,
  target_filter = function(self, player, to_select, selected, _, card, extra_data)
    return S.useToSelfFilter(self, player, to_select, selected, _, card, extra_data)
  end,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    local player=effect.to
    
    -- local mapper = {
    --   [Card.SubtypeWeapon] = "weapon",  --num
    --   [Card.SubtypeArmor] = "armor",
    --   [Card.SubtypeDefensiveRide] = "offensive_horse",
    --   [Card.SubtypeOffensiveRide] = "defensive_horse",
    --   [Card.SubtypeTreasure] = "treasure",
    -- }
    local equip_types={
    Card.SubtypeWeapon, 
    Card.SubtypeArmor,
    Card.SubtypeDefensiveRide,
    Card.SubtypeOffensiveRide, 
    Card.SubtypeTreasure
  }  --3 ~7
    -- while true do  --裝僃欄編号??  --中途多裝僃欄?
    --   if not  player:hasEmptyEquipSlot() then return end
    --   for _, typ in ipairs(equip_types) do
    --     if player:hasEmptyEquipSlot(typ) then
    --       local cid=room:getNCards(1)
    --       S.moveNonEquipIntoEquipArea(player, cid, cardSkill.name, true, player,{typ})  --
    --     end
    --   end
    -- end
    
    local moveInfos = {}
    local cards = room:getNCards(#player:getAvailableEquipSlots() - #player:getEquipCards())
    local i = 0 
    for _, subtype in ipairs(equip_types) do
      local n = #player:getAvailableEquipSlots(subtype) - #player:getEquipCards(subtype)
      if n >0 then
        for j=1,n,1 do
          local card = Fk:cloneCard(Util.convertSubtypeAndEquipSlot(subtype).."__not_equip")
          card:addSubcard(cards[i+j])
          table.insert(moveInfos,{
            from = nil,
            to = player,
            toArea = Card.PlayerEquip,
            ids = card.subcards,
            moveReason = fk.ReasonPut,
            skillName = cardSkill.name,
            proposer = player,
            virtualEquip = card,
          })
        end
      end
      i=i+n
    end

    room:moveCards(table.unpack(moveInfos))
  end,
})


return cardSkill
