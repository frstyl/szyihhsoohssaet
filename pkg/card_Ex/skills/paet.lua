local paet = fk.CreateSkill {
  name = "paet_skill&",
  attached_equip = "paet",
}

-- Fk:loadTranslationTable{
-- ["paet"] = "故縱",
-- [":paet"] = "➀當其他角色可使用打出(虛)閃,伱可預使用打出發動,視爲其使用打出之,肰後伱可逐个弃該角色至多2牌,伱抽1➁當伱須使用打出閃,伱可預弃1非基本牌發動,視爲伱使用打出之",
-- ["#paet"] = "故縱: 代替 弃1非基本牌 視爲使用打出閃",
-- ["#paet-ask"] = "故縱: 代替 %src 使用打出閃",
-- ["#paet-discard"] = "故縱: 是否弃 %src 牌",
-- }

paet:addEffect("viewas", {--視爲使用? 使用虛牌?
  anim_type = "defensive",
  pattern = "szjemh",  --
  prompt = "#paet",
  mute_card = true,
  -- handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and Fk:getCardById(to_select).type ~= Card.TypeBasic and not player:prohibitDiscard(to_select)
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then
      return nil
    end
    local c = Fk:cloneCard("szjemh")
    c.skillName = paet.name
    c:addFakeSubcards(cards)
    return c
  end,
  before_use = function (self, player, use)
    local room = player.room
    room:throwCard(use.card.fake_subcards, paet.name, player, player)
  end,
})


return paet
