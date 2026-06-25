local muohbxis = fk.CreateSkill {
  name = "muohbxis",
}

Fk:loadTranslationTable {
  ["muohbxis"] = "武僃",
  [":muohbxis"] = "預段始旹,伱預選1手牌發動.伱將此牌置入裝僃欄(自選),伱抽1.伱攻程+x,存牌數+x(x爲伱裝僃區牌數)",

  ["#muohbxis"] = "武僃：將1手牌置入伱裝僃區",

  ["$muohbxis1"] = "怀兼爱之心，琢世间百器。",
  ["$muohbxis2"] = "机巧用尽，方化腐朽为神奇！",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

muohbxis:addEffect("active", {  --段始旹
  anim_type = "support",
  prompt = "#muohbxis",
  max_phase_use_time = 1,
  card_num = 1,
  target_num = 0,
  can_use = function (self, player)
    return player:usedEffectTimes(muohbxis.name, Player.HistoryPhase) == 0 and #player:getAvailableEquipSlots() > 0
  end,
  interaction = function(self, player)
    return UI.ComboBox { choices = player:getAvailableEquipSlots() }
  end,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and table.contains(player:getCardIds("h"), to_select)
  end,
  on_use = function(self, room, effect)
    local player = effect.from
    player:drawCards(1, muohbxis.name)
    if player.dead then return end
    local card = Fk:getCardById(effect.cards[1])
    local mapper = {
      [Player.WeaponSlot] = Card.SubtypeWeapon,  --num
      [Player.ArmorSlot] = Card.SubtypeArmor,
      [Player.OffensiveRideSlot] = Card.SubtypeDefensiveRide,
      [Player.DefensiveRideSlot] = Card.SubtypeOffensiveRide,
      [Player.TreasureSlot] = Card.SubtypeTreasure,
    }

        --   [Card.SubtypeWeapon] = "weapon",  --num
    --   [Card.SubtypeArmor] = "armor",
    --   [Card.SubtypeDefensiveRide] = "offensive_horse",
    --   [Card.SubtypeOffensiveRide] = "defensive_horse",
    --   [Card.SubtypeTreasure] = "treasure",

    S.moveNonEquipIntoEquipArea(player, effect.cards, muohbxis.name, true, player,{mapper[self.interaction.data]})  --
    -- room:addSkill("not_equip_filter_skill")
    -- room:setCardMark(card, "@@not_equip-inarea", {mapper[self.interaction.data],Card.PlayerEquip})  
    -- player:filterHandcards()  --應不算轉化 將非裝僃置入裝僃區  或 裝僃已非默認置入
    -- room:moveCardIntoEquip(player, effect.cards, muohbxis.name, true, player)  --
    -- room:setCardMark(card, "@@not_equip-inarea", 0)

    -- local c=Fk:cloneCard("spear")
    -- c:onUninstall(room, player)
      -- room:handleAddLoseSkills(player, "spear_skill&", nil, false)

    -- c:addSubcard(Card:getIdList(card))
    -- player:addVirtualEquip(c)--眞止insert
    -- room:useCard{
    --   from = player,
    --   tos = player,
    --   card = c,
    -- }
    -- room:moveCardIntoEquip(player,c, muohbxis.name, true, player)  --
    -- room:setCardMark(card, "@@not_equip-inarea", 0)

  -- room:moveCardTo(card, Player.Judge, player, fk.ReasonPut, muohbxis.name, nil, false)
    -- player:drawCards(1,muohbxis.name)
    -- room:obtainCard(player,player:getCardIds("e")[1],true, fk.ReasonPut,muohbxis.name)  --進出序未變
  end,
})


-- muohbxis:addEffect(fk.AfterCardsMove, {
--   can_trigger = function(self, event, target, player, data)
--     if not player:hasSkill(muohbxis.name) then return end
--     for _, move in ipairs(data) do
--       if move.to == player and move.toArea== Card.PlayerEquip then
--         for _, info in ipairs(move.moveInfo) do
--           if info.fromArea ~= Card.PlayerEquip then
--             return true
--           end
--         end
--       end
--     end
--   end,
--   trigger_times = function(self, event, target, player, data)  --未改
--     local i = 0
--     for _, move in ipairs(data) do
--       if move.to==player and move.toArea== Card.PlayerEquip then
--         for _, info in ipairs(move.moveInfo) do
--           if info.fromArea ~= Card.PlayerEquip then
--             i = i + 1
--           end
--         end
--       end
--     end
--     return i
--   end,
--   on_cost = function(self, event, target, player, data)
--     if player.room:askToSkillInvoke(player, { skill_name = muohbxis.name }) then
--       return true
--     end
--   end,
--   on_use = function(self, event, target, player, data)
--     player:drawCards(1, muohbxis.name)
--   end,
-- })

muohbxis:addEffect("atkrange", {
  correct_func = function(self, player)
    if player:hasSkill(muohbxis.name) and #player:getCardIds("e") > 0 then
      return  #player:getCardIds("e") 
    end
  end
})

muohbxis:addEffect("maxcards", {
  correct_func = function(self, player)
    if player:hasSkill(muohbxis.name) and #player:getCardIds("e") > 0 then
      return  #player:getCardIds("e") 
    end
  end,
})

return muohbxis
