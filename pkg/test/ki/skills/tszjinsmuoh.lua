local tszjinsmuoh = fk.CreateSkill {
  name = "tszjinsmuoh",
  tags = { Skill.Switch },
}

Fk:loadTranslationTable{
  ["tszjinsmuoh"] = "振武",  --奮武 振武
  [":tszjinsmuoh"] = "依序發動.印牌:以伱1➀紅➁牌轉化起動或演練｢殺｣｡",


  ["$tszjinsmuoh1"] = "想走,沒若麼容㑥",
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

tszjinsmuoh:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "ssaet",
  prompt = "#tszjinsmuoh",
  mute_card = true,
  handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0   and Fk:getCardById(to_select).color == player:getSwitchSkillState(tszjinsmuoh.name,true)+1
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then return end
    local c = Fk:cloneCard("ssaet")
    c.skillName = tszjinsmuoh.name
    c:addSubcard(cards[1])
    return c
  end,
  enabled_at_play = Util.TrueFunc,
  enabled_at_response = function(self, player, response) 
    return  true 
  end,
})



return tszjinsmuoh
