local sziuhmuacs = fk.CreateSkill{
  name = "sziuhmuacs",
}

Fk:loadTranslationTable{
  ["sziuhmuacs"] = "守望",
  [":sziuhmuacs"] = "階段限1,主動,選擇1殺与1其它角色發動.伱將此殺幖記交与該角色,伱与其各抽x(x爲至對方距離).守望幖記:不計入使用次數",

  ["#sziuhmuacs"] = "守望 選擇殺与目幖",

  ["@@sziuhmuacs-inhand"] = "守望",

  ["$sziuhmuacs1"] = "待來秊萅旹与君一序",

}

sziuhmuacs:addEffect("active", {
  anim_type = "drawcard",
  prompt = "#sziuhmuacs",
  card_num = 1,
  target_num = 1,
  max_phase_use_time = 1,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0  and Fk:getCardById(to_select).trueName == "ssaet"
  end,
  target_filter = function(self, player, to_select, selected)
    return #selected == 0 and to_select ~= player
  end,
  on_use = function(self, room, effect)
    local from =effect.from
    local to=effect.tos[1]
    room:moveCardTo(effect.cards, Player.Hand, effect.tos[1], fk.ReasonGive, sziuhmuacs.name, nil, false, effect.from.id,"@@sziuhmuacs-inhand")
    if not from.dead then
    from:drawCards(from:distanceTo(to),sziuhmuacs.name)
    end
    if not to.dead then
    to:drawCards(to:distanceTo(from),sziuhmuacs.name)
    end
  end,
})


sziuhmuacs:addEffect(fk.PreCardUse, {
  can_refresh = function (self, event, target, player, data)
    local subCards = Card:getIdList(data.card)
    return #subCards > 0 and
      table.every(subCards, function (id)
        return Fk:getCardById(id):getMark("@@sziuhmuacs-inhand") > 0
      end)
  end,
  on_refresh = function (self, event, target, player, data)
    data.extraUse = true
  end
})

return sziuhmuacs
