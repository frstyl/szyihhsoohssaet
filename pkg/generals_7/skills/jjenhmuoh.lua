local jjenhmuoh = fk.CreateSkill{
  name = "jjenhmuoh",
}

Fk:loadTranslationTable{
  ["jjenhmuoh"] = "演武",
  [":jjenhmuoh"] = "➀當伱可使用打出{殺/閃},伱可視爲于元旹機虛擬執行之,發動,伱迻除{殺/閃}項直至伱使用打出{閃/殺}。➁恆續｡伱至其它角色距離-1｡若伱➀无｢閃｣項,其它角色至伱距離+1",

  ["@jjenhmuoh_cards"] = "演武",
  -- ["$jjenhmuoh1"] = "",

}

jjenhmuoh:addEffect("viewas", {
  pattern = "ssaet,szjemh|0|nosuit|none",
  anim_type = "defensive",
  prompt = "jjenhmuoh",
  card_filter = Util.FalseFunc,
  interaction = function(self, player)
    local all_names = table.filter({"ssaet", "szjemh"}, function (name)
      return not table.contains(player:getTableMark("@jjenhmuoh_cards"), name)
    end)
    local names = player:getViewAsCardNames(jjenhmuoh.name, all_names)
    if #names == 0 then return end
    return UI.CardNameBox {choices = names, all_choices = all_names }
  end,
  view_as = function(self, player, cards)
    if not self.interaction.data then return nil end
    local card = Fk:cloneCard(self.interaction.data)
    card.skillName = jjenhmuoh.name
    return card
  end,
  before_use = function(self, player, use)
    player.room:addTableMark(player, "@jjenhmuoh_cards", self.interaction.data)
  end,
})

jjenhmuoh:addLoseEffect(function (self, player, is_death)
  player.room:setPlayerMark(player, jjenhmuoh.name, 0)
end)

jjenhmuoh:addEffect(fk.PreCardUse, { --PreCardUse
  can_refresh = function(self, event, target, player, data)
    return target==player  and (data.card.trueName=="szjemh" or data.card.trueName=="ssaet" )
  end,
  on_refresh = function(self, event, target, player, data)
    if  data.card.trueName=="szjemh" then
      player.room:removeTableMark(player, "@jjenhmuoh_cards", "ssaet")
    else
      player.room:removeTableMark(player, "@jjenhmuoh_cards", "szjemh")
    end
  end,
})

-- jjenhmuoh:addEffect(fk.TurnStart, { --PreCardUse
--   can_refresh = function(self, event, target, player, data)
--     return target==player  
--   end,
--   on_refresh = function(self, event, target, player, data)
--       player.room:setPlayerMark(player, "@jjenhmuoh_cards", 0)
--   end,
-- })

jjenhmuoh:addEffect("distance", {
  correct_func = function(self, from, to)
    if to:hasSkill(jjenhmuoh.name) and  table.contains(player:getTableMark("@jjenhmuoh_cards"), "szjemh") then
      return 1
    end
    if from:hasSkill(jjenhmuoh.name) then
      return -1
    end
  end,
})
return jjenhmuoh
