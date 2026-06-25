local dziacstsoak = fk.CreateSkill {
  name = "dziacstsoak",
}

Fk:loadTranslationTable{
  ["dziacstsoak"] = "匠作",
  [":dziacstsoak"] = "當伱可使用打出{殺/閃},伱可將1{黑/紅}非基本牌轉化之發動｡使用後,若牌名与上次發動牌名同,伱抽1;不同,伱可弃置其它角色1牌",

  ["#dziacstsoak"] = "匠作 將1{黑/紅}非基本牌轉化爲{殺/閃}",
  ["@dziacstsoak"] = "匠作",

  ["#dziacstsoak-choose"] = "匠作 弃其它角色牌",

  ["$dziacstsoak1"] = "以靜制動以動制靜",
  ["$dziacstsoak1"] = "全力以赴一舉拿下",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

dziacstsoak:addEffect("viewas", {
  anim_type = "defensive",
  pattern = "ssaet,szjemh",
  prompt = "#dziacstsoak",
  mute_card = true,
  handly_pile = true,
  mute=true,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 
    and S.getCardTypeByName(Fk:getCardById(to_select).trueName)~=1
    and S.getCardTypeByName(Fk:getCardById(to_select).trueName)~=6
    and Fk:getCardById(to_select).color ~= Card.NoColor
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then return end
        local c = Fk:cloneCard("ssaet")
    if  Fk:getCardById(cards[1]).color ==Card.Red then
      c=Fk:cloneCard("szjemh")
    end
    c.skillName = dziacstsoak.name
    c:addSubcard(cards[1])
    return c
  end,
  before_use = function(self, player, use)
    local old=player:getMark("@dziacstsoak")
    new=use.card.trueName
    player.room:setPlayerMark(player,"@dziacstsoak",new)
    if old~=0 and new then
      use.extra_data=use.extra_data or {}
      if  old~=new then
        use.extra_data.dziacstsoak=true
      else
        use.extra_data.dziacstsoak=false
      end      
    end
  end,
  after_use = function(self, player, use)
    if not use.extra_data then return end
    if use.extra_data.dziacstsoak then
      local room=player.room
      local to = room:askToChoosePlayers(player, {
        min_num = 1,
        max_num = 1,
        targets = table.filter(room.alive_players,function(p)
          return p ~=player and not p:isNude()
        end),
        skill_name = dziacstsoak.name,
        prompt = "#dziacstsoak-choose",
        cancelable = true,
      })[1]
      local cid = room:askToChooseCard(player, { target = to, flag = "he", skill_name = dziacstsoak.name })
      room:throwCard({cid}, dziacstsoak.name, to, player)
      return
    end
    if use.extra_data.dziacstsoak==false then
      player:drawCards(1,dziacstsoak.name)
    end
  end,
  enabled_at_play = Util.TrueFunc,  --音
  enabled_at_response = Util.TrueFunc,
})

return dziacstsoak
