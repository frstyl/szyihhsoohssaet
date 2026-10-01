local maekmaek = fk.CreateSkill {
  name = "maekmaek",
}
Fk:loadTranslationTable{
  ["maekmaek"] = "脈脈",
  [":maekmaek"] = "印牌:以伱1♥️手牌轉化起動或演練｢糧草先行｣",

}

maekmaek:addEffect("viewas", { 
  anim_type = "drawcard", 
  pattern = "liac_tshoavh_seen_hzaac",
  prompt = "#maekmaek",
  mute_card = true,
  handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and Fk:getCardById(to_select).suit == Card.Heart
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then return end
    local c = Fk:cloneCard("liac_tshoavh_seen_hzaac")
    c.skillName = maekmaek.name
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
    return  true
  end,
})


return maekmaek
