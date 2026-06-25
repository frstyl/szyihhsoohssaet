local jyenqkaap = fk.CreateSkill {
  name = "jyenqkaap",
}

Fk:loadTranslationTable{
  ["jyenqkaap"] = "捐甲",
  [":jyenqkaap"] = "主旹,指定1其他角色發動,伱与其各己將僃區內牌置入手牌,本轉視爲殺。",

  ["#jyenqkaap"] = "選擇1其他角色 收回裝僃",

  ["@@jyenqkaap-turn"] = "捐甲",

  ["$jyenqkaap1"] = "論拳腳功夫,俺是不會輸之",
  -- ["$jyenqkaap2"] = "兄長定知此曲何意",
}

jyenqkaap:addEffect("active", {
  anim_type = "control",
  target_num = 1,
  prompt = "#jyenqkaap",
  can_use = function(self, player)
    return player:usedSkillTimes(jyenqkaap.name, Player.HistoryPhase) == 0
  end,
  target_filter = function(self, player, to_select, selected, selected_cards)
      return #selected == 0 and to_select~=player.id
  end,
  on_use = function(self, room, effect)
    local target = effect.tos[1]
    room:moveCardTo(target:getCardIds("e"), Card.PlayerHand, target, fk.ReasonJustMove, jyenqkaap.name, nil, true, target, "@@jyenqkaap-turn")
    room:moveCardTo(effect.from:getCardIds("e"), Card.PlayerHand, effect.from, fk.ReasonJustMove, jyenqkaap.name, nil, true, effect.from, "@@jyenqkaap-turn")

  end,
})

jyenqkaap:addEffect("filter", {
  card_filter = function(self, to_select, player)
    return  to_select:getMark("@@jyenqkaap-turn") >0 
      -- and table.contains(player:getCardIds("h"), to_select.id)
  end,
  view_as = function(self, player, to_select)
    local card = Fk:cloneCard("ssaet", to_select.suit, to_select.number)
    card.skillName = jyenqkaap.name
    return card
  end,
})
return jyenqkaap
