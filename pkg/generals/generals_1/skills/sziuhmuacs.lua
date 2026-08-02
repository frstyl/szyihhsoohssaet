local sziuhmuacs = fk.CreateSkill{
  name = "sziuhmuacs",
}

Fk:loadTranslationTable{
  ["sziuhmuacs"] = "守望",
  [":sziuhmuacs"] = "主旹,選擇1｢殺｣与1其它脚色發動.,伱与其各抽x(x爲至對方距離).此｢殺｣越過次數距離限制",  --

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
    room:addSkill("bypass_times")
    room:addSkill("bypass_distances")
    room:moveCardTo(effect.cards, Player.Hand, effect.tos[1], fk.ReasonGive, sziuhmuacs.name, nil, false, effect.from.id,{"@@sziuhmuacs-inhand",1,"bypass_times-inhand",1,"bypass_distances-inhand",1})
    if not from.dead then
    from:drawCards(from:distanceTo(to),sziuhmuacs.name)
    end
    if not to.dead then
    to:drawCards(to:distanceTo(from),sziuhmuacs.name)
    end
  end,
})



return sziuhmuacs
