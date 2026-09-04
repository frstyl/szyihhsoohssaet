local kijqtvoans_active = fk.CreateSkill {
  name = "kijqtvoans_active",
}

Fk:loadTranslationTable{
  ["kijqtvoans_active"] = "機斷",
  [":kijqtvoans_active"] = "機斷",


}

kijqtvoans_active:addEffect("active", {
  anim_type = "control",
  -- prompt = function (self, player, selected_cards, selected_targets)
  --   return "#kijqtvoans_active:::"..S.getPhaseString(data.phase).. ":"..player:usedSkillTimes(kijqtvoans.name, Player.HistoryTurn),
  -- end,
  card_num =  function (self, player)
    return player:usedSkillTimes("kijqtvoans", Player.HistoryTurn)
  end,
  target_num = 0,
  interaction = UI.ComboBox {choices = { "kijqtvoans-again", "kijqtvoans-to_skip" } },
  can_use = Util.TrueFunc,
  card_filter = function(self, player, to_select, selected)
    return 
    -- table.contains(player:getCardIds("h"), to_select)
    -- and  
    not player:prohibitResponse(Fk:getCardById(to_select))
  end,
  target_filter = Util.FalseFunc,
  on_use = function(self, room, effect)

  end,
})

return kijqtvoans_active
