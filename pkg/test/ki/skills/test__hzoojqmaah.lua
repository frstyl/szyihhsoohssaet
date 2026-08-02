local test__hzoojqmaah = fk.CreateSkill {
  name = "test__hzoojqmaah",
}

Fk:loadTranslationTable{
  ["test__hzoojqmaah"] = "回馬",
  [":test__hzoojqmaah"] = "印牌:起動演練虛擬閃｡伱預轉化1牌爲｢殺｣起動(无視次數限制)發動,若此殺未致傷,中止次技能",

  ["#test__hzoojqmaah"] = "回馬：伱可起動殺,若致傷視爲伱起動閃",

  ["$test__hzoojqmaah1"] = "回馬定策,叫汝等有來无回",
  ["$test__hzoojqmaah2"] = "此計向西而示之已東",

  ["test__hzoojqmaah"] = "回馬",

  -- ["1>"] = "1位 %src",
  -- ["2>"] = "2位 %src",
  -- ["3>"] = "3位 %src",
  -- ["4>"] = "4位 %src",
  -- ["5>"] = "5位 %src",
  -- ["6>"] = "6位 %src",
  -- ["7>"] = "7位 %src",
  -- ["8>"] = "8位 %src",
  -- ["9>"] = "9位 %src",
  -- ["10>"] = "10位 %src",
  -- ["11>"] = "11位 %src",
  -- ["12>"] = "12位 %src",

}

test__hzoojqmaah:addEffect("viewas", {
  anim_type = "offensive",
  pattern = ".|.|.|.|szjemh",
  prompt = "#test__hzoojqmaah",
  -- mute_card = true,
  -- handly_pile = true,
  card_filter = function(self, player, to_select, selected) --可以過一遍
    return #selected == 0 
  end,
  view_as = function(self, player, cards)
    -- local c = Fk:cloneCard("szjemh")
    -- c.skillName = "hzoojqmaah"
    -- return c
    return nil
  end,
  target_filter = function(self, player, to_select, selected, selected_cards, c, extra_data)
    if not selected_cards[1] or selected[1] then return end


    local card=Fk:cloneCard("ssaet")
    card:addSubcard(selected_cards[1])
    card.skillName = "hzoojqmaah"
    return  card:getSkill(player):targetFilter(player, to_select, selected, _, card, {bypass_times=true}) --不繼承extra_data
  end,
  feasible = function(self, player, selected, selected_cards, card)
    if  #selected ~= 0 then
        local c = Fk:cloneCard("szjemh")
        c.skillName = "hzoojqmaah"
        return 
         player:canUseOrResponseInCurrent(c)
    end
  end,

  on_use = function(self, room, cardUseEvent, c, params)
    local player = cardUseEvent.from
    local tos =cardUseEvent.tos
    local use = room:useVirtualCard("ssaet",cardUseEvent.cards,player,tos,"hzoojqmaah",false,{bypass_distances=false,bypass_times=true})

    -- local ssaet=Fk:cloneCard("ssaet")
    -- ssaet.skillName = "hzoojqmaah"
    -- ssaet:addSubcard(cardUseEvent.cards[1])
    -- local use={
    --   from = player,
    --   tos = tos , 
    --   card = ssaet,
    --   extraUse=true,
    --   extra_data={
    --     bypass_distances=false,
    --     bypass_times=true,
    --   }
    -- }
    -- room:useCard(use)


    if not use.damageDealt  then
       return test__hzoojqmaah.name  --成則終止詢問
    else
      local c = Fk:cloneCard("szjemh")
      c.skillName = "hzoojqmaah"
      local use = {
          from = cardUseEvent.from,
          card = c,
        }
        if param and param.is_response then use.tos = {} end
      return use
    end
    --不再能起動閃? 肰占卜旹已過

  end,
  enabled_at_play = function(self, player) 
    return  true
  end,
  enabled_at_response = function(self, player, response) 
    return  true
  end,
})



return test__hzoojqmaah
