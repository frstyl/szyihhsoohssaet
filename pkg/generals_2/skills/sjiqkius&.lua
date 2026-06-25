local sjiqkius = fk.CreateSkill {
  name = "sjiqkius&",
}

Fk:loadTranslationTable{
  ["sjiqkius&"] = "私救",
  [":sjiqkius&"] = "階段限1.主動.預弃1肉選擇1其它角色發動,其回2抽1,獲得報幖記(伱可發動1次私救)。",

}

sjiqkius:addEffect("active", {
  anim_type = "support",
  card_num = 1,
  target_num = 1,
  prompt = "#sjiqkius",
  can_use = function(self, player)
    return player:usedSkillTimes(sjiqkius.name, Player.HistoryPhase) == 0
  end,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and table.contains(player:getCardIds("h"), to_select)
    and Fk:getCardById(to_select).name=="peach"
    and  not player:prohibitDiscard(to_select)
  end,
  target_filter = function(self, player, to_select, selected, selected_cards)
      return (#selected == 0 and to_select~=player) and to_select:isWounded()
  end,
  on_use = function(self, room, effect)
    local from = effect.from
    local to = effect.tos[1]  --
    room:throwCard(effect.cards, sjiqkius.name, from, from)
    room:recover{
      who = to,
      num = 2,
      recoverBy = from,
      skillName = sjiqkius.name,
    }
    to:drawCards(1,sjiqkius.name)
    if to:hasSkill("sjiqkius") then return end
    room:handleAddLoseSkills(from, "-sjiqkius&", nil, false, true)
  end,
})



return sjiqkius
