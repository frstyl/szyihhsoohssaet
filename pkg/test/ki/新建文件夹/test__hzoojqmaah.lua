local test__hzoojqmaah = fk.CreateSkill {
  name = "test__hzoojqmaah",
}

Fk:loadTranslationTable{
  ["test__hzoojqmaah"] = "回馬",
  [":test__hzoojqmaah"] = "印牌:起動或演練虛擬閃｡伱預轉化1牌爲｢殺｣起動發動,若此殺未致傷,中止次技能",

  ["#test__hzoojqmaah"] = "回馬：伱可起動殺,若致傷視爲伱起動閃",

  ["$test__hzoojqmaah1"] = "回馬定策,叫汝等有來无回",
  ["$test__hzoojqmaah2"] = "此計向西而示之已東",

  ["test__hzoojqmaah"] = "回馬",

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

test__hzoojqmaah:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "szjemh",  --
  prompt = "#test__hzoojqmaah",
  mute_card = false,
  interaction = function(self, player)
    local ps={}
    for _, p in ipairs(Fk:currentRoom().alive_players) do
      if p~=player then --canUseTo 檢測全部牌,若有1牌可轉化後對其起動,true
        table.insert(ps,tostring(p.seat)..">"..":"..p.id)
      end
    end
    -- table.sort(ps)
    -- ps=table.map(ps,function(p)
    --   return tostring(p)
    -- end)
    return UI.ComboBox {
      choices = ps,
      -- default=tostring(player.seat)
    }
  end,
  card_filter = function(self, player, to_select, selected)
    if not self.interaction.data then return end
    if  #selected == 0 then

    return true end
      
    -- local p=Fk:currentRoom():getPlayerBySeat(tonumber(self.interaction.data:split(">")[1]))
    -- local card=Fk:cloneCard("ssaet")
    -- card.skillName = test__hzoojqmaah.name
    -- card:addSubcard(to_select)
    -- return  player:canUseTo(card,p,{bypass_times=true,bypass_distances=false})  end
    
     
  end,
  view_as = function(self, player, cards)
    if not self.interaction.data then return end
    if #cards ~= 1 then return end

    local p=Fk:currentRoom():getPlayerBySeat(n)
    local card=Fk:cloneCard("ssaet")
    card.skillName = test__hzoojqmaah.name
    card:addSubcard(cards[1])
    if not player:canUseTo(card,p,{bypass_times=true,bypass_distances=false}) then return end
    
    local c = Fk:cloneCard("szjemh")
    c:addFakeSubcard(cards[1])
    c.skillName = test__hzoojqmaah.name
    return c
  end,
  before_use = function (self, player, use)
    local room = player.room


    local card=Fk:cloneCard("ssaet")
    card.skillName = test__hzoojqmaah.name
    card:addSubcard(use.card.fake_subcards[1])
    local use={  --bypase times
      from = player,
      tos = {Fk:currentRoom():getPlayerBySeat(tonumber(self.interaction.data:split(">")[1]))},
      card = card,
      -- disresponsiveList = table.simpleClone(room.players),
      extraUse=true,
    }
    room:useCard(use)
    if not use.damageDealt  then return test__hzoojqmaah.name end   --成則終止詢問

  end,
  enabled_at_play = Util.FalseFunc,
  enabled_at_response = function(self, player, response) 
    return  true
  end,
})


return test__hzoojqmaah
