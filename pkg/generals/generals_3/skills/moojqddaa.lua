local moojqddaa = fk.CreateSkill{
  name = "moojqddaa",
}

Fk:loadTranslationTable{
  ["moojqddaa"] = "梅茶",
  [":moojqddaa"] = "印牌:以伱♣️手牌轉起動｢酒｣(无視次數制)。",

  ["#moojqddaa"] = "梅茶：梅花手牌當酒",

  ["$moojqddaa1"] = "我昰茶別有一番風味",
  ["$moojqddaa2"] = "好一个寬煎葉兒茶",
}

moojqddaa:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "tsiuh",
  prompt = "#moojqddaa",
  handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and Fk:getCardById(to_select).suit == Card.Club and
      table.contains(player:getCardIds("h"),to_select)
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then return nil end
    local c = Fk:cloneCard("tsiuh")
    c.skillName = moojqddaa.name
    c:addSubcard(cards[1])
    return c
  end,
  before_use = function(self, player, use)
    use.extraUse =true
  end,
})

moojqddaa:addEffect("targetmod", {
  bypass_times = function(self, player, skill, scope, card)
    return card --and scope == Player.HistoryPhase 
    and table.contains(card.skillNames, moojqddaa.name)
  end,
})


return moojqddaa