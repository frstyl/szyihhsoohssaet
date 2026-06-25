local cardSkill = fk.CreateSkill {
  name = "dzzuoh_dzziach_khoeoj_hsfa_skill",
}


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
  can_use = Util.CanUseToSelf,
  on_effect = function(self, room, effect)
    local player=effect.to

    local equip_types={
    Card.SubtypeWeapon, 
    Card.SubtypeArmor,
    Card.SubtypeDefensiveRide,
    Card.SubtypeOffensiveRide, 
    Card.SubtypeTreasure}  --3 ~7
    while true do  --裝僃欄編号??  --中途多裝僃欄?
      if not  player:hasEmptyEquipSlot() then return end
      for _, typ in ipairs(equip_types) do
        if player:hasEmptyEquipSlot(typ) then
          local cid=room:getNCards(1)
          S.moveNonEquipIntoEquipArea(player, cid, cardSkill.name, true, player,{typ})  --
        end
      end
    end

  end,
})


return cardSkill
