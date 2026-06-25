local hsoohseevs = fk.CreateSkill {
  name = "hsoohseevs",
}

Fk:loadTranslationTable{
  ["hsoohseevs"] = "虎嘯",
  [":hsoohseevs"] = "伱可將1裝僃牌轉化爲猛虎下山使用發動",

  ["#hsoohseevs"] = "虎嘯：將1裝僃牌轉化爲猛虎下山使用",

  ["$hsoohseevs1"] = "仰天一嘯百獸驚",
  ["$hsoohseevs2"] = "小之輩統統給我抓起來",
}

hsoohseevs:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "maach_hsooh_hzaah_ssaen",
  prompt = "#hsoohseevs",
  handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and Fk:getCardById(to_select).type == Card.TypeEquip
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then return end
    local c = Fk:cloneCard("maach_hsooh_hzaah_ssaen")
    c.skillName = hsoohseevs.name
    c:addSubcard(cards[1])
    return c
  end,
  enabled_at_response = function(self, player, response)
    return not response
  end,
})

return hsoohseevs
