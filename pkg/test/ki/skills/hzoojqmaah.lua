local hzoojqmaah = fk.CreateSkill {
  name = "hzoojqmaah",
}

Fk:loadTranslationTable{
  ["hzoojqmaah"] = "回馬",
  [":hzoojqmaah"] = "伱可起動{起動演練}(虛无點无色)閃旹,伱可轉化1牌爲殺預起動發動,起動後若此殺致傷,視爲伱{起動演練}閃.",

  ["#hzoojqmaah"] = "回馬：伱可起動殺,若致傷視爲伱起動閃",

  ["$hzoojqmaah1"] = "回馬定策,叫汝等有來无回",
  ["$hzoojqmaah2"] = "此計向西而示之已東",

  ["hzoojqmaah"] = "回馬",

  ["1>"] = "1位 %src",
  ["2>"] = "2位 %src",
  ["3>"] = "3位 %src",
  ["4>"] = "4位 %src",
  ["5>"] = "5位 %src",
  ["6>"] = "6位 %src",
  ["7>"] = "7位 %src",
  ["8>"] = "8位 %src",
  ["9>"] = "9位 %src",
  ["10>"] = "10位 %src",
  ["11>"] = "11位 %src",
  ["12>"] = "12位 %src",

}

hzoojqmaah:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "szjemh",  --
  prompt = "#hzoojqmaah",
  -- mute_card = true,
  handly_pile = true,
  include_equip=true,
  -- filter_pattern = {
  --   min_num = 1,
  --   max_num = 1,
  --   pattern = ".",
  -- },
  view_as = function(self, player, cards)
    -- if #cards ~= 1 then return end
    -- local c = Fk:cloneCard("szjemh")
    -- c.skillName = hzoojqmaah.name
    -- c:addFakeSubcard(cards[1])
    -- return c
    return nil
  end,
  target_filter = function(self, player, to_select, selected, selected_cards, card, extra_data)
    if #selected_cards==0 then return end
    local c = Fk:cloneCard("ssaet")
    c.skillName = hzoojqmaah.name
    c:addSubcard(selected_cards[1])
    return  player:canUseTo(c,to_select)
  end,
  card_filter = function(self, player, to_select, selected, selected_targets)  --先target?
    if #selected~=0 then return end
    return true
    -- local c = Fk:cloneCard("ssaet")
    -- c:addSubcard(to_select)
    -- c.skillName = hzoojqmaah.name
    -- return player:canUseTo(c, selected_targets[1])
    -- return  player:canUse(c)
  end,
  feasible = function(self, player, selected, selected_cards, card)
    return #selected == 1 and #selected_cards==1
  end,
  -- beforeUse(self, player, cardUseStruct)

  -- end,
  on_use = function(self, room, skillUseEvent, card, params)
    local player = skillUseEvent.from
    local c = Fk:cloneCard("ssaet")
    c:addSubcard(skillUseEvent.cards[1])
    c.skillName = hzoojqmaah.name
    local use = {
          from = player,
          tos = skillUseEvent.tos,
          card = c,
          extraUse = true,
        }
    room:useCard(use)
    if use.damageDealt and not player.dead then
      local c = Fk:cloneCard("szjemh")
      c.skillName = hzoojqmaah.name
          local new_use={
          from = player,
          -- tos = {to},
          card = c,
      }
      return new_use
    else
      return hzoojqmaah.name
    end
        
  end,
  enabled_at_play = Util.FalseFunc,
  enabled_at_response = function(self, player, response) --可用閃 且可用殺
    return  (response and not player:prohibitResponse(Fk:cloneCard("szjemh")))
    or  not player:prohibitUse(Fk:cloneCard("szjemh"))
  end,
})


return hzoojqmaah
