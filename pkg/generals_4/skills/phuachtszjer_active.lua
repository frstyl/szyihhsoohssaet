local phuachtszjer_active = fk.CreateSkill({
  name = "phuachtszjer_active&",
})

Fk:loadTranslationTable{
  ["phuachtszjer_active&"] = "仿製",
  [":phuachtszjer_active&"] = "段限1.交与仿製角色3手牌A B C,B視爲A,其獲得C",

  ["phuachtszjer-ask"] = "仿製 %src 允許",
  ["@@phuachtszjer"] = "仿製",

  ["#phuachtszjer_active"] = "仿製：展示1牌令仿製者記彔之",
}

phuachtszjer_active:addEffect("active", {
  anim_type = "offensive",
  prompt = "#phuachtszjer_active",
  mute = true,  --誰發動技能?
  card_num = 3,
  target_num = 1,
  max_phase_use_time=1,
  -- can_use = function(self, player)
  --   return player:usedSkillTimes(phuachtszjer_active.name, Player.HistoryPhase) < 1 
  -- end,
  card_filter = function(self, player, to_select, selected)--就不能默認手牌 expan equip
    return table.contains(player:getCardIds("h"), to_select)
    -- return true
  end,
  target_filter = function(self, player, to_select, selected)
    return
     to_select:hasSkill("phuachtszjer") 

  end,

  on_use = function(self, room, effect)
    local to =effect.tos[1]
    local from =effect.from
    room:notifySkillInvoked(from, "phuachtszjer")  --加次數?
    from:broadcastSkillInvoke("phuachtszjer")
    room:doIndicate(from.id, { to })
    
    from:showCards(effect.cards)
    if from.dead or to.dead then return end
    if not room:askToSkillInvoke(to,{skill_name="phuachtszjer",prompt="phuachtszjer-ask:"..from.id}) then return end 
    local card = Fk:getCardById(effect.cards[1])
    room:addTableMark(to,"phuachtszjer_card_record",card.name)
    room:setCardMark(Fk:getCardById(effect.cards[2]),"@@phuachtszjer-inhand-turn",card.name)
    --未迻動判定
    if to ==player then return end
    room:moveCardTo({effect.cards[3]}, Player.Hand, to, fk.ReasonGive, "phuachtszjer", nil, false, from.id)
  end,
})
phuachtszjer_active:addEffect("filter", {
  card_filter = function(self, card, player, isJudgeEvent)
    return card:getMark("@@phuachtszjer-inhand-turn") ~= 0
  end,
  view_as = function(self, player, card)
    return Fk:cloneCard(card:getMark("@@phuachtszjer-inhand-turn"), card.suit, card.number)
  end,
})
return phuachtszjer_active
