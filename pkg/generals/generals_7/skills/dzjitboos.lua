local dzjitboos = fk.CreateSkill{
  name = "dzjitboos",
  tags = {Skill.Composite},
}

Fk:loadTranslationTable{
  ["dzjitboos"] = "疾步",
  [":dzjitboos"] = "➀印牌:虛擬起動或演練｢{殺/閃}｣｡發動前迻除技能牌名項至伱起動同名牌。➁恆續｡伱至其它脚色距離-1,若伱➀无｢閃｣項,其它脚色至伱距離+1",

  ["@dzjitboos_cards"] = "疾步",
  -- ["$dzjitboos1"] = "",

}
dzjitboos:addLoseEffect (function (self, player)
    player.room:setPlayerMark(player,"@dzjitboos_cards",0) 
end)

dzjitboos:addEffect("viewas", {
  pattern = ".|0|nosuit|none|ssaet,szjemh",
  anim_type = "defensive",
  prompt = "dzjitboos",
  card_filter = Util.FalseFunc,
  interaction = function(self, player)
    local all_names = table.filter({"ssaet", "szjemh"}, function (name)
      return not table.contains(player:getTableMark("@dzjitboos_cards"), name)
    end)
    local names = player:getViewAsCardNames(dzjitboos.name, all_names)
    if #names == 0 then return end
    return UI.CardNameBox {choices = names, all_choices = all_names }
  end,
  view_as = function(self, player, cards)
    if not self.interaction.data then return nil end
    local card = Fk:cloneCard(self.interaction.data)
    card.skillName = dzjitboos.name
    return card
  end,
  before_use = function(self, player, use)
    player.room:addTableMark(player, "@dzjitboos_cards", self.interaction.data)
  end,
})

dzjitboos:addLoseEffect(function (self, player, is_death)
  player.room:setPlayerMark(player, dzjitboos.name, 0)
end)

dzjitboos:addEffect(fk.PreCardUse, { --PreCardUse
  can_refresh = function(self, event, target, player, data)
    return target==player  and (data.card.trueName=="szjemh" or data.card.trueName=="ssaet" )
  end,
  on_refresh = function(self, event, target, player, data)
    if  data.card.trueName=="szjemh" then
      player.room:removeTableMark(player, "@dzjitboos_cards", "ssaet")
    else
      player.room:removeTableMark(player, "@dzjitboos_cards", "szjemh")
    end
  end,
})

-- dzjitboos:addEffect(fk.TurnStart, { --PreCardUse
--   can_refresh = function(self, event, target, player, data)
--     return target==player  
--   end,
--   on_refresh = function(self, event, target, player, data)
--       player.room:setPlayerMark(player, "@dzjitboos_cards", 0)
--   end,
-- })

dzjitboos:addEffect("distance", {
  correct_func = function(self, from, to)
    if to:hasSkill(dzjitboos.name) and  table.contains(from:getTableMark("@dzjitboos_cards"), "szjemh") then
      return 1
    end
    if from:hasSkill(dzjitboos.name) then
      return -1
    end
  end,
})
return dzjitboos
