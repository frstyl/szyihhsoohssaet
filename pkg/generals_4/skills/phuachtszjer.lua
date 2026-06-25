local phuachtszjer = fk.CreateSkill({
  name = "phuachtszjer",
  attached_skill_name = "phuachtszjer_active&",
})

Fk:loadTranslationTable{
  ["phuachtszjer"] = "仿製",
  [":phuachtszjer"] = "➀段限1,任一角色可于其主旹展示一牌,令伱記彔其牌名.➁段限1,伱可將1牌轉化爲1記錄牌使用發動,迻除該記錄",  --彊度

  ["#phuachtszjer"] = "轉化",

  ["$phuachtszjer1"] = "以假亂眞",
  ["$phuachtszjer2"] = "精雕細𣪲,萬无一失",
}

phuachtszjer:addAcquireEffect(function (self, player, is_start)
  player.room:handleAddLoseSkills(player, "phuachtszjer_active&", nil, false, true)
end
)

phuachtszjer:addEffect("viewas", {
  anim_type = "offensive",
  prompt = "#phuachtszjer",
  interaction = function (self, player)
    local all_names = player:getTableMark("phuachtszjer_card_record")
    local names = player:getViewAsCardNames(phuachtszjer.name, all_names, nil,nil)
    if #names == 0 then return end
    return UI.CardNameBox { choices = names, all_choices = all_names }
  end,
  card_filter = function (self, player, to_select, selected)
    return #selected == 0 
  end,
  view_as = function (self, player, cards)
    if #cards ~= 1 or self.interaction.data == nil then return end
    local card = Fk:cloneCard(self.interaction.data)
    card.skillName = phuachtszjer.name
    card:addSubcards(cards)
    return card
  end,
  before_use = function (self, player, use)
    -- use.extraUse = true
    player.room:removeTableMark(player, "phuachtszjer_card_record",use.card.name)  --removeOne
    if player:usedSkillTimes(phuachtszjer.name,Player.HistoryPhase) >1 then --已爲使用後
      player.room:removePlayerMark("dziacssjim",1)
      players:setSkillUseHistory(phuachtszjer.name, 1, Player.HistoryPhase)
    end
    -- if use.card.type==Card.TypeEquip then
    --   local c = Fk:getCardById(use.card.subcards[1])
    --   player.room:setCardMark(c, "@@phuachtszjer-inarea", { use.card.name, Card.PlayerEquip})
    --   Fk:filterCard(c.id, player)  --addVirtualEquip有何用
    -- end
  end,
  enabled_at_play = function (self, player)
    return player:usedSkillTimes(phuachtszjer.name,Player.HistoryPhase) <1+player:getMark("dziacssjim")
  end,
  enabled_at_response = function (self, player, response)
    return not response and
      player:usedSkillTimes(phuachtszjer.name,Player.HistoryPhase) <1+player:getMark("dziacssjim")
  end,
  enabled_at_nullification = function (self, player, cardEffectData)
    if not self:enabledAtResponse(player, false) then return end

    local all_names = player:getTableMark("phuachtszjer_card_record")
    local names = player:getViewAsCardNames(phuachtszjer.name, all_names, nil,nil)
    if #names == 0 then return end

    return true

  end,
})

-- phuachtszjer:addEffect("filter", {
--   card_filter = function(self, card, player, isJudgeEvent)
--     return #card:getTableMark("@@phuachtszjer-inarea") ~= 0 --and Fk:getCardById(to_select).area~=Card.PlayerEquip
--   end,
--   view_as = function(self, player, card)
--     return Fk:cloneCard(card:getTableMark("@@phuachtszjer-inarea")[1], card.suit, card.number)
--   end,
-- })
return phuachtszjer
