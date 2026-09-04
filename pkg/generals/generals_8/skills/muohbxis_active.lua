local muohbxis_active = fk.CreateSkill {
  name = "muohbxis_active",
}

Fk:loadTranslationTable {
  ["muohbxis_active"] = "武僃",
  [":muohbxis_active"] = "➀主旹,伱可預選1手牌發動.伱將此牌置入裝僃欄(自選),其抽x.➁恆續,伱攻程+x,存牌數+x(x爲伱裝僃區牌數)",

  ["#muohbxis_active"] = "武僃：將1手牌置入伱裝僃區",

  ["$muohbxis_active1"] = "怀兼爱之心，琢世间百器。",
  ["$muohbxis_active2"] = "机巧用尽，方化腐朽为神奇！",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 


    -- local mapper = {
    --   [Player.WeaponSlot] = "weapon",  --num
    --   [Player.ArmorSlot] = "armor",
    --   [Player.OffensiveRideSlot] = "offensive_horse",
    --   [Player.DefensiveRideSlot] = "defensive_horse",
    --   [Player.TreasureSlot] =  "treasure",
    -- }

muohbxis_active:addEffect("active", {  --段始旹
  anim_type = "support",
  prompt = "#muohbxis_active",
  max_phase_use_time = 1,
  card_num = 1,
  target_num = 1,
  can_use = function (self, player)
    return player:usedEffectTimes("muohbxis", Player.HistoryPhase) == 0 and #player:getAvailableEquipSlots() > 0
  end,
  interaction = function(self, player)
    -- return UI.ComboBox { choices = player:getAvailableEquipSlots() }

    return UI.ComboBox { choices={
      Player.WeaponSlot,
      Player.ArmorSlot,
      Player.OffensiveRideSlot,
      Player.DefensiveRideSlot,
      Player.TreasureSlot,
    }
  }
  end,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and table.contains(player:getCardIds("h"), to_select)
  end,
  target_filter = function(self, player, to_select, selected, selected_cards)
    return #selected == 0 and #to_select:getAvailableEquipSlots(Util.convertSubtypeAndEquipSlot(self.interaction.data))>0
  end,
  on_use = function(self, room, effect)
    local player = effect.from
    local to = effect.tos[1]


    -- local mapper = {
    --   [Player.WeaponSlot] = Card.SubtypeWeapon,  --num
    --   [Player.ArmorSlot] = Card.SubtypeArmor,
    --   [Player.OffensiveRideSlot] = Card.SubtypeDefensiveRide,
    --   [Player.DefensiveRideSlot] = Card.SubtypeOffensiveRide,
    --   [Player.TreasureSlot] = Card.SubtypeTreasure,
    -- }
    local card =Fk:cloneCard((self.interaction.data).."__not_equip") 
    card:addSubcard(effect.cards[1])
    room:moveCards({
      from = player,
      to = to,
      toArea = Card.PlayerEquip,
      ids = card.subcards,
      moveReason = fk.ReasonPut,
      skillName = "muohbxis",
      proposer = player,
      virtualEquip = card,
    })

  if to.dead then return end
  local n = #to:getCardIds("e")
    local choice = room:askToChoice(to, {
       choices = {"muohbxis_draw"..n, "muohbxis_skill"},
        skill_name = "muohbxis"
       })
  if choice=="muohbxis_skill" then
      room.logic:getCurrentEvent():findParent(GameEvent.Round):addCleaner(function()
        room:handleAddLoseSkills(player, "tsjecqkaap")
      end)
      room:handleAddLoseSkills(player, "tsjecqkaap")
  else
    to:drawCards(n, "muohbxis")
  end
  end,
})



return muohbxis_active
