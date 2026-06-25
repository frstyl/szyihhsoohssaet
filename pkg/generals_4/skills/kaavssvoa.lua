local kaavssvoa = fk.CreateSkill {
  name = "kaavssvoa",
}

Fk:loadTranslationTable{
["kaavssvoa"] = "敎唆",
[":kaavssvoa"] = "主動.伱可將1♣手牌轉化爲借刀殺人使用,發動",

}

kaavssvoa:addEffect("viewas", {--視爲使用? 使用虛牌?
  anim_type = "defensive",
  pattern = "tsjas_toav_ssaet_nzjin",  --
  prompt = "#kaavssvoa",
  mute_card = true,
  -- handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and table.contains(player:getCardIds("h"),to_select) and Fk:getCardById(to_select).suit==Card.Club  
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then
      return nil
    end
    local c = Fk:cloneCard("tsjas_toav_ssaet_nzjin")
    c.skillName = kaavssvoa.name
    c:addSubcard(cards[1])
    return c
  end,
  enabled_at_response=Util.FalseFunc
})



return kaavssvoa
