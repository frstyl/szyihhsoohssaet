local ww = fk.CreateSkill {
  name = "ww",
}
Fk:loadTranslationTable{
  ["ww"] = "ww",
  [":ww"] = "www",

}
ww:addAcquireEffect(function (self, player)
    player.room:setPlayerMark(player,"@ww",1) 
end)

ww:addLoseEffect (function (self, player)
    player.room:setPlayerMark(player,"@ww",0) 
end)

ww:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "ssaet",
  prompt = "#ww",
  mute_card = true,
  handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and Fk:getCardById(to_select).color == Card.Red
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then return end
    local c = Fk:cloneCard("ssaet")
    c.skillName = ww.name
    c:addSubcard(cards[1])
    return c
  end,
  -- before_use = function(self, player, use)
  -- if Fk:getCardById(use.card.subcards[1]).type==Card.TypeTrick then
  --   use.extraUse =true
  --   end
  -- end,
  enabled_at_play = Util.TrueFunc,
  enabled_at_response = function(self, player, response) 
    return  not response 
  end,
})

ww:addEffect("targetmod", {
  bypass_times = function(self, player, skill, scope, card)
    if card and table.contains(card.skillNames,ww.name) and scope == Player.HistoryPhase then
      return true
    end
  end,
})
return ww
